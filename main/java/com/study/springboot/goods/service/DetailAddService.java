package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import com.study.springboot.goods.dto.GoodsDetailDto;

import javax.servlet.http.HttpServletRequest;

public interface DetailAddService {
	public int insertDetail(HttpServletRequest request, Model model);
	public GoodsDetailDto detailKeyCheck(HttpServletRequest request, Model model);
}