package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

public interface AfterPaymentService {
    public int afterPayment(HttpServletRequest request);
}
