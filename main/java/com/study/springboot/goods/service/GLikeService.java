package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface GLikeService {
	public int likeTableUpdate(HttpServletRequest request, Model model);
}
