package com.bravos.yeutube.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import redis.clients.jedis.Jedis;

import java.util.*;

public class ScheduleEvent {

    private final Timer updateViewTimer;

    public ScheduleEvent() {
        this.updateViewTimer = updateView();
    }

    public void cancelAllProcess() {
        updateViewHandle();
        updateViewTimer.cancel();
    }

    private Timer updateView() {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                updateViewHandle();
            }
        };
        timer.scheduleAtFixedRate(task, 300000, 300000);
        return timer;
    }

    private void updateViewHandle() {
        Jedis jedis = RedisConnectionPool.getInstance().getJedisPool().getResource();
        Map<String, String> viewsMap = jedis.hgetAll("viewsList");
        jedis.del("viewsList");
        jedis.close();
        if (viewsMap.isEmpty()) {
            return;
        }
        try (EntityManager entityManager = HibernateConfig.entityManager()) {
            String rootSql = "UPDATE Video SET views = views + ? WHERE id = ? ";
            int maxBatchSize = 50;
            while (!viewsMap.isEmpty()) {
                int i = 0;
                int j = 0;
                String sql = rootSql.repeat(Math.min(viewsMap.size(), maxBatchSize));
                EntityTransaction transaction = entityManager.getTransaction();
                List<String> processedKey = new ArrayList<>();
                transaction.begin();
                try {
                    Query query = entityManager.createNativeQuery(sql);
                    for (var x : viewsMap.entrySet()) {
                        ++j;
                        query.setParameter(++i, x.getValue());
                        query.setParameter(++i, UUID.fromString(x.getKey()));
                        processedKey.add(x.getKey());
                        if (j == maxBatchSize || j == viewsMap.size()) {
                            query.executeUpdate();
                            transaction.commit();
                            break;
                        }
                    }
                    processedKey.forEach(viewsMap::remove);
                    processedKey.clear();
                } catch (Exception e) {
                    transaction.rollback();
                    throw new RuntimeException(e);
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

