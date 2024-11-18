package com.bravos.yeutube.config.filter;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.utils.JwtUtils;
import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class SecurityFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI();
        Cookie[] cookies = request.getCookies();
        HttpSession session = request.getSession();

        String accessToken = getAccessToken(cookies);
        if(accessToken != null && !accessToken.isBlank()) {
            request.getSession().setAttribute("user", JwtUtils.extractUserInfoIfValid(accessToken));
        }

        if(requestURI.endsWith(".jsp")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        if(requestURI.startsWith("/api/auth") || requestURI.startsWith("/api/public")) {
            chain.doFilter(request,response);
            return;
        }

        if(requestURI.startsWith("/admin") || requestURI.startsWith("/api/admin") ||
                requestURI.startsWith("/api/private") || requestURI.startsWith("/b/")) {

            if (accessToken == null || accessToken.isBlank()) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            UserInfo userInfo = JwtUtils.extractUserInfoIfValid(accessToken);

            if(userInfo == null) {
                deleteAccessKey(cookies,response);
                session.removeAttribute("user");
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            if(requestURI.contains("/admin") && !userInfo.getAdmin()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            chain.doFilter(request,response);
            return;
        }
        chain.doFilter(request,response);
    }

    private String getAccessToken(Cookie[] cookies) {
        if(cookies == null) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("accessToken")) {
                return cookie.getValue();
            }
        }
        return null;
    }

    private void deleteAccessKey(Cookie[] cookies, HttpServletResponse response) {
        for (Cookie cookie : cookies) {
            if(cookie.getName().equals("accessToken")) {
                cookie.setValue("");
                cookie.setPath("/");
                cookie.setMaxAge(0);
                cookie.setPath("/");
                cookie.setHttpOnly(true);
                response.addCookie(cookie);
            }
        }
    }

}
