package com.study.springboot.member.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.member.dto.OrderDetail;
import com.study.springboot.member.dto.ValidationMember;
import com.study.springboot.member.service.JoinService;
import com.study.springboot.member.service.LikeService;
import com.study.springboot.member.service.MemberWithdrawalService;
import com.study.springboot.member.service.OrderDetailService;
import com.study.springboot.member.service.OrderManagement;
import com.study.springboot.member.service.PwChangeService;
import com.study.springboot.member.service.PwCheckService;

@Controller
public class KMemberController
{
	@Autowired
	LikeService likeService;
	@Autowired
	OrderDetailService orderDetail; 
	@Autowired
	PwChangeService pwChange;
	@Autowired
	PwCheckService pwCheck;
	@Autowired
	MemberWithdrawalService withdrawal;
	@Autowired
	JoinService joinService;
	@Autowired
	OrderManagement OrderManagement;

	@RequestMapping("/guest/channelTalk")
	public String channelTalk() {
		return "guest/log/channelTalk";
	}
	@RequestMapping("/guest/loginView")
	public String loginView(HttpServletRequest request) {
		String uri = request.getHeader("Referer");
	    if (uri != null && !uri.contains("/loginDo")) {
	        request.getSession().setAttribute("prevPage", uri);
	    }
		return "guest/log/loginView";
	}
	@RequestMapping("/member/like")
	public String likeView(HttpServletRequest request, Model model) {
		likeService.likeList(request, model);
		return "member/likeList";
	}
	@RequestMapping("/member/likeDelete")
	public @ResponseBody String likeDelete(HttpServletRequest request) {
		return likeService.likeDelete(request);
	}
	@RequestMapping("/member/orderDetail")
	public @ResponseBody List<OrderDetail> orderDetailView(@RequestParam("bco_ordernum") String ordernum ,HttpServletRequest request, Model model) {
		return orderDetail.orderDetail(ordernum, model);
	}
	@RequestMapping("/member/passwordChange")
	public String pwChangeView() {
		return "member/passwordChange";
	}
	@RequestMapping("/member/pwCheck")
	public @ResponseBody String pwCheck(HttpServletRequest request, Model model) {
		String result = "";
		if(pwCheck.pwCheck(request, model)) {
			result = "일치";
		}
		else {
			result = "불일치";
		}
		return result;
	}
	@RequestMapping("/member/pwChange")
	public @ResponseBody String pwChange(@ModelAttribute("dto") @Valid ValidationMember validationMember,
											BindingResult bindingResult,
											HttpServletRequest request,
											Model model) {
		String result = "";
		String errorMessage = pwChange.joinValidation(validationMember, bindingResult);
		if (errorMessage != null) {
			result = errorMessage;
			return result;
		}
		result = pwChange.pwChange(request, model);
		return result;
	}
	@RequestMapping("/member/out")
	public String memberWithdrawal() {
		return "/member/memberWithdrawal";
	}
	@RequestMapping("/member/memberDelete")
	public @ResponseBody String memberDelete(HttpServletRequest request, Model model) {
		return withdrawal.withdrawal(request);
	}
	@RequestMapping("/admin/adminTop")
	public String adminTop() {
		return "/admin/adminTop";
	}
	@RequestMapping("/admin/adminPageView")
	public String adminPageView() {
		return "/admin/adminPageView";
	}
	@RequestMapping("/admin/adminMain")
	public String adminMain() {
		return "/admin/adminMain";
	}
	
	

	@RequestMapping("/admin/deliveryReady")
	public String deliveryReady(HttpServletRequest request, Model model) {
		OrderManagement.deliveryReady(request, model);
		return "/admin/deliveryReady";
	}
	@RequestMapping("/admin/inTransit")
	public String inTransit(HttpServletRequest request, Model model) {
		OrderManagement.inTransit(request, model);
		return "/admin/inTransit";
	}
	@RequestMapping("/admin/deliveryCompleted")
	public String deliveryCompleted(HttpServletRequest request, Model model) {
		OrderManagement.deliveryCompleted(request, model);
		return "/admin/deliveryCompleted";
	}
	@RequestMapping("/admin/purchaseConfirmation")
	public String purchaseConfirmation(HttpServletRequest request, Model model) {
		OrderManagement.purchaseConfirmation(request, model);
		return "/admin/purchaseConfirmation";
	}
	@RequestMapping("/admin/cancelExchangeRefundAdmin")
	public String cancelExchangeRefundAdmin(HttpServletRequest request, Model model) {
		OrderManagement.cancelExchangeRefundAdmin(request, model);
		return "/admin/cancelExchangeRefundAdmin";
	}
	@RequestMapping("/admin/orderListAdmin")
	public String orderListAdmin(HttpServletRequest request, Model model) {
		OrderManagement.orderListAdmin(request, model);
		return "/admin/orderListAdmin";
	}
	
	
	@RequestMapping("/admin/drSearch")
	public String drSearch(HttpServletRequest request, Model model) {
		OrderManagement.drSearch(request, model);
		return "/admin/deliveryReady";
	}
	@RequestMapping("/admin/itSearch")
	public String itSearch(HttpServletRequest request, Model model) {
		OrderManagement.itSearch(request, model);
		return "/admin/inTransit";
	}
	@RequestMapping("/admin/dcSearch")
	public String dcSearch(HttpServletRequest request, Model model) {
		OrderManagement.dcSearch(request, model);
		return "/admin/deliveryCompleted";
	}
	@RequestMapping("/admin/pcSearch")
	public String pcSearch(HttpServletRequest request, Model model) {
		OrderManagement.pcSearch(request, model);
		return "/admin/purchaseConfirmation";
	}
	@RequestMapping("/admin/cerSearch")
	public String cerSearch(HttpServletRequest request, Model model) {
		OrderManagement.cerSearch(request, model);
		return "/admin/cancelExchangeRefundAdmin";
	}
	@RequestMapping("/admin/olSearch")
	public String olSearch(HttpServletRequest request, Model model) {
		OrderManagement.olSearch(request, model);
		return "/admin/orderListAdmin";
	}
	
	
	@RequestMapping("/admin/stateInTransit")
	public @ResponseBody String stateInTransit(HttpServletRequest request, Model model) {
		return OrderManagement.stateInTransit(request, model);
	}
	@RequestMapping("/admin/stateDeliveryCompleted")
	public @ResponseBody String stateDeliveryCompleted(HttpServletRequest request, Model model) {
		return OrderManagement.stateDeliveryCompleted(request, model);
	}
	@RequestMapping("/admin/stateChange")
	public @ResponseBody String stateChange(HttpServletRequest request, Model model) {
		return OrderManagement.stateChange(request, model);
	}
}
