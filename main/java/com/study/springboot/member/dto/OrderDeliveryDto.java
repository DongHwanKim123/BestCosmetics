package com.study.springboot.member.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class OrderDeliveryDto {
    private int bcm_num;
    private String bco_phonenum1;
    private String bco_phonenum2;
    private String bco_phonenum3;
    private String bco_ordernum;
    private String bcm_name;
    private String bco_recipient;
    private int bco_totalprice;
    private String bco_order_status;
    private Timestamp bco_orderdate;
    private Timestamp bco_deliverydate;
    private Timestamp bco_statusdate;
    private String bco_order_name;
    private String bcg_img;
}
