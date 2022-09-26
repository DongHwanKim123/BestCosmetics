package com.study.springboot.goods.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ReviewDto {
    private int bcg_key;
    private String bcg_name;
    private int bcm_num;
    private String bcm_name;
    private String bcr_photo;
    private int bcr_score;
    private Timestamp bcr_date;
    private String bcr_content;
    private String bco_ordernum;
}
