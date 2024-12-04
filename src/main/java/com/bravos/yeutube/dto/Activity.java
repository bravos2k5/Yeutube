package com.bravos.yeutube.dto;

import com.bravos.yeutube.utils.TimeUtils;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Activity {

    public static final int VIDEO = 1;
    public static final int USER = 2;

    private int type;
    private String message;

    private LocalDateTime dateTime = LocalDateTime.now();

    public Activity(int type, String message) {
        this.type = type;
        this.message = message;
    }

    public String getDateTimeString() {
        return TimeUtils.getTimeAgo(dateTime);
    }

}
