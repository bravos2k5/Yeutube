package com.bravos.yeutube.repository;

import com.bravos.yeutube.dto.VideoFavouriteDto;
import com.bravos.yeutube.model.Video;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

public class VideoRepository extends Repository<Video, UUID> {

    public VideoRepository() {
        super(Video.class);
    }

    public List<Video> findVideoByPage(int page, int pageSize, String type) {
        String hql = "FROM Video v WHERE active = true ORDER BY v." + type + " DESC";
        return findByHql(hql, null, (page - 1) * pageSize, pageSize);
    }

    public List<VideoFavouriteDto> findVideoAndCountLike() {
        String hql = "SELECT v.title, COUNT(f) as likes, v.active FROM Video v" +
                " LEFT JOIN Favourite f ON f.video.id = v.id" +
                " GROUP BY v.id, v.title, v.active";
        return executeHqlSingleData(hql, VideoFavouriteDto.class);
    }

    public List<Video> getMostFavouriteVideo(int page, int pageSize) {
        String hql = "FROM Video v" +
                " LEFT JOIN v.favourites f" +
                " WHERE v.active = true" +
                " GROUP BY v" +
                " ORDER BY COUNT(f) DESC";
        return findByHql(hql, null, (page - 1) * pageSize, pageSize);
    }

    public List<Video> getWorstFavouriteVideo(int page, int pageSize) {
        String hql = "FROM Video v WHERE v NOT IN(SELECT f.video FROM Favourite f)";
        return findByHql(hql, null, (page - 1) * pageSize, pageSize);
    }

    public List<Video> getShareVideoByYear(int year) {
        String hql = "SELECT s.video FROM Share s WHERE YEAR(s.sharedDate) = :year";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("year", year);
        return findByHql(hql, dataMap);
    }

    public Long countByTitle(String title) {
        String hql = "SELECT COUNT(v) FROM Video v WHERE v.title LIKE :title";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("title", "%" + title + "%");
        return executeHqlSingleData(hql, dataMap, Long.class).getFirst();
    }

    public Long getCountVideo() {
        String hql = "SELECT COUNT(v) FROM Video v";
        return executeHqlSingleData(hql, null, Long.class).getFirst();
    }

    public List<Video> findByTitle(String title, int page, int pageSize) {
        String hql = "FROM Video v WHERE v.title LIKE :title AND v.active = true";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("title", "%" + title + "%");
        return findByHql(hql, dataMap, (page - 1) * pageSize, pageSize);
    }

    public List<Video> findFavouriteVideo(String id, int page, int pageSize) {
        String hql = "SELECT f.video FROM Favourite f WHERE f.user.id = :id AND f.video.active = true";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("id", id);
        return findByHql(hql, dataMap, (page - 1) * pageSize, pageSize);
    }

    public Long getCountFavouriteVideo(String id) {
        String hql = "SELECT COUNT(f.video) FROM Favourite f WHERE f.user.id = :id AND f.video.active = true";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("id", id);
        return executeHqlSingleData(hql, dataMap, Long.class).getFirst();
    }

}