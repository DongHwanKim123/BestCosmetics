package com.study.springboot.goods.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.GoodsJoinLikes;
import com.study.springboot.goods.dto.LPageInfo;
import com.study.springboot.member.dto.PageInfo;

@Service
public class ListServiceImpl implements ListService {

	@Autowired
	GoodsDao goodsDao;

	int listCount = 16;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
	@Override
	public void list(HttpServletRequest request, Model model) {

		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		LPageInfo pinfo = articlePage(nPage);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<GoodsDto> dtos = goodsDao.list(nStart, nEnd);
		model.addAttribute("list", dtos);
	}
	
	@Override
	public void mdList(HttpServletRequest request, Model model) {

		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		LPageInfo pinfo = articlePage(nPage);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<GoodsDto> dtos = goodsDao.mdList(nStart, nEnd);
		model.addAttribute("mdlist", dtos);
	}

	@Override
	public void bestList(HttpServletRequest request, Model model) {

		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		LPageInfo pinfo = articlePage(nPage);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<GoodsDto> dtos = goodsDao.bestList(nStart, nEnd);
		model.addAttribute("blist", dtos);
	}

	@Override
	public void newList(HttpServletRequest request, Model model) {

		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		LPageInfo pinfo = articlePage(nPage);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<GoodsDto> dtos = goodsDao.newList(nStart, nEnd);
		model.addAttribute("nlist", dtos);
	}

	@Override
	public void allList(HttpServletRequest request, Model model) {
		HttpSession session = null;
		int nPage= 1;
		int bcm_num = 0;
		session = request.getSession();

		try {
			bcm_num = (int) session.getAttribute("num");
		} catch (Exception e) {
		}
		
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}

		LPageInfo pinfo = articlePage(nPage);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		if(bcm_num == 0) {
			ArrayList<GoodsJoinLikes> dtos = goodsDao.listSessionX(nEnd, nStart);
			model.addAttribute("list",dtos);
		} else { 
			ArrayList<GoodsJoinLikes> dtos = goodsDao.listSessionO(bcm_num, nEnd, nStart);
			model.addAttribute("list",dtos);
		}
	}

	public LPageInfo articlePage(int curPage) {

		// 총 게시물의 갯수
		int totalCount = goodsDao.selectCount();

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

		// 빈으로 처리 - 약한 결합
		LPageInfo pinfo = new LPageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		
		return pinfo;
	}

	//관리자검색
	@Override
	public void searchList(HttpServletRequest request, Model model, String type, String srchText) {

		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}
		
		LPageInfo pinfo = articlePageSearch(nPage, type, srchText);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
		
		HttpSession session = null;
		session = request.getSession();
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<GoodsDto> dtos = goodsDao.searchList(nStart, nEnd, type, srchText);
		model.addAttribute("list", dtos);
	}
	
	//전체검색
	@Override
	public void searchList2(HttpServletRequest request, Model model, String type, String srchText) {
		HttpSession session = null;
		int nPage= 1;
		int bcm_num = 0;
		session = request.getSession();

		try {
			bcm_num = (int) session.getAttribute("num");
		} catch (Exception e) {
		}
		
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}
		
		LPageInfo pinfo = articlePageSearch(nPage, type, srchText);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		if(bcm_num == 0) {
			ArrayList<GoodsJoinLikes> dtos = goodsDao.searchListSessionX(nStart, nEnd, type, srchText);
			model.addAttribute("list",dtos);
		} else { 
			ArrayList<GoodsJoinLikes> dtos = goodsDao.searchListSessionO(bcm_num, nStart, nEnd, type, srchText);
			model.addAttribute("list",dtos);
		}
	}

	public LPageInfo articlePageSearch(int curPage, String type, String srchText) {

		// 총 게시물의 갯수
		int totalCount = goodsDao.selectCountSearch(type, srchText);

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

		// 빈으로 처리 - 약한 결합
		LPageInfo pinfo = new LPageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		pinfo.setSearchText(srchText);
		pinfo.setType(type);
		
		return pinfo;
	}
	
	//카테고리검색 - 포인트
	@Override
	public void searchCList2(HttpServletRequest request, Model model, String type, String srchText) {
		HttpSession session = null;
		int nPage= 1;
		int bcm_num = 0;
		session = request.getSession();

		try {
			bcm_num = (int) session.getAttribute("num");
		} catch (Exception e) {
		}
		
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {
		}
		
		LPageInfo pinfo = articlePageSearchC(nPage, type, srchText);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		
		session.setAttribute("cpage", nPage);
		
	   	model.addAttribute("cpage", nPage);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		if(bcm_num == 0) {
			ArrayList<GoodsJoinLikes> dtos = goodsDao.searchCListSessionX(nStart, nEnd, type, srchText);
			model.addAttribute("list",dtos);
		} else { 
			ArrayList<GoodsJoinLikes> dtos = goodsDao.searchCListSessionO(bcm_num, nStart, nEnd, type, srchText);
			model.addAttribute("list",dtos);
		}
	}

	public LPageInfo articlePageSearchC(int curPage, String type, String srchText) {

		// 총 게시물의 갯수
		int totalCount = goodsDao.selectCountSearchC(type, srchText);

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

		// 빈으로 처리 - 약한 결합
		LPageInfo pinfo = new LPageInfo();
		pinfo.setTotalCount(totalCount);
		pinfo.setListCount(listCount);
		pinfo.setTotalPage(totalPage);
		pinfo.setCurPage(myCurPage);
		pinfo.setPageCount(pageCount);
		pinfo.setStartPage(startPage);
		pinfo.setEndPage(endPage);
		pinfo.setSearchText(srchText);
		pinfo.setType(type);
		
		return pinfo;
	}
	
	//포인트 카테고리
	@Override
	public void pointList(HttpServletRequest request, Model model) {
		HttpSession session = null;
		int nPage= 1;
		int bcm_num = 0;
		session = request.getSession();

		try {
			bcm_num = (int) session.getAttribute("num");
		} catch (Exception e) { }
		
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) { }

		LPageInfo pinfo = articlePagePoint(nPage);

		model.addAttribute("page" , pinfo);

		nPage = pinfo.getCurPage();

		session.setAttribute("cpage", nPage);
		model.addAttribute("cpage", nPage);
		
		int nStart= (nPage-1)*listCount+1;
		int nEnd = (nPage-1)*listCount+listCount;
		
		if(bcm_num == 0) {
			ArrayList<GoodsJoinLikes> dtos = goodsDao.seessionXPointList(nEnd,nStart);
			model.addAttribute("list",dtos);
		}else {
			ArrayList<GoodsJoinLikes> dtos = goodsDao.sessionPointList(bcm_num,nEnd,nStart);
			model.addAttribute("list",dtos);
		}
	}
	
	public LPageInfo articlePagePoint(int curPage) {

		// 총 게시물의 갯수
		int totalCount = goodsDao.selectCountPoint();

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

		// 빈으로 처리 - 약한 결합
		LPageInfo pinfo = new LPageInfo();
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
