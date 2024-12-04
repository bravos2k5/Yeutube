package com.bravos.yeutube.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.UUID;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LikeStatistic {

    private UUID videoId;
    private String title;
    private Long likeCount;
    private Timestamp latestDate;
    private Timestamp firstDate;

}
