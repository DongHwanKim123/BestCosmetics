package com.study.springboot.goods.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class GoodsJoinLikes {
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
    private String item;
}
