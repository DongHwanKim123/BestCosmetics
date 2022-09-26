package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.MemberDto;

@Service
public class PwCheckServiceImpl implements PwCheckService{

	@Autowired
	KMemberDao dao;
	@Autowired
	MemberDto dto;
	
	@Override
	public boolean pwCheck(HttpServletRequest request, Model model) {
		boolean isPwCheck = false;
		String bcm_num = request.getParameter("bcm_num");
		String cPw = request.getParameter("cPw");
		dto = dao.pwCheck(bcm_num);
		String bcm_pw = dto.getBcm_pw();
		
		if(encoder().matches(cPw, bcm_pw)) {
			isPwCheck = true;
		}
		else {
			isPwCheck = false;
		}
		System.out.println(isPwCheck);
		return isPwCheck;
	}
	public PasswordEncoder encoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
