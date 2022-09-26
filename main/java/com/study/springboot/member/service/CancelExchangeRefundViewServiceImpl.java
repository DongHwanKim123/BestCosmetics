package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Service
public class CancelExchangeRefundViewServiceImpl implements CancelExchangeRefundViewService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public void cancelExchangeRefundView(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        System.out.println(bcm_num);
        int nPage= 1;
        try {
            String sPage = request.getParameter("page");
            nPage = Integer.parseInt(sPage);
        }catch(Exception e) {
        }

        int totalCount = memberDao.articlePage2(bcm_num);

        int listCount = 5; //한 페이지당 보여줄 게시물의 갯수
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

        model.addAttribute("page" , pinfo);

        nPage = pinfo.getCurPage();

        HttpSession session = null;
        session = request.getSession();
        session.setAttribute("cpage", nPage);

        int nStart= (nPage-1)*listCount+1;
        int nEnd = (nPage-1)*listCount+listCount;

        ArrayList<OrderDeliveryDto> dtos = memberDao.cancelExchangeRefund(bcm_num,nEnd,nStart);
        model.addAttribute("list",dtos);
//        System.out.println(dtos);
    }
}
