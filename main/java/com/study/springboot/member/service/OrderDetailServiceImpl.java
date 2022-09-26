package com.study.springboot.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.OrderDetail;

@Service
public class OrderDetailServiceImpl implements OrderDetailService
{
	@Autowired
	KMemberDao dao;

	@Override
	public List<OrderDetail> orderDetail(String bco_ordernum, Model model)
	{
		List<OrderDetail>od = dao.orderDetail(bco_ordernum);

		return od;
	}
}
