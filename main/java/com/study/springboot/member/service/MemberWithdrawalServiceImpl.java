package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;

@Service
public class MemberWithdrawalServiceImpl implements MemberWithdrawalService{

	@Autowired
	KMemberDao dao;
	@Override
	public String withdrawal(HttpServletRequest request) {
		String result = "";
		String bcm_num = request.getParameter("bcm_num");
		
		int deleteCount = dao.memberDelete(bcm_num);

		//
		// 리뷰 db
		// 문의 db
		// 장바구니db
		// 찜db
		// 주문번호 가져와서 주문상세 지우고
		// 주문내역 db
		// 배송지 db
		if(deleteCount == 1) {
			result = "탈퇴완료";
		}
		else {
			result = "탈퇴에러";
		}
		return result;
	}

}
