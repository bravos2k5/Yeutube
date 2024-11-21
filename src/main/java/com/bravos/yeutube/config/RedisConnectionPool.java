package com.bravos.yeutube.config;

import com.bravos.yeutube.utils.PropsUtils;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.time.Duration;
import java.util.Properties;

public class RedisConnectionPool {

    private final JedisPool jedisPool;

    private RedisConnectionPool() {
        JedisPoolConfig config = getJedisConfig();
        Properties properties = PropsUtils.getInstance().getResourceProperties();
        if(properties == null) {
            throw new RuntimeException("Redis config error");
        }
        String host = properties.getProperty("redis.host");
        int port = Integer.parseInt(properties.getProperty("redis.port"));
        String username = properties.getProperty("redis.username", "");
        String password = properties.getProperty("redis.password", "");
        jedisPool = new JedisPool(config, host, port,20000, username, password);
    }

    private static class SingletonHelper {
        private static final RedisConnectionPool INSTANCE = new RedisConnectionPool();
    }

    public static RedisConnectionPool getInstance() {
        return SingletonHelper.INSTANCE;
    }

    private JedisPoolConfig getJedisConfig() {
        JedisPoolConfig config = new JedisPoolConfig();
        config.setMaxTotal(20);
        config.setMinIdle(5);
        config.setMaxIdle(10);
        config.setBlockWhenExhausted(true);
        config.setMaxWait(Duration.ofSeconds(30));
        config.setTimeBetweenEvictionRuns(Duration.ofSeconds(30));
        config.setMinEvictableIdleDuration(Duration.ofSeconds(60));
        config.setTestOnBorrow(true);
        config.setTestOnReturn(true);
        return config;
    }

    public JedisPool getJedisPool() {
        try {
            return jedisPool;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Jedis getResource() {
        return getJedisPool().getResource();
    }

    public void shutdown() {
        if(jedisPool != null) {
            jedisPool.close();
            System.out.println("Redis connection closed");
        }
    }


}
