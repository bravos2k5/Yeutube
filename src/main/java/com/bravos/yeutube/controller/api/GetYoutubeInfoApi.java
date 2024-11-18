package com.bravos.yeutube.controller.api;

import com.bravos.yeutube.utils.PropsUtils;
import com.bravos.ytbcraw.VideoInfo;
import com.bravos.ytbcraw.YtbService;
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

@WebServlet("/api/public/youtube")
public class GetYoutubeInfoApi extends HttpServlet {

    private YtbService ytbService;
    private ObjectMapper objectMapper;

    @Override
    public void init() {
        ytbService = new YtbService(PropsUtils.getInstance().getResourceProperties().getProperty("api.key.youtube"));
        objectMapper = new ObjectMapper();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Request request = objectMapper.readValue(req.getReader(),Request.class);
        if (request == null || request.getLink() == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        String ytbId = ytbService.convertUrlToVideoId(request.getLink());
        PrintWriter writer = resp.getWriter();
        if(ytbId == null) {
            Response response = new Response("","","",1,"YoutubeId không hợp lệ");
            writer.print(objectMapper.writeValueAsString(response));
            writer.flush();
            return;
        }
        VideoInfo videoInfo = ytbService.getVideoInfo(ytbId);
        if(videoInfo == null) {
            Response response = new Response("","","",1,"Video không có trên youtube hoặc video riêng tư");
            writer.print(objectMapper.writeValueAsString(response));
            writer.flush();
            return;
        }
        Response response = new Response();
        response.setTitle(videoInfo.getTitle());
        response.setDescription(videoInfo.getDescription());
        response.setSrc(videoInfo.getThumbnails().values().stream().toList().getLast().getUrl());
        response.setStatus(0);
        response.setMessage("");
        writer.print(objectMapper.writeValueAsString(response));
        writer.flush();
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    private static class Request {
        private String link;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    private static class Response {
        private String title;
        private String description;
        private String src;
        private int status;
        private String message;
    }

}
