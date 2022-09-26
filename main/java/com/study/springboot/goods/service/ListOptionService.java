package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface ListOptionService {
   public void optionList(HttpServletRequest request, Model model, int BCG_KEY);
   public int stockUpdate(HttpServletRequest request, Model model);
   public int optionDelete(HttpServletRequest request, Model model);
}