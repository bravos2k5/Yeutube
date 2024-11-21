package com.bravos.yeutube.repository;

import com.bravos.yeutube.model.Log;

public class LogRepository extends Repository<Log,Long> {

    public LogRepository() {
        super(Log.class);
    }

}
