package com.study.springboot.goods.service;

import com.study.springboot.goods.dao.QuestionDao;
import com.study.springboot.goods.dto.LPageInfo;
import com.study.springboot.goods.dto.QuestionDto;

import org.eclipse.jdt.internal.compiler.ast.ReturnStatement;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.sql.Timestamp;
import java.util.List;

@Service
public class QuestionListAdminViewServiceImpl implements QuestionListAdminViewService{
    @Autowired
    QuestionDao questionDao;
    
    int listCount = 16;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 5;		// 하단에 보여줄 페이지 리스트의 갯수
	
    @Override
    public void questionListView(HttpServletRequest request, Model model) {
        
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

		List<QuestionDto> dtos = questionDao.questionListAdminView(nStart, nEnd);
		model.addAttribute("list", dtos);
    }
    
    public LPageInfo articlePage(int curPage) {

		// 총 게시물의 갯수
		int totalCount = questionDao.selectCountQuestion();

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
    
    @Override
    public int AdminAnswer(HttpServletRequest request, Model model) {
    	String bcg_key = request.getParameter("BCG_KEY");
    	String bcm_num = request.getParameter("BCM_NUM");
    	String bcq_content = request.getParameter("BCQ_CONTENT");
    	Timestamp bcq_date = Timestamp.valueOf(request.getParameter("BCQ_DATE"));
    	String bca_content = request.getParameter("BCA_CONTENT");
    	
    	int count = -1;
    	count = questionDao.answer(bcg_key, bcm_num, bcq_content, bcq_date, bca_content);
    	
    	return count;
    }  
}
