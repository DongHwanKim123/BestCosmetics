package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.wjapp.AppKMemberDao;
import com.study.springboot.member.dto.AppOrderInfo;

@Service
public class AppOrderInfoServiceImpl implements AppOrderInfoService
{

	@Autowired
	AppOrderInfo orderInfo;
	@Autowired
	AppKMemberDao appDao;
	
	@Override
	public JSONObject orderInfo(HttpServletRequest request) {
		
		JSONObject obj = new JSONObject();
		String bcm_num = request.getParameter("num");
		orderInfo = appDao.orderInfo(Integer.parseInt(bcm_num));
		
		obj.put("deliveryready", orderInfo.getDeliveryready());
		obj.put("intransit", orderInfo.getIntransit());
		obj.put("deliverycompleted", orderInfo.getDeliverycompleted());
		
		return obj;
	}
}
