package com.bravos.yeutube.config.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AppFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpServletResponse resp = (HttpServletResponse) servletResponse;
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String uri = req.getRequestURI();
        String queryString = req.getQueryString();

        String url = uri + (queryString == null ? "" : "?" + queryString);

        if(req.getMethod().equalsIgnoreCase("get") &&
                !uri.contains("login") &&
                !uri.contains("api") &&
                !uri.contains("logout") &&
                !uri.contains(".js") &&
                !uri.contains(".css") &&
                !uri.contains(".ico")
        ) {
            HttpSession session = req.getSession();
            if (session.getAttribute("user") == null) {
                session.setAttribute("pageBeforeLogin",url);
            }
        }

        filterChain.doFilter(req,resp);

    }

}
