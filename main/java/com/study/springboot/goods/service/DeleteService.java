package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface DeleteService {
	public int delete(HttpServletRequest request, Model model);
	public int deleteDetail(HttpServletRequest request, Model model);
}