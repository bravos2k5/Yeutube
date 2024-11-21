package com.bravos.yeutube.service;

import java.io.*;
import java.util.concurrent.atomic.AtomicLong;

public class CountService {

    private final static AtomicLong visitCount = new AtomicLong(getLatestUpdateVisitCount());
    private final static AtomicLong currentSessionCount = new AtomicLong(0);

    public void increase() {
        visitCount.incrementAndGet();
        currentSessionCount.incrementAndGet();
    }

    public void decrease() {
        currentSessionCount.decrementAndGet();
    }

    public long getTotalVisitCount() {
        return visitCount.get();
    }

    public long getCurrentSessionCount() {
        return currentSessionCount.get();
    }

    private static long getLatestUpdateVisitCount() {
        try {
            File file = new File("visitCount.txt");
            if(file.createNewFile()) {
                return 0;
            }
            try(BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String data;
                if ((data = reader.readLine()) != null) {
                    return Long.parseLong(data);
                }
            } catch (NumberFormatException e) {
                return 0;
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    public void saveVisitCount() {
        try(BufferedWriter writer = new BufferedWriter(new FileWriter("visitCount.txt"))) {
            writer.write(getTotalVisitCount() + "");
            writer.flush();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

}
