package com.bravos.yeutube.dto;

import com.bravos.yeutube.model.User;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserInfo {

    private String id;
    private String fullName;
    private Boolean admin;

    public UserInfo(User user) {
        this.id = user.getId();
        this.fullName = user.getFullName();
        this.admin = user.getAdmin();
    }

}
