package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.service.AuthService;
import com.bravos.yeutube.service.UserService;
import com.bravos.yeutube.utils.JwtUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login","/forget"})
public class LoginServlet extends HttpServlet {

    private AuthService authService;
    private UserService userService;

    @Override
    public void init() {
        authService = new AuthService();
        userService = new UserService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Cookie tokenCookie = authService.getAccessToken(req.getCookies());
        HttpSession session = req.getSession();
        String uri = req.getRequestURI();
        if(tokenCookie != null) {
            String token = tokenCookie.getValue();
            UserInfo userInfo = JwtUtils.extractUserInfoIfValid(token);
            if (userInfo != null) {
                User user = userService.findById(userInfo.getId());
                userInfo.setAdmin(user.getAdmin());
                userInfo.setFullName(user.getFullName());
                session.setAttribute("user",userInfo);
                resp.sendRedirect(getServletContext().getContextPath() + "/home");
                return;
            }
        }
        req.getRequestDispatcher(getServletContext().getContextPath() +
                (uri.endsWith("login") ? "/auth.jsp" : "forget.jsp")).forward(req,resp);
    }

}
