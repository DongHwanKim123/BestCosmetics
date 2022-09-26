package com.study.springboot.goods.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface InBagDao
{	
	//장바구니 담기
	public int addBag(int BCM_NUM, int BCG_KEY, int BCD_DETAILKEY, int BCB_COUNT);
}		
