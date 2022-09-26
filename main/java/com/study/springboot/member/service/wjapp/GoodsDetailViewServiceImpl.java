package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
@Service
public class GoodsDetailViewServiceImpl implements GoodsDetailViewService{
    @Autowired
    AppGoodsDao appGoodsDao;
    @Override
    public JSONObject goodsDetailView(HttpServletRequest request) {
        String bcgKey = request.getParameter("bcgKey");
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("item", appGoodsDao.goodsSelectOne(bcgKey));
        jsonObject.put("detail",appGoodsDao.goodsDetail(bcgKey));
        return jsonObject;
    }
}
