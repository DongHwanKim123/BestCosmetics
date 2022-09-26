package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dto.ReviewDto;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public interface AppReviewService {
    public void reviewWrite(HttpServletRequest request);
    public ArrayList<ReviewDto> reviewList(HttpServletRequest request);
}
