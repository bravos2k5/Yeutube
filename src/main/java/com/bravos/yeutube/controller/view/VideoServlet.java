package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.service.FavouriteService;
import com.bravos.yeutube.service.VideoService;
import com.bravos.yeutube.utils.TimeUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@WebServlet("/video")
public class VideoServlet extends HttpServlet {

    private VideoService videoService;
    private FavouriteService favouriteService;

    @Override
    public void init() {
        videoService = new VideoService();
        favouriteService = new FavouriteService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID videoId;
        try {
            videoId = UUID.fromString(req.getParameter("id"));
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        Video video = videoService.findById(videoId);
        if(video == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        video.setViews(video.getViews() + videoService.getIncreaseViewCount(videoId));

        List<Video> recentViewsList = new ArrayList<>();
        List<UUID> recentViews = (List<UUID>) req.getSession().getAttribute("recentViews");
        for(UUID vId : recentViews) {
            if(vId.equals(videoId)) {
                continue;
            }
            Video v = videoService.findById(vId);
            v.setViews(v.getViews() + videoService.getIncreaseViewCount(vId));
            recentViewsList.add(v);
        }
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        req.setAttribute("isLiked",userInfo != null && favouriteService.isLiked(userInfo.getId(),videoId));
        req.setAttribute("recentViewsList",recentViewsList);
        req.setAttribute("link","video");
        req.setAttribute("video",video);
        req.setAttribute("like",favouriteService.getLikeCountVideo(videoId));
        req.setAttribute("time", TimeUtils.getTimeAgo(video.getCreatedTime()));
        req.setAttribute("description", Arrays.stream(video.getDescription().split("\n")).toList());
        req.getRequestDispatcher(getServletContext().getContextPath() + "/client.jsp").forward(req,resp);
    }

}
