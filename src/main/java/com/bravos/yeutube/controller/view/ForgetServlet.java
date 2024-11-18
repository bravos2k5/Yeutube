package com.bravos.yeutube.controller.view;

import com.bravos.yeutube.dto.UserInfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forget-password")
public class ForgetServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserInfo userInfo = (UserInfo) req.getSession().getAttribute("user");
        if(userInfo != null) {
            resp.sendRedirect("/home");
            return;
        }
        req.getRequestDispatcher(getServletContext().getContextPath() + "/forget.jsp").forward(req,resp);
    }

}
