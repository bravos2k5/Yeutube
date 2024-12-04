package com.bravos.yeutube.config.filter;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.utils.JwtUtils;
import jakarta.servlet.*;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AutoLoginFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;

        String requestURI = request.getRequestURI();

        if(requestURI.startsWith("/api/auth") || requestURI.startsWith("/api/public")) {
            chain.doFilter(request, response);
            return;
        }

        Cookie[] cookies = request.getCookies();
        HttpSession session = request.getSession();

        String accessToken = getAccessToken(cookies);
        UserInfo userInfo = null;

        if (accessToken != null && !accessToken.isBlank()) {
            userInfo = JwtUtils.extractUserInfoIfValid(accessToken);
            if (userInfo == null) {
                deleteAccessKey(response);
            }
        }

        session.setAttribute("user", userInfo);
        chain.doFilter(request, response);

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

    private void deleteAccessKey(HttpServletResponse response) {
        Cookie cookie = new Cookie("accessToken","");
        cookie.setPath("/");
        cookie.setMaxAge(0);
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

}
