package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.member.dto.MemberDto;

public interface AppMemberInfoService
{
	public MemberDto appGetMemberInfo(HttpServletRequest request);
	public void appUpdateMemberInfo(HttpServletRequest request);
	public int updateFcmToken(HttpServletRequest request);

}
