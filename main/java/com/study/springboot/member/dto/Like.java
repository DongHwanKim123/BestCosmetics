package com.study.springboot.member.dto;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class Like
{
	private int bcm_num;
	private int bcg_key;
	private String bcg_img;
}
