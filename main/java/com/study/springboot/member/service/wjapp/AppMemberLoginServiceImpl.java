package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.wjapp.AppKMemberDao;
import com.study.springboot.member.dto.MemberDto;

@Service
public class AppMemberLoginServiceImpl implements AppMemberLoginService
{
	@Autowired
	AppKMemberDao AppDao;
	@Autowired
	MemberDto dto;

	@Override
	public JSONObject memberLogin(HttpServletRequest request)
	{
		JSONObject obj = new JSONObject();
		String bcm_id = request.getParameter("id");
		String appPassword = request.getParameter("pw");
		bcm_id = bcm_id.trim();
		appPassword = appPassword.trim();
		
		String dbPassword = AppDao.AppPwCheck(bcm_id);
		String getNum = "";
		String getID = "";
		String getName = "";
		String getEmail = "";
		if(dbPassword == null) {
			obj.put("error", "아이디나 비밀번호가 일치하지 않습니다.");
		}
		else {
			if(encoder().matches(appPassword, dbPassword)) {
				dto = AppDao.getMemberInfo(bcm_id);
				getNum = Integer.toString(dto.getBcm_num());
				getID = dto.getBcm_id();
				getName = dto.getBcm_name();
				getEmail = dto.getBcm_email();
				obj.put("error", "ok");
				obj.put("Num", getNum);
				obj.put("Id", getID);
				obj.put("Name", getName);
				obj.put("Email", getEmail);
			}
			else {
				obj.put("error", "아이디나 비밀번호가 일치하지 않습니다.");
			}
		}
		
		return obj;
	}
	public PasswordEncoder encoder() {
		return PasswordEncoderFactories.createDelegatingPasswordEncoder();
	}
}
