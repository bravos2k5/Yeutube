package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.service.UserService;
import com.bravos.yeutube.utils.RegexUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(urlPatterns = {
        "/api/private/changepassword",
        "/api/public/forgetpassword",
        "/api/private/changeinfo",
        "/api/admin/users/update"
})
public class UserApi extends HttpServlet {

    private UserService userService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        userService = new UserService();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.endsWith("changeinfo")) {
            changePersonalInfo(req,resp);
            return;
        }
        if(uri.endsWith("changepassword")) {
            changePassword(req,resp);
            return;
        }
        if(uri.endsWith("update")) {
            adminUpdate(req,resp);
            return;
        }
    }

    private void changePersonalInfo(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ChangeInfoRequest changeInfoRequest = objectMapper.readValue(req.getReader(), ChangeInfoRequest.class);

        if(!RegexUtils.isEmail(changeInfoRequest.getEmail())) {
            Response response = new Response(1,"Email không hợp lệ");
            sendReponse(response,resp);
            return;
        }

        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("user");
        User user = userService.findById(userInfo.getId());

        if(user == null) {
            Response response = new Response(1,"User không hợp lệ");
            sendReponse(response,resp);
            return;
        }

        if(user.getEmail().equals(changeInfoRequest.email) && user.getFullName().equals(changeInfoRequest.getFullName())) {
            Response response = new Response(0,"Cập nhật thành công");
            sendReponse(response,resp);
            return;
        }

        user.setEmail(changeInfoRequest.getEmail());
        user.setFullName(changeInfoRequest.getFullName());
        user = userService.update(user);
        if (user != null) {
            userInfo = new UserInfo(user);
            session.setAttribute("user",userInfo);
            Response response = new Response(0,"Cập nhật thành công");
            sendReponse(response,resp);
            return;
        }
        Response response = new Response(1,"Cập nhật thất bại");
        sendReponse(response,resp);

    }

    private void changePassword(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ChangePasswordRequest changePasswordRequest = objectMapper.readValue(req.getReader(),ChangePasswordRequest.class);

        if(RegexUtils.checkPassword(changePasswordRequest.getNewPassword()) < RegexUtils.EASY) {
            Response response = new Response(1,"Mật khẩu phải từ 6 kí tự trở lên");
            sendReponse(response,resp);
            return;
        }

        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("user");
        User user = userService.findById(userInfo.getId());
        if(user != null && BCrypt.checkpw(changePasswordRequest.getOldPassword(),user.getPassword())) {
            user.setPassword(BCrypt.hashpw(changePasswordRequest.getNewPassword(),BCrypt.gensalt()));
            userService.update(user);
            Response response = new Response(0,"Đổi mật khẩu thành công!");
            sendReponse(response,resp);
        }
        else {
            Response response = new Response(1,"Đổi mật khẩu thất bại!");
            sendReponse(response,resp);
        }

    }

    public void adminUpdate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UpdateUserRequest updateUserRequest = objectMapper.readValue(req.getReader(), UpdateUserRequest.class);

        User user = userService.findById(updateUserRequest.getUsername());

        if(user == null) {
            sendReponse(new Response(0,"User không tồn tại"), resp);
            return;
        }

        user.setId(updateUserRequest.getUsername());
        user.setFullName(updateUserRequest.getFullName());
        if (updateUserRequest.getNewPassword() != null && !updateUserRequest.getNewPassword().isBlank()) {
            user.setPassword(BCrypt.hashpw(updateUserRequest.getNewPassword(),BCrypt.gensalt()));
        }
        user.setEmail(updateUserRequest.getEmail());
        user.setAdmin(updateUserRequest.isAdmin());

        user = userService.update(user);

        String message = user == null ? "Cập nhật thất bại" : "Cập nhật thành công";

        sendReponse(new Response(user == null ? 0 : 1,message),resp);

    }

    private void sendReponse(Response response, HttpServletResponse resp) throws IOException {
        PrintWriter writer = resp.getWriter();
        writer.print(objectMapper.writeValueAsString(response));
        writer.flush();
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
