package com.study.springboot.member.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface BasketService {
    public int deleteBasket(HttpServletRequest request, Model model);
    public int basketUpCount(HttpServletRequest request,Model model);
    public int basketDownCount(HttpServletRequest request,Model model);
    public int basketCount(HttpServletRequest request, Model model);
}
