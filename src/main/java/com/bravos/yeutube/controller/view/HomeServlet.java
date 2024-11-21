package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.service.VideoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.*;

@WebServlet(urlPatterns = {
        "/home",
        "/favourite",
        "/newest",
        "/search",
        "/best"
})
public class HomeServlet extends HttpServlet {

    private VideoService videoService;
    private static final int PAGE_SIZE = 15;

    @Override
    public void init() {
        videoService = new VideoService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        String type;
        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("user");

        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                throw new RuntimeException("Page format");
            }
        }

        String uri = req.getRequestURI();
        List<Video> videoList;
        long maxPage;

        if(uri.endsWith("newest")) {
            type = "/newest";
            maxPage = videoService.getMaxPageVideo(PAGE_SIZE);
            videoList = videoService.getHomepageVideos(page,PAGE_SIZE,VideoService.CREATED_TIME);
        }
        else if(uri.endsWith("favourite")) {
            if(userInfo == null) {
                resp.sendRedirect("/home");
                return;
            }
            type = "/favourite";
            videoList = videoService.getFavouriteVideo(userInfo.getId(),page,PAGE_SIZE);
            maxPage = videoService.getMaxPageFavourite(userInfo.getId(), PAGE_SIZE);
        }
        else if(uri.endsWith("best")) {
            type = "/best";
            videoList = videoService.getMostLikeVideo(page,PAGE_SIZE);
            maxPage = videoService.getMaxPageVideo(PAGE_SIZE);
        }
        else if (uri.endsWith("search")) {
            String keyword = req.getParameter("keyword");
            type = "/search";
            maxPage = videoService.getMaxPageSearch(keyword,PAGE_SIZE);
            videoList = videoService.findByTitle(keyword,page,PAGE_SIZE);
            req.setAttribute("keyword",keyword);
        }
        else {
            type = "";
            maxPage = videoService.getMaxPageVideo(PAGE_SIZE);
            videoList = videoService.getHomepageVideos(page,PAGE_SIZE,VideoService.VIEWS);
        }

        List<Long> pageList = new ArrayList<>();

        for(long i = page - 5; i < page + 5; i++) {
            if(i > 0 && i <= maxPage) {
                pageList.add(i);
            }
        }

        for(Video video : videoList) {
            video.setViews(video.getViews() + videoService.getIncreaseViewCount(video.getId()));
        }
        req.setAttribute("type",type);
        req.setAttribute("maxPage",maxPage);
        req.setAttribute("videoList",videoList);
        req.setAttribute("pageList",pageList);
        req.setAttribute("currentPage",page);
        req.setAttribute("link","home");
        req.getRequestDispatcher(getServletContext().getContextPath() + "/client.jsp").forward(req,resp);
    }

}
