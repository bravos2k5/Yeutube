package com.bravos.yeutube.repository;

import com.bravos.yeutube.model.User;

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

}
