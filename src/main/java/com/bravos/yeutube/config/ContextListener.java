package com.bravos.yeutube.config;

import com.bravos.yeutube.config.filter.SecurityFilter;
import com.bravos.yeutube.service.VideoService;
import jakarta.servlet.FilterRegistration;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Enumeration;

@WebListener
public class ContextListener implements ServletContextListener {

    private final VideoService videoService = new VideoService();
    private final ScheduleEvent scheduleEvent = new ScheduleEvent();

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        FilterRegistration.Dynamic filterRegistration = context.addFilter("jwtFilter", new SecurityFilter());
        filterRegistration.addMappingForUrlPatterns(null,false,"/*");
        videoService.getVideoCount();
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        this.scheduleEvent.cancelAllProcess();
        RedisConnectionPool.getInstance().getJedisPool().getResource().flushDB();
        HibernateConfig.shutdown();
        RedisConnectionPool.getInstance().shutdown();

        Enumeration<Driver> drivers = DriverManager.getDrivers();
        while (drivers.hasMoreElements()) {
            Driver driver = drivers.nextElement();
            try {
                DriverManager.deregisterDriver(driver);
            } catch (SQLException e) {
                System.err.println("Lỗi khi deregister driver: " + driver);
            }
        }

    }

}
