package com.study.springboot.goods.service.hs;

import com.study.springboot.goods.dto.GoodsDto;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public interface AGoodsMainListViewService {
    public ArrayList<GoodsDto> goodsMDListView(HttpServletRequest request);
    public ArrayList<GoodsDto> goodsBestListView(HttpServletRequest request);
    public ArrayList<GoodsDto> goodsNewListView(HttpServletRequest request);
}
