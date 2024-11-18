package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.model.Favourite;
import com.bravos.yeutube.model.Share;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.service.FavouriteService;
import com.bravos.yeutube.service.ShareService;
import com.bravos.yeutube.service.UserService;
import com.bravos.yeutube.service.VideoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin",
        "/admin/dashboard",
        "/admin/users",
        "/admin/videos",
        "/admin/shares",
        "/admin/favourites",
        "/admin/videos/update",
        "/admin/videos/create",
        "/admin/users/update",
        "/admin/share/statistic"
})

public class AdminServlet extends HttpServlet {

    private UserService userService;
    private FavouriteService favouriteService;
    private VideoService videoService;
    private ShareService shareService;

    @Override
    public void init()  {
        userService = new UserService();
        favouriteService = new FavouriteService();
        videoService = new VideoService();
        shareService = new ShareService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String uri = req.getRequestURI();
        String link;
        if(uri.endsWith("users")) {
            link = "user";
            userViewHandler(req,resp);
        }
        else if (uri.endsWith("users/update")) {
            link = "user-update";
            userUpdaterHandler(req,resp);
        }
        else if(uri.endsWith("videos")) {
            link = "video";
            videoViewHandler(req,resp);
        }
        else if(uri.endsWith("videos/create")) {
            link = "video-create";
            videoCreatorHandler(req,resp);
        }
        else if(uri.endsWith("videos/update")) {
            link = "video-update";
            videoUpdaterHandler(req,resp);
        }
        else if(uri.endsWith("shares")) {
            link = "share";
            shareViewHandler(req,resp);
        }
        else if(uri.endsWith("favourites")) {
            link = "favourite";
            favouriteViewHandler(req,resp);
        } else if (uri.endsWith("statistic/share")) {
            link = "statistic-share";
            statisticShareHandler(req,resp);
        } else {
            link = "dashboard";
            dashboardHandler(req,resp);
        }
        req.setAttribute("link",link);
        req.getRequestDispatcher(getServletContext().getContextPath() + "/admin/admin.jsp").forward(req,resp);
    }

    private void dashboardHandler(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void userViewHandler(HttpServletRequest req, HttpServletResponse resp) {
        String searchKey = req.getParameter("search");
        List<User> userList;
        if(searchKey == null || searchKey.isBlank()) {
            userList = userService.findAll();
        }
        else {
            userList = List.of(userService.findById(searchKey));
        }
        req.setAttribute("search",searchKey);
        req.setAttribute("userList",userList);
    }

    private void userUpdaterHandler(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void videoViewHandler(HttpServletRequest req, HttpServletResponse resp) {
        String searchKey = req.getParameter("search");
        List<Video> videoList;
        if(searchKey == null || searchKey.isBlank()) {
            videoList = videoService.findAll();
        }
        else {
            videoList = videoService.findByTitle(searchKey);
        }
        req.setAttribute("search",searchKey);
        req.setAttribute("videoList",videoList);
    }

    private void videoUpdaterHandler(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void videoCreatorHandler(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void shareViewHandler(HttpServletRequest req, HttpServletResponse resp) {
        String searchKey = req.getParameter("search");
        List<Share> shares;
        if(searchKey == null || searchKey.isBlank()) {
            shares = shareService.findAll();
        }
        else {
            shares = shareService.findByUserId(searchKey);
        }
        req.setAttribute("search",searchKey);
        req.setAttribute("shares",shares);
    }

    private void statisticShareHandler(HttpServletRequest req, HttpServletResponse resp) {

    }

    private void favouriteViewHandler(HttpServletRequest req, HttpServletResponse resp) {
        String searchKey = req.getParameter("search");
        List<Favourite> favourites;
        if(searchKey == null || searchKey.isBlank()) {
            favourites = favouriteService.findAll();
        }
        else {
            favourites = favouriteService.findByUserId(searchKey);
        }
        req.setAttribute("search",searchKey);
        req.setAttribute("favourites",favourites);
    }

}
