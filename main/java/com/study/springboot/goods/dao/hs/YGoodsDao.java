package com.study.springboot.goods.dao.hs;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.QuestionDto;

@Mapper
public interface YGoodsDao {
	public ArrayList<GoodsDto> goodsMDListView();
	public ArrayList<GoodsDto> goodsBestListView();
	public ArrayList<GoodsDto> goodsNewListView();
	public ArrayList<QuestionDto> goodsQuestionView(String bcgKey); 
	public void question(String bcg_key, String bcg_name, String bcm_num, String bcm_name, String bcq_content, String bcq_secret);
}
