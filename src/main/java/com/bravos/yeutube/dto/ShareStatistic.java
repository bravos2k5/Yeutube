package com.bravos.yeutube.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ShareStatistic {

    private String title;
    private Long shareCount;
    private Timestamp firstShareDate;
    private Timestamp endShareDate;
}
