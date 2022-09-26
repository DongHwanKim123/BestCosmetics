package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface LikeService
{
	public void likeList(HttpServletRequest request, Model model);
	public String likeDelete(HttpServletRequest request);
}
