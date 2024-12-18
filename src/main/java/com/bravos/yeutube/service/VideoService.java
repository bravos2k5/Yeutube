package com.bravos.yeutube.service;

import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.config.RedisConnectionPool;
import com.bravos.yeutube.utils.CookieUtils;
import com.bravos.yeutube.utils.PropsUtils;
import com.bravos.yeutube.utils.RedisUtils;
import com.bravos.yeutube.repository.VideoRepository;
import com.bravos.ytbcraw.YtbService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.Cookie;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.SetParams;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class VideoService {

    private final VideoRepository videoRepository = new VideoRepository();

    public static final String VIEWS = "views";
    public static final String CREATED_TIME = "createdTime";

    public Video findById(UUID id) {
        return videoRepository.findById(id);
    }

    public List<Video> findAll() {
        return videoRepository.findAll();
    }

    public List<Video> findAll(int page, int pageSize) {
        return videoRepository.findAll((page - 1) * pageSize, pageSize);
    }

    public Video insert(Video video) {
        return videoRepository.insert(video);
    }

    public Video update(Video video) {
        return videoRepository.update(video);
    }

    public List<Video> findByTitle(String title) {
        return videoRepository.findByTitle(title,0,0);
    }

    public List<Video> findByTitle(String title, int page, int pageSize) {
        return videoRepository.findByTitle(title,page,pageSize);
    }

    public void updateViewCount(UUID id) {
        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String key = "viewsList";
            String fieldName = id.toString();
            String value = jedis.hget(key,fieldName);
            if (value != null) {
                jedis.hincrBy(key, fieldName, 1);
                return;
            }
            String lockKey = "lock:" + key + ":" + id;
            String lockValue = UUID.randomUUID().toString();
            String lockResult = jedis.set(lockKey, lockValue, SetParams.setParams().nx().px(500));
            if (lockResult.equals("OK")) {
                try {
                    jedis.hset(key,fieldName, "1");
                } finally {
                    String lKey = jedis.get(lockKey);
                    if (lKey != null && lKey.equals(lockValue)) {
                        jedis.del(lockKey);
                    }
                }
            }
            else {
                try {
                    Thread.sleep(300);
                    jedis.hincrBy(key,fieldName,1);
                } catch (InterruptedException | NumberFormatException e) {
                    Thread.currentThread().interrupt();
                    throw new RuntimeException("Error when updating view count");
                }
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<Video> getMostLikeVideo(int page, int maxPage) {
        return videoRepository.getMostFavouriteVideo(page,maxPage);
    }

    public Long getIncreaseViewCount(UUID id) {
        try (Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            String key = "viewsList";
            String fieldName = id.toString();
            String value = jedis.hget(key,fieldName);
            return value == null ? 0 : Long.parseLong(value);
        } catch (RuntimeException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Video> getHomepageVideos(int page, int pageSize, String type) {
        return videoRepository.findVideoByPage(page, pageSize, type);
    }

    public Long getVideoCount() {
        return RedisUtils.getKeyWithLockCache("videoCount", Long.class,
                120,300, 200,videoRepository::getCountVideo);
    }

    public Long getMaxPageVideo(int pageSize) {
        return getMaxPage(getVideoCount(),pageSize);
    }

    public Long getMaxPageFavourite(String id, int pageSize) {
        return getMaxPage(getFavouriteVideoCount(id),pageSize);
    }

    public Long getMaxPageSearch(String keyword, int pageSize) {
        return getMaxPage(videoRepository.countByTitle(keyword),pageSize);
    }

    public List<Video> getFavouriteVideo(String id, int page, int pageSize) {
        return videoRepository.findFavouriteVideo(id,page,pageSize);
    }

    public Long getFavouriteVideoCount(String id) {
        return videoRepository.getCountFavouriteVideo(id);
    }

    public Long getMaxPage(Long videoCount, int pageSize) {
        return (long) Math.ceil((double) videoCount / pageSize);
    }

    public List<UUID> getRecentViewsList(Cookie[] cookies) throws JsonProcessingException {
        Cookie cookie = CookieUtils.getCookie("recentViews", cookies);
        if (cookie != null) {
            return new ObjectMapper().readValue(URLDecoder.decode(cookie.getValue(), StandardCharsets.UTF_8), new TypeReference<>() {});
        }
        return new ArrayList<>();
    }

    public YtbService getYtbService() {
        return new YtbService(PropsUtils.getInstance().getResourceProperties().getProperty("api.key.youtube"));
    }


}
