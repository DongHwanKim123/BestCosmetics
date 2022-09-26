package com.study.springboot.goods.service.hs;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.goods.dao.hs.YGoodsDao;
import com.study.springboot.goods.dto.QuestionDto;

@Service
public class AQuestionServiceImpl implements AQuestionService{
	
	@Autowired
	YGoodsDao yGoodsDao;
	
	@Override
    public ArrayList<QuestionDto> goodsQuestionView(HttpServletRequest request) {
		String bcgKey = request.getParameter("bcgKey");
        return yGoodsDao.goodsQuestionView(bcgKey);
    }
	
	@Override
    public void question(HttpServletRequest request) {
        String bcg_key = request.getParameter("bcg_key");
        String bcg_name = request.getParameter("bcg_name");
        String bcm_num = request.getParameter("bcm_num");
        String bcm_name = request.getParameter("bcm_name");
        String bcq_content = request.getParameter("bcq_content");
        String bcq_secret = request.getParameter("bcq_secret");
        
        yGoodsDao.question(bcg_key, bcg_name, bcm_num, bcm_name, bcq_content, bcq_secret);
	}
}
