package com.study.springboot.member.service;

import com.study.springboot.member.dto.DeliveryInfoDto;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;

public interface UtilService {
    public String createOrderNum(HttpServletRequest request, Model model);
    public JSONObject lastDeliveryDestination(HttpServletRequest request);
    public ArrayList<DeliveryInfoDto> appLastDeliveryDestination(HttpServletRequest request);
    public void fcmAllmember(Model model, HttpServletRequest request, HttpServletResponse response);
}
