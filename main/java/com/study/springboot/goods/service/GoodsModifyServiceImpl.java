package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dto.GoodsDto;

@Service
public class GoodsModifyServiceImpl implements GoodsModifyService{
	
	@Autowired
	GoodsDao goodsDao;
	
	public GoodsDto mdPickCheck(HttpServletRequest request, Model model) {
		String bcg_mdpick = request.getParameter("BCG_MDPICK");
		GoodsDto goodsDto = goodsDao.mdPickCheck(bcg_mdpick);
        model.addAttribute("mdPick",goodsDto);
        return goodsDto;
	}
}
