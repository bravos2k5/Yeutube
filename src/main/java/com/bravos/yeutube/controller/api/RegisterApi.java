package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.dto.Activity;
import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.config.RedisConnectionPool;
import com.bravos.yeutube.service.AuthService;
import com.bravos.yeutube.service.LogService;
import com.bravos.yeutube.service.UserService;
import com.bravos.yeutube.utils.CookieUtils;
import com.bravos.yeutube.utils.EmailUtils;
import com.bravos.yeutube.utils.RegexUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.security.crypto.bcrypt.BCrypt;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/auth/register/1","/api/auth/register/2"})
public class RegisterApi extends HttpServlet {

    private UserService userService;
    private AuthService authService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        userService = new UserService();
        authService = new AuthService();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String uri = req.getRequestURI();
        if(uri.endsWith("1"))
            validateRegister(req, resp);
        else if(uri.endsWith("2"))
            handleRegister(req,resp);
    }

    private boolean isValidRequest(Request request) {
        try {
            return request != null &&
                    !request.getUsername().isBlank() &&
                    !request.getFullName().isBlank() &&
                    RegexUtils.checkPassword(request.getPassword()) > RegexUtils.CANT_USE &&
                    RegexUtils.isEmail(request.getEmail());
        } catch (Exception e) {
            return false;
        }
    }

    private void validateRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Request request = objectMapper.readValue(req.getReader(), Request.class);
        PrintWriter writer = resp.getWriter();

        if (!isValidRequest(request)) {
            writer.print(objectMapper.writeValueAsString(new Response(1, "Invalid parameters")));
            writer.flush();
            return;
        }

        if (authService.isExistUsername(request.getUsername())) {
            writer.print(objectMapper.writeValueAsString(new Response(1, "Tên tài khoản đã tồn tại!")));
            writer.flush();
            return;
        }

        String key = UUID.randomUUID().toString();
        int code = authService.generateRegisterOtp(key,request,600);
        new Thread(() -> EmailUtils.getInstance().sendEmail(request.getEmail(), "Mã xác nhận đăng ký tài khoản",
                "Mã xác nhận đăng ký tài khoản của bạn là: " + code +
                        " Mã xác thực có hiệu lực 10 phút, không chia sẻ mã này cho bất kì ai")).start();

        Cookie cookie = new Cookie("rKey",key);
        cookie.setHttpOnly(true);
        cookie.setMaxAge(600);
        resp.addCookie(cookie);
        writer.print(objectMapper.writeValueAsString(new Response(0,"")));
        writer.flush();

    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try(Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
            VerificationRequest request = objectMapper.readValue(req.getReader(),VerificationRequest.class);
            Cookie[] cookies = req.getCookies();
            PrintWriter writer = resp.getWriter();
            String key = null;
            Cookie cookie = CookieUtils.getCookie("rKey",cookies);

            if(cookie != null) {
                key = cookie.getValue();
            }

            Map<String,String> data = null;

            if (key != null) {
                data = jedis.hgetAll(key);
            }

            if(key == null || data == null || request == null || !BCrypt.checkpw(request.getCode(),data.get("code"))) {
                writer.print(objectMapper.writeValueAsString(new Response(1, "Mã xác thực không chính xác")));
                writer.flush();
                return;
            }

            User user = new User();
            user.setId(data.get("username"));
            user.setFullName(data.get("fullName"));
            user.setEmail(data.get("email"));
            user.setPassword(data.get("password"));
            User registeredUser = userService.insert(user);
            if (registeredUser == null) {
                writer.print(objectMapper.writeValueAsString(new Response(1, "Lỗi tạo tài khoản, thử lại sau")));
                writer.flush();
                return;
            }

            jedis.del(key);

            CookieUtils.deleteCookie("rKey",resp);

            UserInfo userInfo = new UserInfo(registeredUser);
            req.getSession().setAttribute("user", userInfo);
            resp.addCookie(authService.generateLoginCookie(userInfo,-1));
            writer.print(objectMapper.writeValueAsString(new Response(0, "")));
            writer.flush();
            new Thread(() -> EmailUtils.getInstance().sendEmail(user.getEmail(), "Đăng ký thành công",
                    "Chúc mừng tài khoản "
                            + user.getId() + " đã đăng ký tài khoản thành công")).start();
            Activity activity = new Activity(Activity.USER,String.format("<strong>%s</strong> đã đăng ký tài khoản mới",userInfo.getFullName()));
            LogService.insertLogActivity(activity);
        }
    }

    @Data
    public static class Request {
        private String username;
        private String fullName;
        private String email;
        private String password;
    }

    @Data
    private static class VerificationRequest {
        private String code;
    }

    @Data
    @AllArgsConstructor
    private static class Response {
        private int status;
        private String message;
    }

}
