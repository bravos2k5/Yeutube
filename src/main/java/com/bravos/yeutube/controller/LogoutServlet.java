package com.bravos.yeutube.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("user");
        Cookie cookie = new Cookie("accessToken","");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);
        resp.sendRedirect(getServletContext().getContextPath() + "/home");
    }

}
