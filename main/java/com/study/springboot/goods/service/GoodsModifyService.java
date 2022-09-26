package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

import com.study.springboot.goods.dto.GoodsDto;

public interface GoodsModifyService {

	public GoodsDto mdPickCheck(HttpServletRequest request, Model model);
	
}
