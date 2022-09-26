package com.study.springboot.member.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class GoodsJoinBasketJoinGoodDetailDto {
    //상품db
    private int bcg_key;
    private String bcg_category;
    private String bcg_name;
    private int bcg_price;
    private Timestamp bcg_date;
    private int bcg_stock;
    private int bcg_sale;
    private int bcg_like;
    private String bcg_img;
    private String bcg_imgdetail;
    private String bcg_info;
    private int bcg_discount;
    private int bcg_mdpick;
    //장바구니DB
    private int bcm_num;
    private int bcd_detailkey;
    private Timestamp bcb_date;
    private int bcb_count;
    //상품detail db
    private String bcd_option;
    private String bcd_stock;
}
