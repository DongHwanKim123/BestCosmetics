package com.study.springboot.member.service.wjapp;

import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletRequest;

public interface GoodsDetailViewService {
    public JSONObject goodsDetailView(HttpServletRequest request);
}
