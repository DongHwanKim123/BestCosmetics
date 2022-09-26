package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;

@Service
public class GLikeServiceImpl implements GLikeService{

	@Autowired
	GoodsDao goodsDao;
	HttpSession session;
	
	@Override
	public int likeTableUpdate(HttpServletRequest request, Model model) {
		session = request.getSession();
		int bcm_num = (int) session.getAttribute("num");		
		int bcg_key = Integer.parseInt(request.getParameter("BCG_KEY"));
		
		int insertCount = goodsDao.likeTableUpdate(bcm_num, bcg_key);
		int updateCount = goodsDao.goodsTableUpdate(bcg_key);
		int likeCount = goodsDao.likeCount(bcm_num, bcg_key);
		model.addAttribute("like", likeCount);		
		return likeCount;
	}
}
