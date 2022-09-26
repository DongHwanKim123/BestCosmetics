package com.study.springboot.member.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.Like;
import com.study.springboot.member.dto.PageInfo;

@Service
public class LikeServiceImpl implements LikeService
{
	@Autowired
	KMemberDao dao;

	int listCount = 16;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
	@Override
	public void likeList(HttpServletRequest request, Model model)
	{
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}
		
		int bcm_num = (int) request.getSession().getAttribute("num");
//		System.out.println(bcm_num);
		PageInfo pinfo = articlePage(nPage, bcm_num);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<Like> dtos = dao.likeList(nStart, nEnd, bcm_num);
		model.addAttribute("likeList", dtos);
	}
	@Override
	public String likeDelete(HttpServletRequest request) {
		String bcm_num = request.getParameter("bcm_num");
		String bcg_key = request.getParameter("bcg_key");

		dao.likeDelete(Integer.parseInt(bcm_num), Integer.parseInt(bcg_key));
		return "success";
	}
	public PageInfo articlePage(int curPage, int bcm_num) {

		// 총 게시물의 갯수
		int totalCount = dao.likeCount(bcm_num);

		// 총 페이지 수
		int totalPage = totalCount / listCount;
		if (totalCount % listCount > 0)
		    totalPage++;
		
		// 현재 페이지
		int myCurPage = curPage;
		if (myCurPage > totalPage)
			myCurPage = totalPage;
		if (myCurPage < 1)
			myCurPage = 1;

		// 시작 페이지
		int startPage = ((myCurPage - 1) / pageCount) * pageCount + 1;

		// 끝 페이지
		int endPage = startPage + pageCount - 1;
		if (endPage > totalPage) 
		    endPage = totalPage;

		PageInfo pinfo = new PageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
	}
}