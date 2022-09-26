package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface QuestionListAdminViewService {
    public void questionListView(HttpServletRequest request, Model model);
    public int AdminAnswer(HttpServletRequest request, Model model);
}
