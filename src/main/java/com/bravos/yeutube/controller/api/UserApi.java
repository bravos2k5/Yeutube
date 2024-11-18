package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;

@WebServlet(urlPatterns = {
        "/api/private/changepassword",
        "/api/public/forgetpassword",
        "/api/private/changeinfo",
        "/api/admin/users/update"
})
public class UserApi extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }

    @Data
    private static class ChangePasswordRequest {
        private String oldPassword;
        private String newPassword;
    }

    @Data
    private static class ChangeInfoRequest {
        private String fullName;
        private String email;
    }

    @Data
    private static class UpdateUserRequest {
        private String username;
        private boolean admin;
        private String fullName;
        private String email;
        private String newPassword;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    private static class Response {
        private int status;
        private String message;
    }

}
