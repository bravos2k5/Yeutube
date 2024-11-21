package com.bravos.yeutube.config.filter;

import com.bravos.yeutube.dto.UserInfo;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class SecurityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("user");

        if (requestURI.endsWith(".jsp")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if (requestURI.startsWith("/admin") || requestURI.startsWith("/api/admin") ||
                requestURI.startsWith("/api/private") || requestURI.startsWith("/b/")) {

            if (userInfo == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            if (requestURI.contains("/admin") && !userInfo.getAdmin()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

        }

        chain.doFilter(request, response);

    }

}
