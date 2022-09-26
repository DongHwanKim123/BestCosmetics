package com.study.springboot.member.service;

import java.util.List;

import org.springframework.ui.Model;

import com.study.springboot.member.dto.OrderDetail;

public interface OrderDetailService
{
	public List<OrderDetail> orderDetail(String bco_ordernum, Model model);
}
