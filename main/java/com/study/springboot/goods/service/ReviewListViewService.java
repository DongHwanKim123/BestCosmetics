package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface ReviewListViewService {
    public void reviewListView(HttpServletRequest request, Model model);
}
