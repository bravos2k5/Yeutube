package com.bravos.yeutube.config;

import com.bravos.yeutube.service.CountService;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.ArrayList;
import java.util.UUID;

@WebListener
public class SessionListener implements HttpSessionListener {

    private final CountService countService = new CountService();

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        session.setAttribute("recentViews", new ArrayList<UUID>());
        increase(session);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        decrease();
    }

    private void increase(HttpSession session) {
        countService.increase();
        session.getServletContext().setAttribute("visitors", countService.getTotalVisitCount());
    }

    private void decrease() {
        countService.decrease();
    }

}
