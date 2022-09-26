package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

public interface SnsService {
	public void snsLogin(String snsName, String id, String name, String email);
	public JSONObject appSnsLogin(HttpServletRequest request);
}
