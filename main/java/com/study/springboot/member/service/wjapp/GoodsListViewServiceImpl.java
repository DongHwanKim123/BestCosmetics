package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Service
public class GoodsListViewServiceImpl implements GoodsListViewService{
    @Autowired
    AppGoodsDao appGoodsDao;
    @Override
    public ArrayList<GoodsDto> goodsListView(HttpServletRequest request) {
        return appGoodsDao.goodsListView();
    }
    @Override
    public ArrayList<GoodsDto> goodsSkinCareListview(HttpServletRequest request) {
        return appGoodsDao.goodsSkinCareListview();
    }
    @Override
    public ArrayList<GoodsDto> goodsPointListview(HttpServletRequest request) {
        return appGoodsDao.goodsPointListview();
    }
    @Override
    public ArrayList<GoodsDto> goodsBaseListview(HttpServletRequest request) {
        return appGoodsDao.goodsBaseListview();
    }
}
