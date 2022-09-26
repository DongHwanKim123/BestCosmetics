package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dao.GoodsDetailDao;
import com.study.springboot.goods.dto.GoodsDetailDto;

@Service
public class DetailAddServiceImpl implements DetailAddService{
	
	@Autowired
	GoodsDao goodsDao;
	@Autowired
	GoodsDetailDao goodsDetailDao;
	
	@Override
	public int insertDetail(HttpServletRequest request, Model model) {
		String[] bcg_name = request.getParameterValues("BCG_NAME");
		String[] bcd_detailkey = request.getParameterValues("BCD_DETAILKEY");
        String[] bcd_option = request.getParameterValues("BCD_OPTION");
        String[] bcd_stock = request.getParameterValues("BCD_STOCK");
        
        int totalCount = 0;

        int insertCount = -1;
        for(int i =0; i<bcd_detailkey.length; i++) {
            totalCount += Integer.parseInt(bcd_stock[i]);
             insertCount = goodsDetailDao.uploadDetail(bcg_name[i],
                                                       bcd_detailkey[i],
                                                       bcd_option[i],
                                                       bcd_stock[i]);            
        }
        goodsDetailDao.AddStock(totalCount, bcg_name[0]);
        return insertCount;      
    }
	
	@Override
	public GoodsDetailDto detailKeyCheck(HttpServletRequest request, Model model) {
		String bcg_name = request.getParameter("BCG_NAME");
		String bcd_detailKey = request.getParameter("BCD_DETAILKEY");
		GoodsDetailDto goodsDetailDto = goodsDetailDao.detailKeyCheck(bcg_name, bcd_detailKey);
        model.addAttribute("detailKey",goodsDetailDto);
        return goodsDetailDto;
	}
}