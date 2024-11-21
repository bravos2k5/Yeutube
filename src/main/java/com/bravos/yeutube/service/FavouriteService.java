package com.bravos.yeutube.service;

import com.bravos.yeutube.model.Favourite;
import com.bravos.yeutube.config.RedisConnectionPool;
import com.bravos.yeutube.utils.RedisUtils;
import com.bravos.yeutube.repository.FavouriteRepository;
import redis.clients.jedis.Jedis;

import java.util.List;
import java.util.UUID;

public class FavouriteService {

    private final FavouriteRepository favouriteRepository = new FavouriteRepository();

    public List<Favourite> findAll() {
        return favouriteRepository.findAll();
    }

    public List<Favourite> findByUserId(String id) {
        return favouriteRepository.findByUserId(id);
    }

    public long likeVideo(String username, UUID videoId) {
        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String key = "like:" + videoId;
            String value = jedis.get(key);
            if (value == null) {
                getLikeCountVideo(videoId);
            }
            favouriteRepository.insert(username,videoId);
            return jedis.incr(key);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public long unLikeVideo(String username, UUID videoId) {
        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String key = "like:" + videoId;
            String value = jedis.get(key);
            if (value == null) {
                getLikeCountVideo(videoId);
            }
            favouriteRepository.deleteByVideoIdAndUserId(username,videoId);
            return jedis.decr(key);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public boolean isLiked(String username, UUID videoId) {
        Favourite favourite = favouriteRepository.findByUserIdAndVideoId(username,videoId);
        return favourite != null;
    }

    public Long getLikeCountVideo(UUID id) {
        return RedisUtils.getKeyWithLockCache("like:" + id, Long.class,
                300, 200, 200, () -> favouriteRepository.getLikeCount(id));
    }

}
