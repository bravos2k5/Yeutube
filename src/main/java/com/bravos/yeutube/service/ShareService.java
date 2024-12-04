package com.bravos.yeutube.service;

import com.bravos.yeutube.model.Share;
import com.bravos.yeutube.model.User;
import com.bravos.yeutube.model.Video;
import com.bravos.yeutube.repository.ShareRepository;
import com.bravos.yeutube.utils.EmailUtils;

import java.util.Date;
import java.util.List;
import java.util.UUID;

public class ShareService {

    private final ShareRepository shareRepository = new ShareRepository();

    public void share(String username, UUID videoId, String[] toEmails, String subject, String text) {
        Share[] shares = new Share[toEmails.length];
        for (int i = 0; i < toEmails.length; i++) {
            if(toEmails[i] == null || toEmails[i].isEmpty()) {
                continue;
            }
            Share share = new Share();
            share.setUser(new User(username));
            share.setVideo(new Video(videoId));
            share.setEmail(toEmails[i]);
            shares[i] = share;
        }
        shareRepository.insert(shares);
        new Thread(() -> EmailUtils.getInstance().sendEmail(toEmails,subject,text)).start();
    }

    public List<Share> findAll() {
        return shareRepository.findAll();
    }

    public List<Share> findAll(int page, int pageSize) {
        return shareRepository.findAll((page - 1) * pageSize,pageSize);
    }

    public List<Share> findByUserId(String userId) {
        return shareRepository.findByUserId(userId);
    }

    public List<Share> findByTitle(String title, int page, int pageSize) {
        return shareRepository.findByVideoTitle(title,(page - 1) * pageSize,pageSize);
    }

    public Long countByTitle(String title) {
        return shareRepository.countByTitle(title);
    }

    public Long countAll() {
        return shareRepository.countAll();
    }

    public Long countByDate(Date date) {
        return shareRepository.countByDate(date);
    }

}
