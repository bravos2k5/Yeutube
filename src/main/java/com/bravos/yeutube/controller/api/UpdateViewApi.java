package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.service.VideoService;
import com.bravos.yeutube.utils.CookieUtils;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import lombok.Data;

import java.io.IOException;
import java.lang.reflect.Type;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/api/public/update-view-count")
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
            UUID videoId = UUID.fromString(request.getVideoId());
            List<UUID> recentVideoIdList = videoService.getRecentViewsList(req.getCookies());
            recentVideoIdList.remove(videoId);
            recentVideoIdList.addFirst(videoId);
            if(recentVideoIdList.size() == 20) {
                recentVideoIdList.removeLast();
            }
            videoService.updateViewCount(UUID.fromString(request.getVideoId()));
            Cookie cookie = new Cookie("recentViews", URLEncoder.encode(objectMapper.writeValueAsString(recentVideoIdList), StandardCharsets.UTF_8));
            cookie.setMaxAge(24 * 60 * 60);
            cookie.setPath("/");
            resp.addCookie(cookie);
        }
    }

    @Data
    private static class Request {
        private String videoId;
    }


}
