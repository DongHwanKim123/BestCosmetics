package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface OrderManagement {
	public void deliveryReady(HttpServletRequest request, Model model); // <주문관리> 배송준비
	public void inTransit(HttpServletRequest request, Model model); // <주문관리> 배송중
	public void deliveryCompleted(HttpServletRequest request, Model model); // <주문관리> 배송완료
	public void purchaseConfirmation(HttpServletRequest request, Model model); // <주문관리> 구매확정
	public void cancelExchangeRefundAdmin(HttpServletRequest request, Model model); // <주문관리> 취소/교환/반품
	public void orderListAdmin(HttpServletRequest request, Model model); // <주문관리> 주문리스트(전체)
	
	public void drSearch(HttpServletRequest request, Model model); // 배송준비 화면에서 검색
	public void itSearch(HttpServletRequest request, Model model); // 배송중 화면에서 검색
	public void dcSearch(HttpServletRequest request, Model model); // 배송완료 화면에서 검색
	public void pcSearch(HttpServletRequest request, Model model); // 구매확정 화면에서 검색
	public void cerSearch(HttpServletRequest request, Model model); // 취소/교환/반품 화면에서 검색
	public void olSearch(HttpServletRequest request, Model model); // 주문리스트(전체) 에서 검색
	
	public String stateInTransit(HttpServletRequest request, Model model); // <주문관리> 배송중으로 상태변경
	public String stateDeliveryCompleted(HttpServletRequest request, Model model); // <주문관리> 배송완료로 상태변경
	public String stateChange(HttpServletRequest request, Model model); // <주문관리> 배송준비중,배송중,배송완료,구매확정을 제외한 상태로 변경
}
