package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;

public interface AppMemberJoinService {
	public JSONObject AppMemberJoin(HttpServletRequest request);
}
