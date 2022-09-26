package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface PageDetailService {
	public void getGoodsInfo(HttpServletRequest request, Model model);
}
