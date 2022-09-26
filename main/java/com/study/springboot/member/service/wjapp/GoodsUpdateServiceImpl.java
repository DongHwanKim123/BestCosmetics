package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;

@Service
public class GoodsUpdateServiceImpl implements GoodsUpdateService{
    @Autowired
    AppGoodsDao appGoodsDao;

    @Override
    public void goodsFavoriteCount(HttpServletRequest request) {
        String bcgKey = request.getParameter("bcgKey");
        String count = request.getParameter("count");
        String bcmNum = request.getParameter("bcmNum");
        if (count.equals("up")){
            appGoodsDao.goodsFavoriteUp(bcgKey);
            appGoodsDao.memberFavoriteUp(bcmNum,bcgKey);
        }else if(count.equals("down")){
            appGoodsDao.goodsFavoriteDown(bcgKey);
            appGoodsDao.memberFavoriteDown(bcmNum,bcgKey);
        }
    }
}
