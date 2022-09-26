package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

public interface AppOrderInfoService {
	public JSONObject orderInfo(HttpServletRequest request);
}
