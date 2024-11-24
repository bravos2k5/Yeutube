package com.bravos.yeutube.service;

import com.bravos.yeutube.controller.api.RegisterApi;
import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.config.RedisConnectionPool;
import com.bravos.yeutube.repository.UserRepository;
import com.bravos.yeutube.utils.JwtUtils;
import jakarta.servlet.http.Cookie;
import org.springframework.security.crypto.bcrypt.BCrypt;
import redis.clients.jedis.Jedis;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class AuthService {

    private final UserRepository userRepository = new UserRepository();
    private final Random random = new Random();

    public User authenticate(String username, String rawPassword) {
        User user = userRepository.findByUsername(username);
        if(user == null) {
            return null;
        }
        if(BCrypt.checkpw(rawPassword, user.getPassword()))
            return user;
        return null;
    }

    public boolean isExistUsername(String username) {
        return userRepository.isExistUsername(username);
    }

    public int generateRegisterOtp(String key, RegisterApi.Request request, int expSecond) {
        try(Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            int code = random.nextInt(100000,999999);
            Map<String, String> data = new HashMap<>();
            data.put("username",request.getUsername());
            data.put("password",BCrypt.hashpw(request.getPassword(),BCrypt.gensalt()));
            data.put("email",request.getEmail());
            data.put("code", BCrypt.hashpw(String.valueOf(code),BCrypt.gensalt()));
            jedis.hset(key,data);
            jedis.expire(key,expSecond);
            return code;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public Cookie generateLoginCookie(UserInfo user, int expSeconds) {
        String token = JwtUtils.generateToken(user,expSeconds > 0 ? expSeconds * 1000L : 3600 * 12);
        Cookie cookie = new Cookie("accessToken",token);
        if (expSeconds > 0) {
            cookie.setMaxAge(expSeconds);
        }
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        return cookie;
    }

    public Cookie getAccessToken(Cookie[] cookies) {
        for(Cookie cookie : cookies) {
            if(cookie.getName().equals("accessToken")) {
                return cookie;
            }
        }
        return null;
    }

}
