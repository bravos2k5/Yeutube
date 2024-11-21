package com.bravos.yeutube.scripts;

import com.bravos.yeutube.service.VideoService;

public class MissCacheTest {

    public static void main(String[] args) {
        VideoService videoService = new VideoService();
        Thread[] threads = new Thread[10000];
        videoService.findAll();
        for(int i = 0; i < 10000; i++) {
            int finalI = i;
            threads[i] = new Thread(() -> {
                try {
                    videoService.getVideoCount();
                    System.out.println(finalI + " done");
                } catch (Exception e) {
                    System.out.println(finalI + "fail");
                }
            });
            threads[i].start();
        }
    }

}
