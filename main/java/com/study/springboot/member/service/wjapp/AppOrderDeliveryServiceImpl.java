package com.study.springboot.member.service.wjapp;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dao.wjapp.AppKMemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;

@Service
public class AppOrderDeliveryServiceImpl implements AppOrderDeliveryService
{

	@Autowired
	AppKMemberDao appDao;
	@Autowired
    MemberDao memberDao;

	@Override
	public ArrayList<OrderDeliveryDto> appOrderDeliveryInfo(HttpServletRequest request)
	{
		String bcm_num = request.getParameter("num");
		
		ArrayList<OrderDeliveryDto> obj = new ArrayList<OrderDeliveryDto>();
		ArrayList<String> ordernumList = appDao.selectOrdernum(Integer.parseInt(bcm_num));
		
		for(String ordernum : ordernumList) {
			OrderDeliveryDto dto = appDao.appOrderList(ordernum);
			obj.add(dto);
		}
		return obj;
	}

	@Override
	public void appStatusChange(HttpServletRequest request) {
		String status = request.getParameter("status");
		String num = request.getParameter("num");
		int bcm_num = Integer.parseInt(num);
		String bco_ordernum = request.getParameter("ordernum");
		if(status.equals("취소신청")) {
//			System.out.println("취소신청");
			memberDao.cancellationRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("교환신청")) {
//			System.out.println("교환신청");
			memberDao.exchangeRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("반품신청")) {
//			System.out.println("반품신청");
			memberDao.refundRequest(bcm_num,bco_ordernum);
		}
		else if(status.equals("구매확정")) {
//			System.out.println("구매확정");
			memberDao.purchaseConfirmation(bcm_num,bco_ordernum);
		}
	}
	
	@Override
	public ArrayList<OrderDeliveryDto> appcancelExchangeRefund(HttpServletRequest request)
	{
		String bcm_num = request.getParameter("num");
		
		ArrayList<OrderDeliveryDto> obj = new ArrayList<OrderDeliveryDto>();
		ArrayList<String> ordernumList = appDao.selectCEROrdernum(Integer.parseInt(bcm_num));
		
		for(String ordernum : ordernumList) {
			OrderDeliveryDto dto = appDao.appOrderList(ordernum);
			obj.add(dto);
		}
		return obj;
	}
}
