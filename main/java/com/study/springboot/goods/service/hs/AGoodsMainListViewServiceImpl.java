package com.study.springboot.goods.service.hs;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.goods.dao.hs.YGoodsDao;
import com.study.springboot.goods.dto.GoodsDto;

@Service
public class AGoodsMainListViewServiceImpl implements AGoodsMainListViewService{
    @Autowired
    YGoodsDao yGoodsDao;
    @Override
    public ArrayList<GoodsDto> goodsMDListView(HttpServletRequest request) {
        return yGoodsDao.goodsMDListView();
    }
    @Override
    public ArrayList<GoodsDto> goodsBestListView(HttpServletRequest request) {
        return yGoodsDao.goodsBestListView();
    }
    @Override
    public ArrayList<GoodsDto> goodsNewListView(HttpServletRequest request) {
        return yGoodsDao.goodsNewListView();
    }

}
