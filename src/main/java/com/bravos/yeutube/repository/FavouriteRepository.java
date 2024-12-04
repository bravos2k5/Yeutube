package com.bravos.yeutube.repository;

import com.bravos.yeutube.dto.LikeStatistic;
import com.bravos.yeutube.model.Favourite;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.model.Video;

import java.util.*;

public class FavouriteRepository extends Repository<Favourite,Long> {

    public FavouriteRepository() {
        super(Favourite.class);
    }

    public void insert(String userId, UUID videoId) {
        Favourite favourite = new Favourite();
        User user = new User();
        user.setId(userId);
        Video video = new Video();
        video.setId(videoId);
        favourite.setUser(user);
        favourite.setVideo(video);
        this.insert(favourite);
    }

    public void deleteByVideoIdAndUserId(String username, UUID videoId) {
        String hql = "DELETE FROM Favourite f WHERE f.user.id = :username AND f.video.id = :videoId";
        Map<String,Object> params = new HashMap<>();
        params.put("username",username);
        params.put("videoId", videoId);
        executeUpdate(hql,params);
    }

    public List<Favourite> findByUserId(String userId, int offset, int limit) {
        String hql = "FROM Favourite f WHERE f.user.id LIKE :userId";
        Map<String, Object> params = new HashMap<>();
        params.put("userId","%" + userId + "%");
        return findByHql(hql,params, offset, limit);
    }

    public Favourite findByUserIdAndVideoId(String username, UUID videoId) {
        String hql = "FROM Favourite f WHERE f.user.id = :username AND f.video.id = :videoId";
        Map<String,Object> params = new HashMap<>();
        params.put("username",username);
        params.put("videoId", videoId);
        try {
            return findByHql(hql,params).getFirst();
        } catch (NoSuchElementException e) {
            return null;
        }
    }

    public List<LikeStatistic> getLikeStatistic(int offset, int limit) {
        String hql = "SELECT v.id, v.title, COUNT(f), MAX(f.likedDate), MIN(f.likedDate) " +
                "FROM Video v " +
                "LEFT JOIN Favourite f ON v.id = f.video.id " +
                "GROUP BY v.id, v.title";
        return executeHqlSingleData(hql, offset, limit, LikeStatistic.class);
    }

    public List<LikeStatistic> getLikeStatisticByTitle(String title, int offset, int limit) {
        String hql = "SELECT v.id, v.title, COUNT(f), MAX(f.likedDate), MIN(f.likedDate) " +
                "FROM Video v " +
                "LEFT JOIN Favourite f ON v.id = f.video.id " +
                "WHERE v.title LIKE :title " +
                "GROUP BY v.id, v.title";
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("title", "%" + title + "%");
        return executeHqlSingleData(hql, dataMap, offset, limit, LikeStatistic.class);
    }


    public Long getLikeCount(UUID videoId) {
        String hql = "SELECT COUNT(f) FROM Favourite f WHERE f.video.id = :videoId";
        Map<String,Object> params = new HashMap<>();
        params.put("videoId",videoId);
        try {
            return executeHqlSingleData(hql,params, Long.class).getFirst();
        } catch (NoSuchElementException e) {
            throw new RuntimeException("Lỗi lấy lượt thích");
        }
    }

    public Long countByUserId(String id) {
        String hql = "SELECT COUNT(f) FROM Favourite f WHERE f.user.id = :id";
        Map<String,Object> params = new HashMap<>();
        params.put("id",id);
        return executeHqlSingleData(hql,params, Long.class).getFirst();
    }

}
