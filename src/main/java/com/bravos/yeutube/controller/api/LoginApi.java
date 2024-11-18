package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.service.AuthService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/auth/login")
public class LoginApi extends HttpServlet {

    private AuthService authService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        authService = new AuthService();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        LoginRequest loginRequest = objectMapper.readValue(req.getReader(),LoginRequest.class);
        User user = authService.authenticate(loginRequest.getUsername(),loginRequest.getPassword());
        PrintWriter writer = resp.getWriter();
        LoginResponse loginResponse;
        if(user == null)
            loginResponse = new LoginResponse(1, "Thông tin đăng nhập không chính xác!");
        else {
            loginResponse = new LoginResponse(0,"Đăng nhập thành công!");
            HttpSession session = req.getSession();
            UserInfo userInfo = new UserInfo(user);
            session.setAttribute("user",userInfo);
            int expSeconds = loginRequest.getRemember() ? 24 * 60 * 60 : -1;
            resp.addCookie(authService.generateLoginCookie(userInfo,expSeconds));
        }
        writer.print(objectMapper.writeValueAsString(loginResponse));
        writer.flush();
    }

    @Data
    private static class LoginRequest {
        private String username;
        private String password;
        private Boolean remember;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class LoginResponse {
        private int status;
        private String message;
    }

}
