package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.member.dto.OrderDetail;

public interface AppOrderDetailService {
	public ArrayList<OrderDetail> appOrderDetail(HttpServletRequest request);
}
