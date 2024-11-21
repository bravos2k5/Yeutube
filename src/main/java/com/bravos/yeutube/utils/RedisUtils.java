package com.bravos.yeutube.utils;

import com.bravos.yeutube.config.RedisConnectionPool;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.params.SetParams;

import java.util.UUID;
import java.util.function.Supplier;

public class RedisUtils {


    /**
     *
     * @param key key trên redis
     * @param clazz return class
     * @param cacheExpSeconds TTL
     * @param lockExpMs TTL lock key
     * @param retryMs thời gian retry khi lấy key bị fail
     * @param fallBackFunction fn lấy dữ liệu từ database khi miss cache
     * @return value của key
     * @param <T> các wrap class
     */
    public static <T> T getKeyWithLockCache(String key, Class<T> clazz, long cacheExpSeconds,
                                            long lockExpMs, long retryMs , Supplier<T> fallBackFunction) {
        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String value = jedis.get(key);

            if (value != null) {
                return parseValue(value, clazz);
            }

            String lockKey = "lock:" + key;
            String lockValue = UUID.randomUUID().toString();
            String lockResult = jedis.set(lockKey, lockValue, SetParams.setParams().nx().px(lockExpMs));

            if ("OK".equals(lockResult)) {
                try {
                    T result = fallBackFunction.get();
                    jedis.set(key, result.toString());
                    if (cacheExpSeconds > 0) {
                        jedis.expire(key,cacheExpSeconds);
                    }
                    return result;
                } finally {
                    if (lockValue.equals(jedis.get(lockKey))) {
                        jedis.del(lockKey);
                    }
                }
            } else {
                int retryTimes = 0;
                while (retryTimes < 3) {
                    try {
                        value = jedis.get(key);
                        if(value != null) {
                            return parseValue(value,clazz);
                        }
                        ++retryTimes;
                        Thread.sleep(retryMs);
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                        throw new RuntimeException("Error when waiting for cache", e);
                    }
                }
                T result = fallBackFunction.get();
                jedis.set(key, result.toString());
                if(cacheExpSeconds > 0) {
                    jedis.expire(key,cacheExpSeconds);
                }
                return result;
            }
        }
    }

    /**
     *
     * @param key key trên redis
     * @param clazz return class
     * @param field field của map value
     * @param cacheExpSeconds TTL
     * @param lockExpMs TTL lock key
     * @param fallBackFunction fn lấy dữ liệu từ db khi miss cache
     * @return value của key của map value
     * @param <T> các wrap class
     */
    public static <T> T getHKeyWithLockCache(String key, Class<T> clazz, String field, long cacheExpSeconds,
                                              long lockExpMs, Supplier<T> fallBackFunction) {

        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String value = jedis.hget(key,field);
            if (value != null) {
                return parseValue(value, clazz);
            }
            String lockKey = "lock:" + key + ":" + field;
            String lockValue = UUID.randomUUID().toString();
            String lockResult = jedis.set(lockKey, lockValue, SetParams.setParams().nx().px(lockExpMs));

            if ("OK".equals(lockResult)) {
                try {
                    T result = fallBackFunction.get();
                    jedis.hset(key, field, result.toString());
                    jedis.expire(key,cacheExpSeconds);
                    return result;
                } finally {
                    if (lockValue.equals(jedis.get(lockKey))) {
                        jedis.del(lockKey);
                    }
                }
            } else {
                try {
                    Thread.sleep(200);
                    return parseValue(jedis.hget(key,field), clazz);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    throw new RuntimeException("Error when waiting for cache", e);
                }
            }
        }
    }

    private static <T> T parseValue(String value, Class<T> clazz) {
        if (clazz == String.class) {
            return clazz.cast(value);
        } else if (clazz == Long.class) {
            return clazz.cast(Long.parseLong(value));
        } else if (clazz == Integer.class) {
            return clazz.cast(Integer.parseInt(value));
        } else if (clazz == Boolean.class) {
            return clazz.cast(Boolean.parseBoolean(value));
        } else if(clazz == Double.class) {
            return clazz.cast(Double.parseDouble(value));
        }
        throw new IllegalArgumentException("Unsupported class type: " + clazz.getName());
    }

}
