package com.study.springboot.goods.dto;

import java.security.Timestamp;

import lombok.Data;

@Data
public class Like {
	int bcm_num;
	int bcg_key;
	Timestamp bcl_date;
}
