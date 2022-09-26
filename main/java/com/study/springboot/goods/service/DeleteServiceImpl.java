package com.study.springboot.goods.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dao.GoodsDetailDao;

@Service
public class DeleteServiceImpl implements DeleteService{
	@Autowired
	GoodsDao goodsDao;
	@Autowired
	GoodsDetailDao goodsDetailDao;
   
	@Override
	public int delete(HttpServletRequest request, Model model) {
		String[] bcg_keyS = request.getParameterValues("BCG_KEY");
		int[] bcg_key = null;         
		// 스트링 배열 인티저 배열로 변환
		if( bcg_keyS != null ){
			bcg_key = new int[ bcg_keyS.length ];
			for( int i=0; i<bcg_keyS.length; i++) {
				bcg_key[i] = Integer.parseInt( bcg_keyS[i] );
			}
		}

        int insertCount = -1;
        for(int i=0; i<bcg_key.length; i++){
            insertCount = goodsDao.delete(bcg_key[i]);
        } 
        return insertCount;  
	}
	
	@Override
	public int deleteDetail(HttpServletRequest request, Model model) {
		String[] bcg_keyS = request.getParameterValues("BCG_KEY");
		int[] bcg_key = null;         
		// 스트링 배열 인티저 배열로 변환
		if( bcg_keyS != null ){
			bcg_key = new int[ bcg_keyS.length ];
			for( int i=0; i<bcg_keyS.length; i++) {
				bcg_key[i] = Integer.parseInt( bcg_keyS[i] );
			}
		}

        int insertCount = -1;
        for(int i=0; i<bcg_key.length; i++){
            insertCount = goodsDetailDao.deleteDetail(bcg_key[i]);
        } 
        return insertCount;  
	}
}