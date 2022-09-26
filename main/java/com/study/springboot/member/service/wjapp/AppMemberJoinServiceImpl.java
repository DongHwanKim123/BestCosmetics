package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.wjapp.AppKMemberDao;

@Service
public class AppMemberJoinServiceImpl implements AppMemberJoinService{

	@Autowired
	AppKMemberDao dao;
	
	@Override
	public JSONObject AppMemberJoin(HttpServletRequest request) {
		JSONObject obj = new JSONObject();
		String bcm_id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String bcm_name = request.getParameter("name");
		String bcm_email = request.getParameter("email");
		
		String bcm_pw = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(pw);
		
		int insertCount = dao.createAppMemberAccount(bcm_id, bcm_pw, bcm_name, bcm_email);
		if(insertCount == 1) {
			obj.put("result", "success");
		}
		else {
			obj.put("result", "error");
		}
		return obj;
	}
	
}
