package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.member.dto.Like;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Array;
import java.util.ArrayList;

public interface MemberLikeListService {
    public ArrayList<Like> likeList(HttpServletRequest request);
    public ArrayList<GoodsJoinLikes> UserGoodsJoinLikelist(HttpServletRequest request);
}
