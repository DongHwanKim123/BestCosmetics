package com.study.springboot.goods.service;

import com.study.springboot.goods.dao.QuestionDao;
import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.goods.dto.QuestionDto;
import com.study.springboot.member.dto.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Service
public class QuestionListViewServiceImpl implements QuestionListViewService{
    @Autowired
    QuestionDao questionDao;
    @Override
    public void questionListView(HttpServletRequest request, Model model) {
        int bcg_key = Integer.parseInt(request.getParameter("BCG_KEY"));
        int nPage= 1;

        try {
            String sPage = request.getParameter("questionPage");
            nPage = Integer.parseInt(sPage);
        }catch(Exception e) {
        }

        int totalCount = questionDao.questionListViewArticlePage(bcg_key);

        int listCount = 10; //한 페이지당 보여줄 게시물의 갯수
        int pageCount = 5; //하단에 보여줄 페이지 리스트의 갯수.

        //총 페이지 수
        int totalPage = totalCount / listCount;
        if (totalCount % listCount > 0)
            totalPage++;

        //현재 페이지
        // curPage = 현재 보고 있는 페이지
        int myCurPage = nPage;
        if (myCurPage > totalPage)
            myCurPage = totalPage;
        if (myCurPage < 1)
            myCurPage = 1;

        //시작 페이지
        int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;
        // +1 은 첫 페이지가 0이나 10이 아니라 1이나 11로 하기 위함임

        //끝페이지
        int endPage = startPage + pageCount - 1;
        if(endPage > totalPage)
            endPage = totalPage;
        // -1 은  첫 페이지가 0이나 10이 아니라 1이나 11로 하기 위함임

        PageInfo pinfo = new PageInfo();
        pinfo.setTotalCount(totalCount);
        pinfo.setListCount(listCount);
        pinfo.setTotalPage(totalPage);
        pinfo.setCurPage(myCurPage);
        pinfo.setPageCount(pageCount);
        pinfo.setStartPage(startPage);
        pinfo.setEndPage(endPage);

        System.out.println(pinfo.toString());
        
        //문의페이징
        model.addAttribute("questionPage" , pinfo);

        nPage = pinfo.getCurPage();

        HttpSession session = null;
        session = request.getSession();
        session.setAttribute("questionCpage", nPage);

        int nStart= (nPage-1)*listCount+1;
        int nEnd = (nPage-1)*listCount+listCount;

        ArrayList<QuestionDto> dtos = questionDao.questionListView(bcg_key,nEnd,nStart);
        //문의 리스트
        model.addAttribute("questionList",dtos);
    }
}
