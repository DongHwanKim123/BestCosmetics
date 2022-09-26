package com.study.springboot.goods.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dao.GoodsDetailDao;
import com.study.springboot.goods.dto.GoodsDetailDto;
import com.study.springboot.goods.dto.GoodsDto;

@Service
public class PageDetailServiceImpl implements PageDetailService {

	@Autowired
	GoodsDao goodsDao;
	@Autowired
	GoodsDetailDao goodsDetailDao;
	
	@Override
	public void getGoodsInfo(HttpServletRequest request, Model model) {

		int BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		
		//BC_GOODS
		GoodsDto dto = goodsDao.opSelect(BCG_KEY);
		model.addAttribute("BCG_KEY", BCG_KEY);
		model.addAttribute("BCG_IMG", dto.getBcg_img());
		model.addAttribute("BCG_IMGDETAIL", dto.getBcg_imgdetail());
		model.addAttribute("BCG_NAME", dto.getBcg_name());
		model.addAttribute("BCG_PRICE", dto.getBcg_price());
		model.addAttribute("BCG_CATEGORY", dto.getBcg_category());
		model.addAttribute("BCG_STOCK", dto.getBcg_stock());
		model.addAttribute("BCG_DATE", dto.getBcg_date());
		model.addAttribute("BCG_LIKE", dto.getBcg_like());
		model.addAttribute("BCG_SALE", dto.getBcg_sale());
		model.addAttribute("BCG_INFO", dto.getBcg_info());
		model.addAttribute("BCG_DISCOUNT", dto.getBcg_discount());
		model.addAttribute("BCG_MDPICK", dto.getBcg_mdpick());
		
		//BC_GOODSDETAIL
		ArrayList<GoodsDetailDto> ddtos = goodsDetailDao.optionList(BCG_KEY);
		model.addAttribute("list", ddtos);
	}
}
