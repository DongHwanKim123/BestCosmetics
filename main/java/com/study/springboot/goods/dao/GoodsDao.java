package com.study.springboot.goods.dao;

import java.util.ArrayList;

import com.study.springboot.goods.dto.GoodsJoinLikes;
import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.goods.dto.GoodsDto;
import com.study.springboot.goods.dto.LPageInfo;

@Mapper
public interface GoodsDao
{	//상품등록
	public int upload(String BCG_IMG, String BCG_IMGDETAIL, String BCG_CATEGORY, String BCG_NAME, int BCG_PRICE, String BCG_INFO);
	public int uploadDetail(int BCG_KEY, int BCD_DETAILKEY, String BCD_OPTION, int BCD_STOCK);
    //상품삭제
	public int delete(int BCG_KEY);
	//상품수정
	public int modify(int BCG_KEY, int BCG_PRICE, String BCG_INFO, int BCG_DISCOUNT, int BCG_MDPICK);
	//상품 옵션추가 select
	GoodsDto opSelect(int BCG_KEY);
	//메인에서 보여주는 리스트
	ArrayList<GoodsDto> list(int start, int end);
	ArrayList<GoodsDto> mdList(int start, int end);
	ArrayList<GoodsDto> bestList(int start, int end);
	ArrayList<GoodsDto> newList(int start, int end);
	//전체카테고리 : 찜 포함
	ArrayList<GoodsJoinLikes> listSessionX(int end, int start);
	ArrayList<GoodsJoinLikes> listSessionO(int bcm_num, int end, int start);
	LPageInfo articlePage(int curPage);
	public int selectCount();
	//관리자 검색
	ArrayList<GoodsDto> searchList(int start, int end, String type, String srchText);
	//검색
	ArrayList<GoodsJoinLikes> searchListSessionX(int end, int start, String type, String srchText);
	ArrayList<GoodsJoinLikes> searchListSessionO(int bcm_num, int end, int start, String type, String srchText);
	LPageInfo articlePageSearch(int curPage, String type, String srchText);
	public int selectCountSearch(String type, String srchText);
	//카테고리 검색 - 포인트
	ArrayList<GoodsJoinLikes> searchCListSessionX(int end, int start, String type, String srchText);
	ArrayList<GoodsJoinLikes> searchCListSessionO(int bcm_num, int end, int start, String type, String srchText);
	LPageInfo articlePageSearchC(int curPage, String type, String srchText);
	public int selectCountSearchC(String type, String srchText);
	//포인트 리스트
	public ArrayList<GoodsJoinLikes> sessionPointList(int bcm_num,int end, int start);
	public ArrayList<GoodsJoinLikes> seessionXPointList(int end, int start);
	LPageInfo articlePagePoint(int curPage);
	public int selectCountPoint();
	//포인트리스트 찜(찜테이블추가)
	public int likeTableUpdate(int bcm_num, int bcg_key);
	//포인트리스트 찜(굿즈테이블업데이트)
	public int goodsTableUpdate(int bcg_key);
	//포인트리스트 찜(갯수 가져오기)
	public int likeCount(int bcm_num, int bcg_key);
	// mdpick 중복체크
	public GoodsDto mdPickCheck(String bcg_mdpick);
}
