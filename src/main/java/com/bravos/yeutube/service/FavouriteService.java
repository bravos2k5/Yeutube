package com.bravos.yeutube.service;

import com.bravos.yeutube.dto.LikeStatistic;
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

    public List<Favourite> findAll(int page, int pageSize) {
        return favouriteRepository.findAll((page - 1) * pageSize,pageSize);
    }

    public List<Favourite> findByUserId(String id) {
        return favouriteRepository.findByUserId(id, 0, 0);
    }

    public List<Favourite> findByUserId(String id, int page, int pageSize) {
        return favouriteRepository.findByUserId(id, (page - 1) * page, pageSize);
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

    public Long getTotalRow() {
        return favouriteRepository.countAll();
    }

    public Long getCountByUser(String id) {
        return favouriteRepository.countByUserId(id);
    }

    public List<LikeStatistic> getLikeStatistic(int page, int pageSize) {
        List<LikeStatistic> likeStatistics = favouriteRepository.getLikeStatistic((page - 1) * page,pageSize);
        likeStatistics.forEach(likeStatistic -> likeStatistic.setLikeCount(getLikeCountVideo(likeStatistic.getVideoId())));
        return likeStatistics;
    }

    public List<LikeStatistic> getLikeStatisticByTitle(String title, int page, int pageSize) {
        List<LikeStatistic> likeStatistics = favouriteRepository.getLikeStatisticByTitle(title,(page - 1) * pageSize, pageSize);
        likeStatistics.forEach(likeStatistic -> likeStatistic.setLikeCount(getLikeCountVideo(likeStatistic.getVideoId())));
        return likeStatistics;
    }

}
