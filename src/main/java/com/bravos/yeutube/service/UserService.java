package com.bravos.yeutube.service;

import com.bravos.yeutube.model.User;
import com.bravos.yeutube.repository.UserRepository;

import java.util.List;

public class UserService {

    private final UserRepository userRepository = new UserRepository();

    public User findById(String id) {
        return userRepository.findById(id);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    public List<User> findAllByPage(int page, int pageSize) {
        return userRepository.findAll((page - 1) * pageSize, pageSize);
    }

    public User insert(User user) {
        return userRepository.insert(user);
    }

    public User update(User user) {
        return userRepository.update(user);
    }

    public long getCountUser() {
        return userRepository.countAll();
    }

    public List<User> findByKeyword(String key, int page, int pageSize) {
        return userRepository.findByKeyword(key, page, pageSize);
    }

    public Long countByKeyword(String key) {
        return userRepository.countByKeyword(key);
    }


}