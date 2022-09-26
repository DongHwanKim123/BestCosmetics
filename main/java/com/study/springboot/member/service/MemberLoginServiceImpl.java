package com.study.springboot.member.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.MemberDto;

@Service
public class MemberLoginServiceImpl implements MemberLoginService {

	@Autowired
	private HttpSession session;
	@Autowired
	MemberDto dto;
	@Autowired
    KMemberDao memberDao;
	
	@Override
	public void memberLogin(String bcm_id) {
		
		dto = memberDao.memberSession(bcm_id);
		int num = dto.getBcm_num();
		String id = dto.getBcm_id();
		String name = dto.getBcm_name();
		String email = dto.getBcm_email();
		session.setAttribute("num", num);
		session.setAttribute("id", id);
		session.setAttribute("name", name);
		session.setAttribute("email", email);
	}

}
