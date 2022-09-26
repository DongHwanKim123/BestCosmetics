package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface ListService {
	public void list(HttpServletRequest request, Model model);
	public void mdList(HttpServletRequest request, Model model);
	public void bestList(HttpServletRequest request, Model model);
	public void newList(HttpServletRequest request, Model model);
	public void allList(HttpServletRequest request, Model model);
	public void searchList(HttpServletRequest request, Model model, String type, String srchText);
	public void searchList2(HttpServletRequest request, Model model, String type, String srchText);
	public void searchCList2(HttpServletRequest request, Model model, String type, String srchText);
	public void pointList(HttpServletRequest request, Model model);
}
