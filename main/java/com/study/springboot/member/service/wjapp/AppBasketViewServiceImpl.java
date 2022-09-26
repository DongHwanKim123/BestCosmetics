package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
@Service
public class AppBasketViewServiceImpl implements AppBasketViewService{
    @Autowired
    MemberDao memberDao;
    @Override
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketView(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        return memberDao.basketListView(bcm_num);
    }
}
