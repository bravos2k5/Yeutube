package com.bravos.yeutube.service;

import com.bravos.yeutube.model.User;
import com.bravos.yeutube.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.util.List;

public class UserService {

    private final UserRepository userRepository = new UserRepository();

    public User findById(String id, String... lazyLoaders) {
        return userRepository.findById(id,lazyLoaders);
    }

    public List<User> findAll(String... lazyLoaders) {
        return userRepository.findAll(lazyLoaders);
    }

    public User insert(User user) {
        return userRepository.insert(user);
    }

    public User update(User user) {
        return userRepository.update(user);
    }



}