package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.config.RedisConnectionPool;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.service.AuthService;
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
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCrypt;
import redis.clients.jedis.Jedis;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = {
        "/api/auth/forget/check-username",
        "/api/auth/forget/verify-code",
        "/api/auth/forget/reset-password"
})
public class ForgetPasswordApi extends HttpServlet {

    private AuthService authService;
    private UserService userService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        authService = new AuthService();
        userService = new UserService();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String uri = req.getRequestURI();
        if(uri.endsWith("check-username")) {
            checkUsername(req,resp);
            return;
        }
        if(uri.endsWith("verify-code")) {
            verifyCode(req,resp);
            return;
        }
        if(uri.endsWith("reset-password")) {
            resetPassword(req,resp);
        }
    }

    public void checkUsername(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            CheckUsernameRequest request = objectMapper.readValue(req.getReader(), CheckUsernameRequest.class);
            User user = userService.findById(request.getUsername());
            if(user == null) {
                Response response = new Response(1,"Không tìm thấy username");
                sendResponse(response,resp);
                return;
            }
            String key = UUID.randomUUID().toString();
            int code = authService.generateForgetPasswordOtp(key,user.getId(),900);
            new Thread(() -> EmailUtils.getInstance().sendEmail(user.getEmail(),"Mã nè","Code là: " + code + "\n Hiệu lực 15 phút")).start();
            Cookie cookie = new Cookie("fKey",key);
            cookie.setMaxAge(900);
            cookie.setHttpOnly(true);
            resp.addCookie(cookie);
            sendResponse(new Response(0, RegexUtils.maskEmail(user.getEmail())),resp);
        } catch (Exception e) {
            sendResponse(new Response(1, "Có lỗi xảy ra"),resp);
        }
    }

    private void verifyCode(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cookie[] cookies = req.getCookies();
        Cookie fKey = CookieUtils.getCookie("fKey",cookies);
        if(fKey != null) {
            try(Jedis jedis = RedisConnectionPool.getInstance().getResource()) {
                Map<String,String> dataKey = jedis.hgetAll(fKey.getValue());
                if(dataKey != null) {
                    VerifyCodeRequest verifyRequest = objectMapper.readValue(req.getReader(), VerifyCodeRequest.class);
                    if(verifyRequest.getUsername().equals(dataKey.get("username"))
                    && BCrypt.checkpw(verifyRequest.getCode(),dataKey.get("code"))) {
                        String cCode = dataKey.get("cCode");
                        Cookie cookie = new Cookie("cCode",cCode);
                        cookie.setMaxAge(900);
                        cookie.setHttpOnly(true);
                        resp.addCookie(cookie);
                        sendResponse(new Response(0,"Hãy nhanh chóng đổi lại mật khẩu trước khi hết hạn OTP"),resp);
                        return;
                    }
                }
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
        }
        sendResponse(new Response(1,"OTP không hợp lệ"),resp);
    }

    private void resetPassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Cookie[] cookies = req.getCookies();
        Cookie fKey = CookieUtils.getCookie("fKey",cookies);
        Cookie cCode = CookieUtils.getCookie("cCode",cookies);
        ResetRequest resetRequest = objectMapper.readValue(req.getReader(),ResetRequest.class);

        if(fKey == null || cCode == null) {
            sendResponse(new Response(1,"Thời gian đổi mật khẩu đã hết hạn, hãy thao tác lại"),resp);
            return;
        }

        try(Jedis jedis = RedisConnectionPool.getInstance().getResource()) {

            Map<String,String> dataKey = jedis.hgetAll(fKey.getValue());

            if(dataKey != null &&
                    cCode.getValue().equals(dataKey.get("cCode")) &&
                    resetRequest.getUsername().equals(dataKey.get("username"))) {

                User user = userService.findById(resetRequest.getUsername());

                if(user != null) {
                    user.setPassword(BCrypt.hashpw(resetRequest.getNewPassword(),BCrypt.gensalt()));
                    if (userService.update(user) != null) {
                        jedis.del(fKey.getValue());
                        CookieUtils.deleteCookie("fKey",resp);
                        CookieUtils.deleteCookie("cCode",resp);
                        sendResponse(new Response(0,"Đổi mật khẩu thành công"),resp);
                        return;
                    }
                }

            }

        } catch (Exception e) {
            System.err.println(e.getMessage());
        }

        sendResponse(new Response(1,"Có lỗi xảy ra khi đặt lại mật khẩu!"),resp);

    }

    private void sendResponse(Response response, HttpServletResponse resp) throws IOException {
        PrintWriter writer = resp.getWriter();
        writer.print(objectMapper.writeValueAsString(response));
        writer.flush();
    }

    @Data
    private static class CheckUsernameRequest {

        private String username;

    }

    @Data
    private static class VerifyCodeRequest {

        private String username;
        private String code;

    }

    @Data
    private static class ResetRequest {
        private String username;
        private String newPassword;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class Response {
        private int status;
        private String content;
    }

}
