package com.study.springboot.member.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.OrderDetail;
import com.study.springboot.member.service.MemberWithdrawalService;
import com.study.springboot.member.service.SnsService;
import com.study.springboot.member.service.wjapp.AppMemberInfoService;
import com.study.springboot.member.service.wjapp.AppMemberJoinService;
import com.study.springboot.member.service.wjapp.AppMemberLoginService;
import com.study.springboot.member.service.wjapp.AppOrderDeliveryService;
import com.study.springboot.member.service.wjapp.AppOrderDetailService;
import com.study.springboot.member.service.wjapp.AppOrderInfoService;
import com.study.springboot.member.service.wjapp.AppPasswordChangeService;

@RestController
public class KMemberRestController
{
	@Autowired
	AppMemberLoginService memberLoginService;
	@Autowired
	AppMemberJoinService memberJoinService;
	@Autowired
	SnsService snsService;
	@Autowired
	AppOrderInfoService orderInfoService;
	@Autowired
	AppOrderDeliveryService orderDeliveryService;
	@Autowired
	AppOrderDetailService orderDetailService;
	@Autowired
	AppPasswordChangeService passwordChangeService;
	@Autowired
	AppMemberInfoService memberInfoService;
	@Autowired
	MemberWithdrawalService withdrawalService;
	
    @PostMapping("/api/login")
    public JSONObject memberCheck(HttpServletRequest request) {
        return memberLoginService.memberLogin(request);
    }
    @PostMapping("/api/appjoin")
    public JSONObject appJoin(HttpServletRequest request) {
        return memberJoinService.AppMemberJoin(request);
    }
    @PostMapping("/api/snsLogin")
    public JSONObject appSnsLogin(HttpServletRequest request) {
        return snsService.appSnsLogin(request);
    }
    @PostMapping("/api/orderInfo")
    public JSONObject orderInfo(HttpServletRequest request) {
        return orderInfoService.orderInfo(request);
    }
    @RequestMapping("/api/orderdelivery")
    public ArrayList<OrderDeliveryDto> appOrderdelivery(HttpServletRequest request) {
        return orderDeliveryService.appOrderDeliveryInfo(request);
    }
    @PostMapping("/api/orderdetail")
    public ArrayList<OrderDetail> appOrderdetail(HttpServletRequest request) {
        return orderDetailService.appOrderDetail(request);
    }
    @PostMapping("/api/statusChange")
    public void appstatusChange(HttpServletRequest request) {
    	orderDeliveryService.appStatusChange(request);
    }
    @RequestMapping("/api/cancelExchangeRefund")
    public ArrayList<OrderDeliveryDto> cancelExchangeRefund(HttpServletRequest request) {
        return orderDeliveryService.appcancelExchangeRefund(request);
    }
    @PostMapping("/api/passwordChange")
    public String appPasswordChange(HttpServletRequest request) {
        return passwordChangeService.appPasswordChangeResult(request);
    }
    @PostMapping("/api/getUserInfo")
    public MemberDto appGetUserInfo(HttpServletRequest request) {
        return memberInfoService.appGetMemberInfo(request);
    }
    @PostMapping("/api/updateUserInfo")
    public void appUpdateUserInfo(HttpServletRequest request) {
    	memberInfoService.appUpdateMemberInfo(request);
    }
    @PostMapping("/api/deleteMember")
    public String appDeleteMember(HttpServletRequest request) {
    	return withdrawalService.withdrawal(request);
    }
}