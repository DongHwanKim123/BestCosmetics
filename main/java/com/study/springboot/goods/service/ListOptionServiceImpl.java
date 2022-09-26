package com.study.springboot.goods.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDetailDao;
import com.study.springboot.goods.dto.GoodsDetailDto;

@Service
public class ListOptionServiceImpl implements ListOptionService{
   
	@Autowired
	GoodsDetailDao goodsDetailDao;
   
	@Override
	public void optionList(HttpServletRequest request, Model model, int BCG_KEY) {
		ArrayList<GoodsDetailDto> dtos =
			goodsDetailDao.optionList(BCG_KEY);
		model.addAttribute("list", dtos);
	}
   
	@Override
	public int stockUpdate(HttpServletRequest request, Model model) {
		String[] bcd_stock = request.getParameterValues("count");
		String[] bcd_detailkey = request.getParameterValues("BCD_DETAILKEY");
		String[] bcg_key = request.getParameterValues("BCG_KEY");
      
		int totalCount = 0;
      
		int insertCount = -1;
		for(int i=0; i<bcg_key.length; i++){
			totalCount += Integer.parseInt(bcd_stock[i]);
			insertCount = goodsDetailDao.stockUpdate(bcd_stock[i], bcd_detailkey[i], bcg_key[i]);
		}
		goodsDetailDao.ModifyStock(totalCount, bcg_key[0]);
		return insertCount;  
	}   
   
	@Override
	public int optionDelete(HttpServletRequest request, Model model) {
		String[] bcd_detailkey = request.getParameterValues("BCD_DETAILKEY");
		String[] bcg_key = request.getParameterValues("BCG_KEY");
		String[] bcd_stock = request.getParameterValues("BCD_STOCK");
      
		int totalCount = 0;
		int insertCount = -1;
		for(int i=0; i<bcd_detailkey.length; i++){
			totalCount += Integer.parseInt(bcd_stock[i]);
			insertCount = goodsDetailDao.deleteOption(bcd_detailkey[i], bcg_key[i]);
		} 
		goodsDetailDao.ModifyStockDelete(totalCount, bcg_key[0]);
		return insertCount;  
	}
}