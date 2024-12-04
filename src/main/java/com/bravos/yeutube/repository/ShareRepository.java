package com.bravos.yeutube.repository;

import com.bravos.yeutube.dto.ShareStatistic;
import com.bravos.yeutube.model.Share;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ShareRepository extends Repository<Share,Long> {

    public ShareRepository() {
        super(Share.class);
    }

    public List<Share> findByUserId(String userId) {
        String hql = "FROM Share s WHERE s.user.id = :userId";
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("userId",userId);
        return findByHql(hql,dataMap);
    }

    public List<ShareStatistic> getShareStatistic() {
        String hql = "SELECT s.video.title, COUNT(s), MIN(s.sharedDate), MAX(s.sharedDate) FROM Share s GROUP BY s.video ";
        return executeHqlSingleData(hql, ShareStatistic.class);
    }

    public Long countByDate(Date date) {
        String hql = "SELECT COUNT(s) FROM Share s WHERE CAST(s.sharedDate AS date) = CAST(:date AS date)";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("date", date);
        return executeHqlSingleData(hql, dataMap, Long.class).getFirst();
    }

    public Long countByTitle(String title) {
        String hql = "SELECT COUNT(s) FROM Share s WHERE s.video.title LIKE :title";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("title", "%" + title + "%");
        return executeHqlSingleData(hql,dataMap, Long.class).getFirst();
    }

    public List<Share> findByVideoTitle(String title, int offset, int limit) {
        String hql = "FROM Share s WHERE s.video.title LIKE :title";
        Map<String, Object> dataMap = new HashMap<>();
        dataMap.put("title", "%" + title + "%");
        return findByHql(hql,dataMap,offset,limit);
    }

}
