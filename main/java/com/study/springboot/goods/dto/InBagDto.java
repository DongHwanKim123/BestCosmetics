package com.study.springboot.goods.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class InBagDto
{
	private int bcm_num;
	private int bcg_key;
	private int bcd_detailkey;
	private Timestamp bcb_date;
	private int bcb_count;
}