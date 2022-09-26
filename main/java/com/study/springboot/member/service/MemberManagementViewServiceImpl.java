package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.MemberJoinOrderHistoryDto;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Service
public class MemberManagementViewServiceImpl implements MemberManagementViewService{
    @Autowired
    MemberDao memberDao;
    @Override
    public ArrayList<MemberJoinOrderHistoryDto> memberManagementView(HttpServletRequest request, Model model) {
        int nPage= 1;
        try {
            String sPage = request.getParameter("page");
            nPage = Integer.parseInt(sPage);
        }catch(Exception e) {
        }
        String searchType = request.getParameter("searchType");
        String searchWord = request.getParameter("searchWord");

        int totalCount=0;
        if(searchType == null){
            totalCount = memberDao.memberManagementArticlePage();
        }else if(searchType.equals("sName")){
            totalCount = memberDao.serchByNameMemberManagementArticlePage("%"+searchWord+"%");
        }else if(searchType.equals("sId")){
            totalCount = memberDao.serchByIdMemberManagementArticlePage("%"+searchWord+"%");
        }else if(searchType.equals("sNum")){
            totalCount = memberDao.serchByNumMemberManagementArticlePage(searchWord);
        }


        int listCount = 20; //한 페이지당 보여줄 게시물의 갯수
        int pageCount = 10; //하단에 보여줄 페이지 리스트의 갯수.

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
        pinfo.setSearchType(searchType);
        pinfo.setSearchWord(searchWord);

//        System.out.println(pinfo.toString());

        model.addAttribute("page" , pinfo);

        nPage = pinfo.getCurPage();

        HttpSession session = null;
        session = request.getSession();
        session.setAttribute("cpage", nPage);

        int nStart= (nPage-1)*listCount+1;
        int nEnd = (nPage-1)*listCount+listCount;


        if(searchType == null){
            ArrayList<MemberJoinOrderHistoryDto> dtos = memberDao.memberManagement(nEnd,nStart);
            model.addAttribute("list",dtos);
//            System.out.println(dtos);
            return dtos;
        }else if(searchType.equals("sName")){
            ArrayList<MemberJoinOrderHistoryDto> dtos = memberDao.serchByNameMemberManagement("%"+searchWord+"%",nEnd,nStart);
            model.addAttribute("list",dtos);
//            System.out.println(dtos);
            return dtos;
        }else if(searchType.equals("sId")){
            ArrayList<MemberJoinOrderHistoryDto> dtos = memberDao.serchByIdMemberManagement("%"+searchWord+"%",nEnd,nStart);
            model.addAttribute("list",dtos);
//            System.out.println(dtos);
            return dtos;
        }else if(searchType.equals("sNum")){
            ArrayList<MemberJoinOrderHistoryDto> dtos = memberDao.serchByNumMemberManagement(searchWord,nEnd,nStart);
            model.addAttribute("list",dtos);
//            System.out.println(dtos);
            return dtos;
        }

        return null;
    }

    @Override
    public void allMemberCount(Model model) {
        int totalCount = memberDao.memberManagementArticlePage();
        model.addAttribute("allMemberCount", totalCount);
    }
}
