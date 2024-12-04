package com.bravos.yeutube.service;

import com.bravos.yeutube.dto.Activity;
import com.bravos.yeutube.model.Log;
import com.bravos.yeutube.repository.LogRepository;

import java.util.ArrayList;
import java.util.List;

public class LogService {

    private final LogRepository logRepository = new LogRepository();

    public static final List<Activity> ACTIVITY_LIST = new ArrayList<>();

    public Log insert(Log log) {
        return logRepository.insert(log);
    }

    public static void insertLogActivity(Activity activity) {
        ACTIVITY_LIST.add(activity);
        if(ACTIVITY_LIST.size() > 15) {
            ACTIVITY_LIST.removeFirst();
        }
    }

}
