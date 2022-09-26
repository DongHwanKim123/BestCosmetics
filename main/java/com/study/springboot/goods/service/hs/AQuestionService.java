package com.study.springboot.goods.service.hs;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.goods.dto.QuestionDto;


public interface AQuestionService {
	public ArrayList<QuestionDto> goodsQuestionView(HttpServletRequest request);
	public void question(HttpServletRequest request);
}
