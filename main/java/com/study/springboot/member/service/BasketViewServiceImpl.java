package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.GoodsJoinBasketJoinGoodDetailDto;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;


@Service
public class BasketViewServiceImpl implements BasketViewService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketView(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        ArrayList<GoodsJoinBasketJoinGoodDetailDto> dtos = memberDao.basketListView(bcm_num);
        model.addAttribute("list",dtos);
        return dtos;
    }
}
