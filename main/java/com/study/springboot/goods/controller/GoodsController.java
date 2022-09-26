package com.study.springboot.goods.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.Base64.Decoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.springboot.goods.dao.GoodsDao;
import com.study.springboot.goods.dao.InBagDao;
import com.study.springboot.goods.dao.QuestionDao;
import com.study.springboot.goods.dao.ReviewDao;
import com.study.springboot.goods.dto.GoodsDetailDto;
import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.service.DeleteService;
import com.study.springboot.goods.service.DetailAddService;
import com.study.springboot.goods.service.GLikeService;
import com.study.springboot.goods.service.GoodsModifyService;
import com.study.springboot.goods.service.ListOptionService;
import com.study.springboot.goods.service.ListService;
import com.study.springboot.goods.service.PageDetailService;
import com.study.springboot.goods.service.QuestionListAdminViewService;
import com.study.springboot.goods.service.QuestionListViewService;
import com.study.springboot.goods.service.ReviewListViewService;
import com.study.springboot.member.service.BasketService;

@Controller
public class GoodsController
{
	
	@Autowired
	private GoodsDao goodsDao;
	@Autowired
	private InBagDao inBagDao;
	@Autowired
	private ReviewDao reviewDao;
	@Autowired
	private QuestionDao questionDao;
	@Autowired
	ListService listService;
	@Autowired
	DetailAddService detailAddService;
	@Autowired
	DeleteService deleteService;
	@Autowired
	ListOptionService listOptionService;
	@Autowired
	GLikeService likeService;
	@Autowired
	PageDetailService pageDetailService;
	@Autowired
	QuestionListViewService questionListViewService;
	@Autowired
	ReviewListViewService reviewListViewService;
	@Autowired
	BasketService basketService;
	@Autowired
	QuestionListAdminViewService questionListAdminViewService;
	@Autowired
	GoodsModifyService goodsModifyService;

	int BCG_KEY = 0;
	String BCG_NAME = "";
	String BCG_IMG = "";
	String BCG_CATEGORY = "";
	int BCG_PRICE = 0;
	String BCG_INFO = "";
	int BCG_DISCOUNT = 0;
	int BCG_MDPICK = 0;
	String type = "";
	String srchText = "";
	
	//관리자 : 신규상품 등록 뷰
	@RequestMapping("/admin/goodsAdd")
	public String goodsAdd() {
		return "admin/goodsAdd";	
	}
	
	//관리자 : 신규상품 등록
	@RequestMapping("/admin/upload")
	public String upload(HttpServletRequest request, Model model) throws IOException {
		goodsDao.upload(request.getParameter("BCG_IMG"), 
				        request.getParameter("BCG_IMGDETAIL"),
				        request.getParameter("BCG_NAME"),
				        request.getParameter("BCG_CATEGORY"),
				        Integer.parseInt(request.getParameter("BCG_PRICE")),
				        request.getParameter("BCG_INFO"));	
		BCG_NAME = request.getParameter("BCG_NAME");
		return "admin/goodsAddDetail";
	}
	
	//관리자 : 신규상품 옵션등록 뷰
	@RequestMapping("/admin/goodsAddDetail")
	public String goodsAddDetail(HttpServletRequest request, Model model) {		
		model.addAttribute("BCG_NAME", BCG_NAME);
		listOptionService.optionList(request, model, BCG_KEY);
		return "admin/goodsAddDetail";	
	}
	
