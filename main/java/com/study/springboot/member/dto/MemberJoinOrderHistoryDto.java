package com.study.springboot.member.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MemberJoinOrderHistoryDto {
    private int bcm_num;
    private String bcm_id;
    private String bcm_pw;
    private String bcm_name;
    private String bcm_email;
    private String bcm_googleid;
    private String bcm_naverid;
    private String bcm_kakaoid;
    private String bcm_facebookid;
    private String bcm_zipcode;
    private String bcm_address1;
    private String bcm_address2;
    private String bcm_address3;
    private String bcm_phonenum1;
    private String bcm_phonenum2;
    private String bcm_phonenum3;
    private String bcm_authority;
    private String bcm_enable;
    private Timestamp bcm_joined_on;
    private Timestamp bcm_stopdate;
    private int order_count;
    private int total_price;
}
