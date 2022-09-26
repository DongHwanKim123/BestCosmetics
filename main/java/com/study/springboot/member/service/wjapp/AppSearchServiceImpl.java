package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
@Service
public class AppSearchServiceImpl implements AppSearchService{
    @Autowired
    AppGoodsDao appGoodsDao;
    @Override
    public ArrayList<GoodsDto> searching(HttpServletRequest request) {
        return appGoodsDao.seaching("%"+request.getParameter("seachStr")+"%");
    }

    @Override
    public ArrayList<GoodsDto> searchSubmitted(HttpServletRequest request) {
        return appGoodsDao.seachSubmitted("%"+request.getParameter("seachStr")+"%");
    }
}
