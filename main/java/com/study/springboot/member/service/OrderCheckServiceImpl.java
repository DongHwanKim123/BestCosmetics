package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.GoodsJoinDetailGoodsDto;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;


@Service
public class OrderCheckServiceImpl implements OrderCheckService{
    @Autowired
    MemberDao memberDao;
    @Override
    public JSONObject orderCheck(HttpServletRequest request, Model model) {
        String keyList = request.getParameter("keyList");
        String detailkeyList = request.getParameter("detailkeyList");
        String countList = request.getParameter("countList");

//        System.out.println("keyList = " + keyList);
//        System.out.println("detailkeyList = " + detailkeyList);
//        System.out.println("countList = " + countList);

        String[] keyListArr = keyList.split("/");
        String[] detailkeyListArr = detailkeyList.split("/");
        String[] countListArr = countList.split("/");

        JSONObject obj = new JSONObject();

        for(int i = 0 ; i<keyListArr.length ; i++){
//            System.out.println("keyListArr "+ i +" = " + keyListArr[i]);
//            System.out.println("detailkeyListArr " + i +" = " + detailkeyListArr[i]);
//            System.out.println("countListArr " + i +" = " + countListArr[i]);
            GoodsJoinDetailGoodsDto dto = memberDao.orderCheck(keyListArr[i] , detailkeyListArr[i]);
            dto.setCount(countListArr[i]);

            JSONArray jsonArray = new JSONArray();
            jsonArray.add(dto);
            obj.put("orderList"+i, jsonArray);

        }
//        System.out.println(obj.toJSONString());
        return obj;
    }
}
