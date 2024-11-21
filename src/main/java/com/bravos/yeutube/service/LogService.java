package com.bravos.yeutube.service;

import com.bravos.yeutube.model.Log;
import com.bravos.yeutube.repository.LogRepository;

public class LogService {

    private final LogRepository logRepository = new LogRepository();

    public Log insert(Log log) {
        return logRepository.insert(log);
    }

}
