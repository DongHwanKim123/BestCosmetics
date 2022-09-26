package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsDto;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

public interface AppSearchService {
    public ArrayList<GoodsDto> searching(HttpServletRequest request);
    public ArrayList<GoodsDto> searchSubmitted(HttpServletRequest request);
}
