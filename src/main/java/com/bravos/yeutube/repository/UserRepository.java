package com.bravos.yeutube.repository;

import com.bravos.yeutube.model.User;
import com.bravos.yeutube.utils.RegexUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserRepository extends Repository<User,String> {

    public UserRepository() {
        super(User.class);
    }

    public User findByUsername(String username) {
        return findById(username);
    }

    public boolean isExistUsername(String username) {
        return findByUsername(username) != null;
    }

    public List<User> findByKeyword(String key, int page, int pageSize) {
        String hql = "FROM User u WHERE ";
        if(RegexUtils.isEmail(key)) {
            hql += "u.email";
        }
        else {
            hql += "u.fullName";
        }
        hql += " LIKE :key";
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("key", "%" + key + "%");
        return findByHql(hql,dataMap, (page - 1) * pageSize, pageSize);
    }

    public Long countByKeyword(String key) {
        String hql = "SELECT COUNT(u) FROM User u WHERE ";
        if(RegexUtils.isEmail(key)) {
            hql += "u.email";
        }
        else {
            hql += "u.fullName";
        }
        hql += " LIKE :key";
        Map<String,Object> dataMap = new HashMap<>();
        dataMap.put("key", "%" + key + "%");
        return executeHqlSingleData(hql,dataMap, Long.class).getFirst();
    }

}
