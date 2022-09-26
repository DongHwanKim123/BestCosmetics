package com.study.springboot.member.dto;

import lombok.Data;

@Data
public class PageInfo {
    int totalCount; 	//총 게시물의 갯수
    int listCount;		// 한 페이지당 보여줄 게시물의 갯수
    int totalPage; 		//총 페이지
    int curPage;		//현재 페이지
    int pageCount;		//하단에 보여줄 페이지 리스트의 갯수
    int startPage;		//시작 페이지
    int endPage; 		// 끝 페이지
    String searchType;  // 검색 종류
    String searchWord;	// 검색어
}
