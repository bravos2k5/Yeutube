package com.bravos.yeutube.controller;

import com.bravos.yeutube.utils.CookieUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        HttpSession session = req.getSession();
        if (session.getAttribute("user") != null) {
            session.invalidate();
            CookieUtils.deleteCookie("accessToken",resp);
            CookieUtils.deleteCookie("recentViews",resp);
        }
        resp.sendRedirect(getServletContext().getContextPath() + "/home");
    }

}
