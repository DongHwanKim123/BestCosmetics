package com.study.springboot.goods.dto;

import lombok.Data;

@Data
public class LPageInfo {
	int totalCount;           
	int listCount;         
	int totalPage;          
	int curPage;              
	int pageCount;          
	int startPage;           
	int endPage;
	String searchText;
	String type;
}
