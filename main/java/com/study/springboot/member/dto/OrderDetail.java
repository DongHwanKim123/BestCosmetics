package com.study.springboot.member.dto;

import lombok.Data;

@Data
public class OrderDetail
{
	private String bco_ordernum;
	private int bcg_key;
	private int bcd_detailkey;
	private int bco_count;
	private String bcg_name;
	private int bcg_price;
	private String bcg_img;
	private String bcd_option;
	private int total_price;
	private String bco_order_status;
	private String bco_reviewcheck;
}
