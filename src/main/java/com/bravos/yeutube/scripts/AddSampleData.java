package com.bravos.yeutube.scripts;

import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.service.VideoService;
import com.bravos.ytbcraw.VideoInfo;
import com.bravos.ytbcraw.YtbService;

import java.util.List;

public class AddSampleData {

    public static void main(String[] args) {
        VideoService videoService = new VideoService();
        YtbService ytbService = new YtbService("AIzaSyCArjdIj3d8ykraLp2is6cOl4DmJDNYic4");
        List<String> videoLinkList = List.of(
                "https://www.youtube.com/watch?v=9OVVle8ilp8&ab_channel=BATTLECRY-NG%C6%AF%E1%BB%9CIK%E1%BB%82S%E1%BB%AC"
        );
        for(String url : videoLinkList) {
            VideoInfo videoInfo = ytbService.getVideoInfo(ytbService.convertUrlToVideoId(url));
            if(videoInfo != null) {
                Video video = new Video();
                video.setTitle(videoInfo.getTitle());
                video.setPoster(videoInfo.getThumbnails().values().stream().toList().getLast().getUrl());
                video.setDescription(videoInfo.getDescription());
                video.setActive(true);
                video.setYoutubeId(ytbService.convertUrlToVideoId(url));
                videoService.insert(video);
            }
        }
    }

}
