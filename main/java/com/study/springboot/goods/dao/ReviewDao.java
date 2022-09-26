package com.study.springboot.goods.dao;

import com.study.springboot.goods.dto.ReviewDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;

@Mapper
public interface ReviewDao {
	public int upReview(int bcg_key, String bcg_name, int bcm_num, String bcm_name, 
			String bcr_photo, int bcr_score, String bcr_content);
	ArrayList<ReviewDto> reviewList(int bcg_key,int nEnd, int nStart);
    public int reviewListArticlePage(int bcg_key);
    public int rvOnetime(String bco_ordernum, int bcg_key);
}
