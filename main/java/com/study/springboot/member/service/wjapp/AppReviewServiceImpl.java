package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dao.ReviewDao;
import com.study.springboot.goods.dto.ReviewDto;
import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

@Service
public class AppReviewServiceImpl implements AppReviewService {
    @Autowired
    ReviewDao reviewDao;
    @Autowired
    AppGoodsDao appGoodsDao;
    @Override
    public void reviewWrite(HttpServletRequest request) {
        String bcmNum = request.getParameter("bcmNum");
        String bcmName = request.getParameter("bcmName");
        String bcgKey = request.getParameter("bcgKey");
        String bcgName = request.getParameter("bcgName");
        String bcrPhoto = request.getParameter("bcrPhoto");
        String bcrScore = request.getParameter("bcrScore");
        String bcrContent = request.getParameter("bcrContent");
        String orderNum = request.getParameter("orderNum");
        reviewDao.upReview(Integer.parseInt(bcgKey),bcgName,
                Integer.parseInt(bcmNum),bcmName,bcrPhoto,
                Integer.parseInt(bcrScore),bcrContent);
        reviewDao.rvOnetime(orderNum,Integer.parseInt(bcgKey));
    }

    @Override
    public ArrayList<ReviewDto> reviewList(HttpServletRequest request) {
        return appGoodsDao.reviewList(request.getParameter("bcgKey"));
    }
}
