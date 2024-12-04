package com.bravos.yeutube.controller.api;

import com.azure.storage.blob.BlobServiceClient;
import com.bravos.yeutube.dto.Activity;
import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.service.LogService;
import com.bravos.yeutube.service.VideoService;
import com.bravos.ytbcraw.YtbService;
import com.bravos2k5.azureblobsimple.AzureBlobService;
import com.bravos2k5.azureblobsimple.StorageConfig;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Duration;
import java.util.UUID;

@WebServlet(urlPatterns = {"/api/admin/video/update","/api/admin/video/create","/api/admin/upload-thumbnail"})
@MultipartConfig
public class VideoApi extends HttpServlet {

    private AzureBlobService azureBlobService;
    private VideoService videoService;
    private YtbService ytbService;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        BlobServiceClient client = StorageConfig.builder()
                .storageName("bravosstorage")
                .accessKey(System.getenv("ABS_KEY"))
                .connectTimeOut(Duration.ofSeconds(30))
                .build().getClient();
        azureBlobService = new AzureBlobService(client);
        objectMapper = new ObjectMapper();
        videoService = new VideoService();
        ytbService = videoService.getYtbService();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        if(uri.endsWith("create")) {
            createVideo(req,resp);
        }
        else if(uri.endsWith("upload-thumbnail")) {
            uploadThumbnail(req,resp);
        }
        else if(uri.endsWith("update")) {
            updateVideo(req,resp);
        }
    }

    private void createVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        CreateRequest createRequest = objectMapper.readValue(req.getReader(), CreateRequest.class);
        Video video = new Video();
        video.setTitle(createRequest.getTitle());
        video.setDescription(createRequest.getDescription());
        video.setPoster(createRequest.getThumbnail());
        video.setActive(createRequest.isActive());

        String youtubeId = ytbService.convertUrlToVideoId(createRequest.getYoutubeUrl());
        if(youtubeId == null) {
            sendReponse(new Response(1,"URL không hợp lệ","1"),resp);
            return;
        }

        video.setYoutubeId(youtubeId);
        videoService.insert(video);
        Activity activity = new Activity(Activity.VIDEO,String.format("<strong>%s</strong> vừa được đăng tải",video.getTitle()));
        LogService.insertLogActivity(activity);
        sendReponse(new Response(0,"Tạo mới video thành công",video.getId().toString()),resp);
    }

    private void updateVideo(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        UpdateRequest updateRequest = objectMapper.readValue(req.getReader(), UpdateRequest.class);

        Video video = videoService.findById(UUID.fromString(updateRequest.getVideoId()));

        if (video == null) {
            sendReponse(new Response(1, "Video không tồn tại", "1"), resp);
            return;
        }

        video.setTitle(updateRequest.getTitle());
        video.setDescription(updateRequest.getDescription());
        video.setActive(updateRequest.isActive());

        String youtubeId = ytbService.convertUrlToVideoId(updateRequest.getYoutubeUrl());
        if (youtubeId == null) {
            sendReponse(new Response(1, "URL không hợp lệ", "1"), resp);
            return;
        }

        video.setYoutubeId(youtubeId);

        if (!updateRequest.getThumbnail().isEmpty()) {
            video.setPoster(updateRequest.getThumbnail());
        }

        videoService.update(video);
        Activity activity = new Activity(Activity.VIDEO,String.format("<strong>%s</strong> vừa được cập nhật",video.getTitle()));
        LogService.insertLogActivity(activity);
        sendReponse(new Response(0, "Cập nhật video thành công", video.getId().toString()), resp);
    }


    private void uploadThumbnail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part thumbnail = req.getPart("thumbnail");
        UUID videoId = UUID.fromString(req.getParameter("videoId"));
        Video video = videoService.findById(videoId);
        if(video == null) {
            sendReponse(new Response(1,"Có lỗi xảy ra do video không tồn tại","1"),resp);
            return;
        }
        String thumbnailUrl = azureBlobService.uploadAndGetUrl(thumbnail.getInputStream(),
                thumbnail.getSubmittedFileName(),"thumbnails");

        video.setPoster(thumbnailUrl);
        videoService.update(video);
        sendReponse(new Response(0,"Upload thumbnail thành công",thumbnailUrl),resp);
    }

    private void sendReponse(Response response, HttpServletResponse resp) throws IOException {
        try(PrintWriter writer = resp.getWriter()) {
            writer.print(objectMapper.writeValueAsString(response));
            writer.flush();
        }
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    private static class Response {
        private int status;
        private String message;
        private String content;
    }

    @Data
    private static class CreateRequest {

        String youtubeUrl;
        String title;
        String description;
        String thumbnail;
        boolean active;

    }

    @Data
    private static class UpdateRequest {
        private String videoId;
        private String youtubeUrl;
        private String title;
        private String description;
        private String thumbnail;
        private boolean active;
    }

}
