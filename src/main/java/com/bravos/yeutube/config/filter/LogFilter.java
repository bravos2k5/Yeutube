package com.bravos.yeutube.config.filter;

import com.bravos.yeutube.dto.UserInfo;
import com.bravos.yeutube.model.Log;
import com.bravos.yeutube.service.LogService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class LogFilter implements Filter {

    private final LogService logService = new LogService();

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) servletRequest;
        HttpSession session = req.getSession();
        UserInfo userInfo = (UserInfo) session.getAttribute("user");

        if(userInfo != null) {
            Log log = new Log();
            log.setUsername(userInfo.getId());
            log.setUri(req.getRequestURI());
            logService.insert(log);
        }

        filterChain.doFilter(servletRequest,servletResponse);

    }

}
