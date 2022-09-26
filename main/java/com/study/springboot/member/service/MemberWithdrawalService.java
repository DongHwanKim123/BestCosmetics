package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface MemberWithdrawalService {
	public String withdrawal(HttpServletRequest request);
}
