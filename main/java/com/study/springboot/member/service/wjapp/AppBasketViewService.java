package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public interface AppBasketViewService {
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketView(HttpServletRequest request);
}
