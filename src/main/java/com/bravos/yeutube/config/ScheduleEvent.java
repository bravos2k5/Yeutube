package com.bravos.yeutube.config;

import com.bravos.yeutube.service.CountService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import redis.clients.jedis.Jedis;

import java.util.*;

public class ScheduleEvent {

    private final Timer updateViewTimer;
    private final Timer updateVisitTimer;
    private final CountService countService;

    public ScheduleEvent() {
        this.updateViewTimer = updateView();
        this.updateVisitTimer = updateVisitCount();
        countService = new CountService();
    }

    public void cancelAllProcess() {
        updateViewTimer.cancel();
        updateViewHandle();
        updateVisitTimer.cancel();
        updateVisitCountHandle();
    }

    private Timer updateView() {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                updateViewHandle();
            }
        };
        timer.scheduleAtFixedRate(task, 60000, 60000);
        return timer;
    }

    private Timer updateVisitCount() {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                updateViewHandle();
            }
        };
        timer.scheduleAtFixedRate(task,305000,305000);
        return timer;
    }

    private void updateVisitCountHandle() {
        countService.saveVisitCount();
    }

    private void updateViewHandle() {
        Map<String, String> viewsMap;
        try(Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            viewsMap = jedis.hgetAll("viewsList");
            jedis.del("viewsList");
            if (viewsMap.isEmpty()) {
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
            e.printStackTrace();
        }
    }
}

