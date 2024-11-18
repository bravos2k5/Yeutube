package com.bravos.yeutube.repository;

import com.bravos.yeutube.dto.ShareStatistic;
import com.bravos.yeutube.model.Share;

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

    public static void main(String[] args) {
        new ShareRepository().getShareStatistic().forEach(System.out::println);
    }

}
