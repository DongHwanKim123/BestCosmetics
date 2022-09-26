package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.MemberDto;

@Service
public class AppPasswordChangeServiceImpl implements AppPasswordChangeService
{
	@Autowired
	KMemberDao dao;
	@Autowired
	MemberDto dto;
	
	@Override
	public String appPasswordChangeResult(HttpServletRequest request) {
		String result = "";
		
		String currentPassword = request.getParameter("currentPassword"); // 앱에서 받아온 현재 비밀번호
		String newPassword = request.getParameter("newPassword"); // 앱에서 받아온 새로운 비밀번호
		String bcm_num = request.getParameter("num"); // 앱에서 받아온 회원번호
		
		dto = dao.pwCheck(bcm_num);
		String DBpw = dto.getBcm_pw(); // DB에서 현재 비밀번호 가져옴
		
		if(encoder().matches(currentPassword, DBpw)) { // DB 에 있는 비밀번호와 앱에서 받아온 현재 비밀번호를 확인(true/false)
			// 비밀번호가 서로 일치하면 비밀번호 변경을 진행
			String bcm_pw = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(newPassword); // 앱에서 받아온 새로운 비밀번호를 암호화
			dao.pwChange(bcm_num, bcm_pw); // 암호화 된 새로운 비밀번호를 앱에서 가져온 회원번호를 조건으로 변경
			result = "success";
		}
		else {
			// 비밀번호가 서로 일치하지 않으면 에러 메세지 보냄
			result = "fail";
		}
		
		return result;
	}
	public PasswordEncoder encoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}