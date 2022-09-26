package com.study.springboot.goods.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDetailDto;
import com.study.springboot.goods.dto.GoodsDto;

@Mapper
public interface GoodsDetailDao {	
	public int uploadDetail(String bcg_name, String bcd_detailkey,String bcd_option ,String bcd_stock);
    public int deleteDetail(int BCG_KEY);
    public int AddStock(int totalCount, String bcg_name);
    public ArrayList<GoodsDetailDto> optionList(int BCG_KEY);
    public ArrayList<GoodsDetailDto> optionListName(String BCG_NAME);
    public int stockUpdate(String BCD_STOCK, String BCD_DETAILKEY, String BCG_KEY);
    public int ModifyStock(int totalCount, String bcg_key);
    public int ModifyStockDelete(int totalCount, String bcg_key);
    public int deleteOption(String BCD_DETAILKEY, String BCG_KEY);
    public GoodsDetailDto detailKeyCheck(String bcg_name, String bcd_detailKey);
}