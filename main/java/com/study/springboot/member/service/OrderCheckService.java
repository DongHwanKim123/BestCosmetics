package com.study.springboot.member.service;

import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface OrderCheckService {
    public JSONObject orderCheck (HttpServletRequest request, Model model);
}
