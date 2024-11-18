package com.bravos.yeutube.config;

import com.bravos.yeutube.utils.PropsUtils;
import lombok.Getter;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;

import java.util.Properties;

@Getter
public class RedisConnectionPool {

    private final JedisPool jedisPool;

    private final String host;
    private final int port;
    private final String username;
    private final String password;

    private RedisConnectionPool() {
        JedisPoolConfig config = getJedisConfig();
        Properties properties = PropsUtils.getInstance().getResourceProperties();
        host = properties.getProperty("redis.host");
        port = Integer.parseInt(properties.getProperty("redis.port"));
        username = properties.getProperty("redis.username");
        password = properties.getProperty("redis.password");
        jedisPool = new JedisPool(config, host,port,10000,username,password);
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
        return config;
    }

    public void shutdown() {
        if(jedisPool != null) {
            jedisPool.close();
        }
    }


}
