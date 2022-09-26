package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import com.study.springboot.member.dto.Like;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Service
public class MemberLikeListServiceImpl implements MemberLikeListService{
    @Autowired
    AppGoodsDao appGoodsDao;

    @Override
    public ArrayList<Like> likeList(HttpServletRequest request) {
        String bcmNum = request.getParameter("bcmNum");
        return appGoodsDao.likeList(bcmNum);
    }

    @Override
    public ArrayList<GoodsJoinLikes> UserGoodsJoinLikelist(HttpServletRequest request) {
        String bcmNum = request.getParameter("bcmNum");
        return appGoodsDao.UserGoodsJoinLikelist(bcmNum);
    }
}
