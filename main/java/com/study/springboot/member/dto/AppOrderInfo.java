package com.study.springboot.member.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class AppOrderInfo {
	private int deliveryready;
	private int intransit;
	private int deliverycompleted;
}
