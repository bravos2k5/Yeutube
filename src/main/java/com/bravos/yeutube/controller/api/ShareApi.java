package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.service.ShareService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

@WebServlet("/api/private/share")
public class ShareApi extends HttpServlet {

    private ObjectMapper objectMapper;
    private ShareService shareService;

    @Override
    public void init() throws ServletException {
        objectMapper = new ObjectMapper();
        shareService = new ShareService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Request request = objectMapper.readValue(req.getReader(), Request.class);
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        PrintWriter writer = resp.getWriter();

        shareService.share(userInfo.getId(),
                UUID.fromString(request.getVideoId()),
                request.getEmails(),
                "Chia sẻ video từ người dùng " + userInfo.getId(),
                request.getMessage());

        writer.print(objectMapper.writeValueAsString(new Response(0,"Chia sẻ thành công")));
        writer.flush();

    }

    @Data
    private static class Request {

        String videoId;
        String[] emails;
        String message;

    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class Response {

        private int status;
        private String message;

    }



}
