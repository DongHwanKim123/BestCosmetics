package com.study.springboot.member.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class DeliveryInfoDto {
    private int bcm_num;
    private String bco_ordernum;
    private String bcd_zipcode;
    private String bcd_address1;
    private String bcd_address2;
    private String bcd_address3;
    private Timestamp bcd_date;
    private String bcd_request;
}
