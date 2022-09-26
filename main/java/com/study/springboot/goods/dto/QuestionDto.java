package com.study.springboot.goods.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class QuestionDto {
    private int bcg_key;
    private String bcg_name;
    private int bcm_num;
    private String bcm_name;
    private Timestamp bcq_date;
    private String bcq_content;
    private String bcq_secret;
    private Timestamp bca_date;
    private String bca_content;
}
