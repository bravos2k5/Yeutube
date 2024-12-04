package com.bravos.yeutube.config;

import com.bravos.yeutube.config.filter.AppFilter;
import com.bravos.yeutube.config.filter.AutoLoginFilter;
import com.bravos.yeutube.config.filter.LogFilter;
import com.bravos.yeutube.config.filter.SecurityFilter;
import com.bravos.yeutube.service.VideoService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebListener;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.EnumSet;
import java.util.Enumeration;

@WebListener
public class ContextListener implements ServletContextListener {

    private final VideoService videoService = new VideoService();
    private final ScheduleEvent scheduleEvent = new ScheduleEvent();

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        ServletContext context = sce.getServletContext();

        FilterRegistration.Dynamic filter1 = context.addFilter("Filter1", AutoLoginFilter.class);
        filter1.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");

        FilterRegistration.Dynamic filter2 = context.addFilter("Filter2", AppFilter.class);
        filter2.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");

        FilterRegistration.Dynamic filter3 = context.addFilter("Filter3", SecurityFilter.class);
        filter3.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");

//        FilterRegistration.Dynamic filter4 = context.addFilter("Filter4", LogFilter.class);
//        filter4.addMappingForUrlPatterns(EnumSet.of(DispatcherType.REQUEST), true, "/*");

        videoService.getVideoCount();
        context.setAttribute("visitors",0L);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

        this.scheduleEvent.cancelAllProcess();

        RedisConnectionPool.getInstance().getResource().flushDB();
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

        HibernateConfig.shutdown();

    }

}
