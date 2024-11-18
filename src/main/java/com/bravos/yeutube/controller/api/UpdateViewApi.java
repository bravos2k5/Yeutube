package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.service.VideoService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Data;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/api/public/updateViewCount")
public class UpdateViewApi extends HttpServlet {

    private VideoService videoService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        videoService = new VideoService();
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Request request = objectMapper.readValue(req.getReader(), Request.class);
        if(request != null && request.getVideoId() != null) {
            HttpSession session = req.getSession();
            UUID videoId = UUID.fromString(request.getVideoId());
            List<UUID> recentVideoIdList = (List<UUID>) session.getAttribute("recentViews");
            recentVideoIdList.remove(videoId);
            recentVideoIdList.addFirst(videoId);
            if(recentVideoIdList.size() == 20) {
                recentVideoIdList.removeLast();
            }
            session.setAttribute("recentViews",recentVideoIdList);
            videoService.updateViewCount(UUID.fromString(request.getVideoId()));
        }
    }

    @Data
    private static class Request {
        private String videoId;
    }

}
