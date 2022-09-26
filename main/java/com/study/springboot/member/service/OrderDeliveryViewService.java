package com.study.springboot.member.service;

import com.study.springboot.member.dto.OrderDeliveryDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface OrderDeliveryViewService {
    public void OrderDelivertyView(HttpServletRequest request, Model model);
    public int cancellationRequest(HttpServletRequest request, Model model);
    public int exchangeRequest(HttpServletRequest request, Model model);
    public int refundRequest(HttpServletRequest request, Model model);
    public int purchaseConfirmation(HttpServletRequest request, Model model);
}
