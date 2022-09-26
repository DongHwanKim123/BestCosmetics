package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.OrderDetail;

@Service
public class AppOrderDetailServiceImpl implements AppOrderDetailService
{
	@Autowired
	KMemberDao dao;
	
	@Override
	public ArrayList<OrderDetail> appOrderDetail(HttpServletRequest request) {
		String bco_ordernum = request.getParameter("orderNum");
		ArrayList<OrderDetail> obj = dao.orderDetail(bco_ordernum);
		return obj;
	}

}
