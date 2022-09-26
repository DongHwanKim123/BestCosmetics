package com.study.springboot.goods.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface QuestionListViewService {
    public void questionListView(HttpServletRequest request, Model model);
}