	//관리자 : 신규상품 옵션등록
	@RequestMapping("/admin/uploadDetail")   
    public @ResponseBody JSONObject uploadDetail(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = detailAddService.insertDetail(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	//관리자 : 상세품번 중복체크
	@RequestMapping("/admin/detailKeyCheck")
	public @ResponseBody JSONObject detailkeyCheck(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		GoodsDetailDto goodsDetailDto = detailAddService.detailKeyCheck(request, model);
		obj.put("detailKey", goodsDetailDto);
		System.out.println("obj : " + obj);
		return obj;
	}
	
	//관리자 : 기존상품 옵션추가
	@RequestMapping("/admin/opSelect")
	public String opSelect(HttpServletRequest request, Model model){
		BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		GoodsDto dto = new GoodsDto();
		dto = goodsDao.opSelect(BCG_KEY); 		
		BCG_NAME = dto.getBcg_name();	
		BCG_IMG = dto.getBcg_img();	
		BCG_CATEGORY = dto.getBcg_category();	
		BCG_PRICE = dto.getBcg_price();	
		BCG_INFO = dto.getBcg_info();	
		BCG_MDPICK = dto.getBcg_mdpick();	
		BCG_DISCOUNT = dto.getBcg_discount();	
		return "admin/goodsAddDetail";	
    }
	
	//관리자 : 상품 리스트 뷰
	@RequestMapping("/admin/goodsList")
	public String goodsList(HttpServletRequest request, Model model) {
		listService.list(request, model);
        return "admin/goodsList"; 
	}
	
	//관리자 : 상품 옵션 리스트 뷰
	@RequestMapping("/admin/optionList") 
	public String optionList(HttpServletRequest request, Model model) {
		listOptionService.optionList(request, model, BCG_KEY);
	      return "admin/goodsStockManager"; 
	}
	
	//관리자 : 상품 수정 뷰
	@RequestMapping("/admin/goodsModify")
	public String goodsModify(HttpServletRequest request, Model model) {
		model.addAttribute("BCG_KEY", BCG_KEY);
		model.addAttribute("BCG_IMG", BCG_IMG);
		model.addAttribute("BCG_NAME", BCG_NAME);
		model.addAttribute("BCG_CATEGORY", BCG_CATEGORY);
		model.addAttribute("BCG_PRICE", BCG_PRICE);
		model.addAttribute("BCG_INFO", BCG_INFO);
		model.addAttribute("BCG_DISCOUNT", BCG_DISCOUNT);
		model.addAttribute("BCG_MDPICK", BCG_MDPICK);
		return "admin/goodsModify";	
	}
	
	//관리자 : 상품 수정
	@RequestMapping("/admin/modify")
	public String modify(HttpServletRequest request, Model model) throws IOException {
		goodsDao.modify(Integer.parseInt(request.getParameter("BCG_KEY")), 
		        		Integer.parseInt(request.getParameter("BCG_PRICE")),
				        request.getParameter("BCG_INFO"),
				        Integer.parseInt(request.getParameter("BCG_DISCOUNT")),
		        		Integer.parseInt(request.getParameter("BCG_MDPICK")));
		return "admin/goodsList";
	}		
	
	//관리자 : MdPick 중복체크
	@RequestMapping("/admin/mdPickCheck")
	public @ResponseBody JSONObject mdPickCheck(HttpServletRequest request, Model model) {
		JSONObject obj = new JSONObject();
		GoodsDto goodsDto = goodsModifyService.mdPickCheck(request, model);
		obj.put("mdPick", goodsDto);
		System.out.println("obj : " + obj);
		return obj;
	}
	
	//관리자 : 상품 삭제
	@RequestMapping("/admin/delete")
    public @ResponseBody JSONObject delete(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = deleteService.delete(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	//관리자 : 상품옵션 일괄삭제 (상품 삭제시 실행됨)
	@RequestMapping("/admin/deleteDetail")
    public @ResponseBody JSONObject deleteDetail(HttpServletRequest request, Model model){
        JSONObject obj = new JSONObject();
        int insertCount = deleteService.deleteDetail(request, model);
        obj.put("desc", insertCount);
        return obj;
    }
	
	//관리자 : 상품옵션 일부 선택해 삭제 시 보이는 뷰
	@RequestMapping("/admin/opDelete")
	public String opDelete(HttpServletRequest request, Model model) {
		BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		listOptionService.optionList(request, model, BCG_KEY);
		model.addAttribute("BCG_KEY", BCG_KEY);
		return "admin/goodsOptionDelete"; 
	}
	
	//관리자 : 상품옵션 일부 삭제
	@RequestMapping("/admin/optionDelete")
	public @ResponseBody JSONObject stockDelete(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		int insertCount = listOptionService.optionDelete(request, model);
		obj.put("desc", insertCount);
		return obj;
	}
	
	//관리자 : 재고수정(검색)
	@RequestMapping("/admin/stockManager")
	public String stockManager(HttpServletRequest request, Model model) {
		if(request.getParameter("BCG_KEY") != null) {
			BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		}
		return "admin/goodsStockManager"; 
	}	      
	
	//관리자 : 재고수정
	@RequestMapping("/admin/stockUpdate")
	public @ResponseBody JSONObject stockUpdate(HttpServletRequest request, Model model){
		JSONObject obj = new JSONObject();
		int insertCount = listOptionService.stockUpdate(request, model);
		obj.put("desc", insertCount);
		return obj;
	}

	//관리자 : 상품검색
	@RequestMapping("/admin/adminSearch")
	public @ResponseBody String adminSearch(HttpServletRequest request, Model model) {    
		type = request.getParameter("type");
		srchText = request.getParameter("srchText");
		return ""; 
	}
	
	//관리자 : 상품검색결과
	@RequestMapping("/admin/searchRs") 
	public String searchRs(HttpServletRequest request, Model model) {    
		listService.searchList(request, model, type, srchText);
		return "admin/goodsList"; 
	}
	
	//게스트 : 전체 상품검색
	@RequestMapping("/guest/guestSearch")
	public @ResponseBody String guestSearch(HttpServletRequest request, Model model) {  
		type = request.getParameter("type");
		srchText = request.getParameter("srchText");
		return ""; 
	}
	
	//게스트 : 전체 상품검색결과
	@RequestMapping("/guest/searchARs") 
	public String searchARs(HttpServletRequest request, Model model) {    
		listService.searchList2(request, model, type, srchText);
		return "guest/goods/categoryAll"; 
	}
	
	//게스트 : 포인트카테고리 상품검색
	@RequestMapping("/guest/categorySearch")
	public String categorySearch(HttpServletRequest request, Model model) {    
		type = request.getParameter("type");
		srchText = request.getParameter("srchText2");
		return "guest/goods/categoryPoint"; 
	}
		
	//게스트 : 포인트카테고리 상품검색결과
	@RequestMapping("/guest/searchCRs") 
	public String searchCRs(HttpServletRequest request, Model model) {    
		listService.searchCList2(request, model, type, srchText);
		return "guest/goods/categoryPoint"; 
	}
	
	//메인화면
	@RequestMapping("/")
	public String mainHome(HttpServletRequest request, Model model) {
		listService.mdList(request, model);
		listService.bestList(request, model);
		listService.newList(request, model);
        return "guest/goods/mainHome"; 
	}
	
	//카테고리 - 전체보기
	@RequestMapping("/guest/categoryAll")
	public String list(HttpServletRequest request, Model model) {
		listService.allList(request, model);
        return "guest/goods/categoryAll"; 
	}
	
	//카테고리 - 포인트
	@RequestMapping("/guest/categoryPoint")   //포인트메이크업 카테고리
	public String pointList(HttpServletRequest request, Model model) {
        listService.pointList(request,model);
		return "guest/goods/categoryPoint";
	}
	
	//카테고리 & 상세페이지 - 찜
	@RequestMapping("/member/glike")
	public @ResponseBody int like(HttpServletRequest request, Model model) {
		return likeService.likeTableUpdate(request, model);
	}
	
	//상세페이지 뷰
	@RequestMapping("/guest/detailPage")   
	public String detailPage(HttpServletRequest request, Model model) {
		BCG_KEY = Integer.parseInt(request.getParameter("BCG_KEY"));
		HttpSession session = request.getSession();
		int BCM_NUM = 0;
		if (session.getAttribute("num")!=null) { BCM_NUM = (int)session.getAttribute("num"); }		
		pageDetailService.getGoodsInfo(request, model);
		questionListViewService.questionListView(request,model);
		reviewListViewService.reviewListView(request,model);
		int Count = goodsDao.likeCount(BCM_NUM, BCG_KEY);
		model.addAttribute("like", Count);
        return "guest/goods/detailPage"; 
	}
	
	//상세페이지 : 장바구니 추가
	@RequestMapping("/member/addBag")
	public String addBag(HttpServletRequest request, Model model) throws IOException {
		inBagDao.addBag(Integer.parseInt(request.getParameter("BCM_NUM")), 
						Integer.parseInt(request.getParameter("BCG_KEY")),
						Integer.parseInt(request.getParameter("BCD_DETAILKEY")),
						Integer.parseInt(request.getParameter("BCB_COUNT")));				
		return "guest/goods/detailPage";
	}
	
	//리뷰 작성 뷰
	@RequestMapping("/member/reviewWrite")
    public String reviewWrite(HttpServletRequest request, Model model,
        @RequestParam("bco_ordernum") String ordernum,
        @RequestParam("bcg_img") String img,
        @RequestParam("bcg_name") String name,
        @RequestParam("bcg_key") String key) throws IOException {
		Decoder decoder = Base64.getDecoder();
		byte[] _img = decoder.decode(img);
		byte[] _name = decoder.decode(name);
		String bcg_img = new String(_img);
		String urlname = new String(_name);
		String bcg_name = URLDecoder.decode(urlname);
		model.addAttribute("BCO_ORDERNUM", ordernum);
		model.addAttribute("BCG_KEY", key);
		model.addAttribute("BCG_IMG", bcg_img);
		model.addAttribute("BCG_NAME", bcg_name);
		return "/member/reviewWrite";
	}
	
	//리뷰 작성
	@RequestMapping("/member/upReview")
	public String upReview(HttpServletRequest request, Model model) throws IOException {
		String BCR_SCORE = request.getParameter("BCR_SCORE");
		if(BCR_SCORE==null) { BCR_SCORE = "0"; }
		reviewDao.upReview(Integer.parseInt(request.getParameter("BCG_KEY")),
							request.getParameter("BCG_NAME"), 
							Integer.parseInt(request.getParameter("BCM_NUM")),
							request.getParameter("BCM_NAME"),
							request.getParameter("BCR_PHOTO"),
							Integer.parseInt(BCR_SCORE),
							request.getParameter("BCR_CONTENT"));
		System.out.println("dddddddddddddddddddd : " + request.getParameter("BCO_ORDERNUM"));
		reviewDao.rvOnetime(request.getParameter("BCO_ORDERNUM"), 
							Integer.parseInt(request.getParameter("BCG_KEY")));
		return "guest/goods/detailPage";
	}
	
	//문의 작성
	@RequestMapping("/member/uploadQnA")
	public @ResponseBody String uploadQnA(HttpServletRequest request, Model model) throws IOException {
		String BCQ_SECRET = request.getParameter("BCQ_SECRET");
		if(request.getParameter("BCQ_SECRET")==null) { BCQ_SECRET = "off"; }
		questionDao.uploadQnA(Integer.parseInt(request.getParameter("BCG_KEY")),
							  request.getParameter("BCG_NAME"), 
						 	  Integer.parseInt(request.getParameter("BCM_NUM")),
							  request.getParameter("BCM_NAME"),
							  request.getParameter("BCQ_CONTENT"),
							  BCQ_SECRET);
		return "guest/goods/detailPage";
	}
	
	//관리자 : 문의 리스트 뷰
	@RequestMapping("/admin/goodsQuestionList")
	public String questionList(HttpServletRequest request, Model model) {
		questionListAdminViewService.questionListView(request, model);
        return "admin/goodsQuestionList"; 
	}
	
	//관리자 : 답변창 뷰
	@RequestMapping("/admin/answer")
	public String questionAnswer(HttpServletRequest request, Model model) {
		model.addAttribute("BCG_KEY", request.getParameter("BCG_KEY"));
		model.addAttribute("BCM_NUM", request.getParameter("BCM_NUM"));
		model.addAttribute("BCQ_CONTENT", request.getParameter("BCQ_CONTENT"));
		model.addAttribute("BCQ_DATE", request.getParameter("BCQ_DATE"));
        return "admin/answer"; 
	}
	
	//관리자 : 답변창
	@RequestMapping("/admin/answerSuccess")
	public String answerSuccess(HttpServletRequest request, Model model) {
		System.out.println("sdsdsdsdsdsd" + request.getParameter("BCQ_DATE"));
		Timestamp BCQ_DATE = Timestamp.valueOf(request.getParameter("BCQ_DATE"));
		questionDao.answer(request.getParameter("BCG_KEY"), 
							request.getParameter("BCM_NUM"),
							request.getParameter("BCQ_CONTENT"),
							BCQ_DATE,
							request.getParameter("BCA_CONTENT"));
        return "admin/goodsQuestionList"; 
	}
	
	//상단, 좌측 메뉴 조각들**********************************************************************************************
	@RequestMapping("/guest/menuLeft")        //좌측 메뉴
	public String menuLeft(HttpServletRequest request, Model model) {
	    return "guest/goods/menuLeft"; 
    }
	
	@RequestMapping("/guest/menuTop")         //상단 메뉴
	public String menuTop(HttpServletRequest request, Model model) {
		basketService.basketCount(request,model);
	    return "guest/goods/menuTop"; 
    }
}
