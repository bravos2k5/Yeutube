package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/b/profile")
public class ProfileServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() {
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        User user = userService.findById(userInfo.getId());
        req.setAttribute("userr",user);
        req.setAttribute("link","personal");
        req.getRequestDispatcher(getServletContext().getContextPath() + "/client.jsp").forward(req,resp);
    }

}
