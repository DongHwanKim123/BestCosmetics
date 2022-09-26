package com.study.springboot.goods.dao;

import com.study.springboot.goods.dto.QuestionDto;
import org.apache.ibatis.annotations.Mapper;

import java.sql.Timestamp;
import java.util.ArrayList;

@Mapper
public interface QuestionDao {
	public int uploadQnA(int bcg_key, String bcg_name, int bcm_num, String bcm_name, String bcq_content, String bcq_secret);
    ArrayList<QuestionDto> questionListView(int bcg_key, int nEnd, int nStart);
    public int questionListViewArticlePage(int bcg_key);
    ArrayList<QuestionDto> questionListAdminView(int nStart, int nEnd);
    public int selectCountQuestion();
    public int answer(String BCG_KEY, String BCM_NUM, String BCQ_CONTENT, Timestamp BCQ_DATE, String BCA_CONTENT);
}
