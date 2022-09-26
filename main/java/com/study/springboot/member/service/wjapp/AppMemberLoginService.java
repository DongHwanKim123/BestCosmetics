package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;


public interface AppMemberLoginService
{
	public JSONObject memberLogin(HttpServletRequest request);
}
