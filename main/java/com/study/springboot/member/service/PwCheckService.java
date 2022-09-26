package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface PwCheckService {
	public boolean pwCheck(HttpServletRequest request, Model model);
}
