package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsDto;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public interface GoodsListViewService {
    public ArrayList<GoodsDto> goodsListView(HttpServletRequest request);
    public ArrayList<GoodsDto> goodsSkinCareListview(HttpServletRequest request);
    public ArrayList<GoodsDto> goodsPointListview(HttpServletRequest request);
    public ArrayList<GoodsDto> goodsBaseListview(HttpServletRequest request);
}
