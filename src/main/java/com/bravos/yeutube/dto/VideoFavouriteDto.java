package com.bravos.yeutube.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VideoFavouriteDto {

    private String title;
    private Long likes;
    private Boolean active;

}
