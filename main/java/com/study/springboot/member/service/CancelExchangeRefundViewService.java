package com.study.springboot.member.service;

import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface CancelExchangeRefundViewService {
    public void cancelExchangeRefundView(HttpServletRequest request, Model model);
}
