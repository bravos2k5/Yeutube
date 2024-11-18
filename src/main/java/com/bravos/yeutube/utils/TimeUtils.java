package com.bravos.yeutube.utils;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class TimeUtils {

    public static String getTimeAgo(LocalDateTime pastTime) {

        LocalDateTime now = LocalDateTime.now();

        long years = ChronoUnit.YEARS.between(pastTime,now);
        if(years > 0) return years + " năm trước";
        long months = ChronoUnit.MONTHS.between(pastTime,now);
        if(months > 0) return months + " tháng trước";
        long days = ChronoUnit.DAYS.between(pastTime,now);
        if(days > 0) return days + " ngày trước";
        long hours = ChronoUnit.HOURS.between(pastTime,now);
        if(hours > 0) return hours + " giờ trước";
        long minutes = ChronoUnit.MINUTES.between(pastTime,now);
        if(minutes > 0) return minutes + " phút trước";
        long seconds = ChronoUnit.SECONDS.between(pastTime,now);
        if(seconds > 0) return seconds + " giây trước";
        return "Vừa mới đây";

    }

}
