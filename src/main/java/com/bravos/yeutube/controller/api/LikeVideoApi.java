package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.service.FavouriteService;
import com.fasterxml.jackson.databind.ObjectMapper;
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

@WebServlet("/api/private/like")
public class LikeVideoApi extends HttpServlet {

    private ObjectMapper objectMapper;
    private FavouriteService favouriteService;

    @Override
    public void init() {
        objectMapper = new ObjectMapper();
        favouriteService = new FavouriteService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UUID videoId = UUID.fromString(req.getParameter("videoId"));
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        boolean isLiked = favouriteService.isLiked(userInfo.getId(),videoId);
        Response response = new Response(!isLiked, isLiked ?
                favouriteService.unLikeVideo(userInfo.getId(),videoId) :
                favouriteService.likeVideo(userInfo.getId(),videoId));
        PrintWriter writer = resp.getWriter();
        writer.print(objectMapper.writeValueAsString(response));
        writer.flush();
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class Response {

        boolean liked;
        long countLike;

    }

}
