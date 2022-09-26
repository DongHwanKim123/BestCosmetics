package com.study.springboot.member.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.member.dao.MemberDao;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.PageInfo;

@Service
public class OrderManagementImpl implements OrderManagement {

	@Autowired
	KMemberDao dao;
	@Autowired
	OrderDetailService orderDetail;
	@Autowired
	MemberDao memberDao;
	
	int listCount = 20;		// 한 페이지당 보여줄 게시물의 갯수
	int pageCount = 10;		// 하단에 보여줄 페이지 리스트의 갯수
	
	@Override
	public void deliveryReady(HttpServletRequest request, Model model) {
		String orderStatus = "배송준비중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}
		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
		model.addAttribute("cpage", nPage);
		
		String totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		
		model.addAttribute("deliveryReady",dto);
	}
	@Override
	public void inTransit(HttpServletRequest request, Model model) {
		String orderStatus = "배송중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	String totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("inTransit",dto);
	}
	@Override
	public void deliveryCompleted(HttpServletRequest request, Model model) {
		String orderStatus = "배송완료";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	String totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("deliveryCompleted",dto);
	}
	@Override
	public void purchaseConfirmation(HttpServletRequest request, Model model) {
		String orderStatus = "구매확정";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCount(orderStatus);
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	String totalPrice = dao.orderManagementTotalPrice(orderStatus);
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		

		List<OrderDeliveryDto> dto = dao.orderManagement(orderStatus, nEnd, nStart);
		model.addAttribute("purchaseConfirmation",dto);
	}
	@Override
	public void cancelExchangeRefundAdmin(HttpServletRequest request, Model model) {
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.orderManagementCERCount();
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	String totalPrice = dao.orderManagementCERTotalPrice();
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<OrderDeliveryDto> dto = dao.orderManagementCER(nEnd, nStart);
		model.addAttribute("cancelExchangeRefundAdmin",dto);
	}
	@Override
	public void orderListAdmin(HttpServletRequest request, Model model) {
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int count = dao.TotalOrderListCount();
		PageInfo pinfo = articlePage(nPage, count, null, null);
		model.addAttribute("page", pinfo);

		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	   	
	   	String totalPrice = dao.TotalOrderListTotalPrice();
		model.addAttribute("totalPrice", totalPrice);

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;

		List<OrderDeliveryDto> dto = dao.TotalOrderList(nEnd, nStart);
		model.addAttribute("orderListAdmin",dto);
	}
	
	
	
	@Override
	public void drSearch(HttpServletRequest request, Model model) {
		String orderStatus = "배송준비중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			String totalPrice = dao.nameOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.recipientOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			String totalPrice = dao.recipientOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryReady",dto);
			String totalPrice = dao.ordernumOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	@Override
	public void itSearch(HttpServletRequest request, Model model) {
		String orderStatus = "배송중";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("inTransit",dto);
			String totalPrice = dao.nameOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.recipientOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("inTransit",dto);
			String totalPrice = dao.recipientOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("inTransit",dto);
			String totalPrice = dao.ordernumOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
	}
	@Override
	public void dcSearch(HttpServletRequest request, Model model) {
		String orderStatus = "배송완료";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryCompleted",dto);
			String totalPrice = dao.nameOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.recipientOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryCompleted",dto);
			String totalPrice = dao.recipientOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("deliveryCompleted",dto);
			String totalPrice = dao.ordernumOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	@Override
	public void pcSearch(HttpServletRequest request, Model model) {
		String orderStatus = "구매확정";
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("purchaseConfirmation",dto);
			String totalPrice = dao.nameOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.recipientOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("purchaseConfirmation",dto);
			String totalPrice = dao.recipientOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCount(orderStatus, searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagement(orderStatus, nEnd, nStart, searchWord);
			model.addAttribute("purchaseConfirmation",dto);
			String totalPrice = dao.ordernumOrderManagementTotalPrice(orderStatus, searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	@Override
	public void cerSearch(HttpServletRequest request, Model model) {
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameOrderManagementCERCount(searchWord);
			List<OrderDeliveryDto> dto = dao.nameOrderManagementCER(searchWord, nEnd, nStart);
			model.addAttribute("cancelExchangeRefundAdmin",dto);
			String totalPrice = dao.nameOrderManagementCERTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_order_status")) {
			count = dao.orderStatusOrderManagementCERCount(searchWord);
			List<OrderDeliveryDto> dto = dao.orderStatusOrderManagementCER(searchWord, nEnd, nStart);
			model.addAttribute("cancelExchangeRefundAdmin",dto);
			String totalPrice = dao.orderStatusOrderManagementCERTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumOrderManagementCERCount(searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumOrderManagementCER(searchWord, nEnd, nStart);
			model.addAttribute("cancelExchangeRefundAdmin",dto);
			String totalPrice = dao.ordernumOrderManagementCERTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	@Override
	public void olSearch(HttpServletRequest request, Model model) {
		int nPage = 1;
		try {
			String sPage = request.getParameter("page");
			nPage = Integer.parseInt(sPage);
		} catch (Exception e) {}

		int nStart = (nPage - 1) * listCount + 1;
		int nEnd = (nPage - 1) * listCount + listCount;
		
		String searchType = request.getParameter("searchType");
		String word  = request.getParameter("searchWord");
		String searchWord = "%"+word+"%";
		
		int count = 0;
		if(searchType.equals("bcm_name")) {
			count = dao.nameTotalOrderListCount(searchWord);
			List<OrderDeliveryDto> dto = dao.nameTotalOrderList(nEnd, nStart, searchWord);
			model.addAttribute("orderListAdmin",dto);
			String totalPrice = dao.nameTotalOrderListTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_order_status")) {
			count = dao.orderStatusTotalOrderListCount(searchWord);
			List<OrderDeliveryDto> dto = dao.orderStatusTotalOrderList(nEnd, nStart, searchWord);
			model.addAttribute("orderListAdmin",dto);
			String totalPrice = dao.orderStatusTotalOrderListTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_ordernum")) {
			count = dao.ordernumTotalOrderListCount(searchWord);
			List<OrderDeliveryDto> dto = dao.ordernumTotalOrderList(nEnd, nStart, searchWord);
			model.addAttribute("orderListAdmin",dto);
			String totalPrice = dao.ordernumTotalOrderListTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		else if(searchType.equals("bco_recipient")) {
			count = dao.recipientTotalOrderListCount(searchWord);
			List<OrderDeliveryDto> dto = dao.recipientTotalOrderList(nEnd, nStart, searchWord);
			model.addAttribute("orderListAdmin",dto);
			String totalPrice = dao.recipientTotalOrderListTotalPrice(searchWord);
			model.addAttribute("totalPrice", totalPrice);
		}
		PageInfo pinfo = articlePage(nPage, count, searchType, searchWord);
		model.addAttribute("page", pinfo);
		nPage = pinfo.getCurPage();
	   	model.addAttribute("cpage", nPage);
		
	}
	
	
	
	
	@Override
	public String stateDeliveryCompleted(HttpServletRequest request, Model model) {
		String result = "";
		int updateCount = 0;
		String[] bco_ordernumList = request.getParameterValues("bco_ordernum");
		for(int i=0; i<bco_ordernumList.length; i++) {
			updateCount += dao.stateDeliveryCompletedChange(bco_ordernumList[i]);

		}
		if(updateCount == bco_ordernumList.length) {
			result = "success";
		}


		return result;
	}
	@Override
	public String stateInTransit(HttpServletRequest request, Model model) {
		String result = "";
		int updateCount = 0;
		String[] bco_ordernumList = request.getParameterValues("bco_ordernum");
		ArrayList FcmTokenList = new ArrayList();
		for(int i=0; i<bco_ordernumList.length; i++) {
			updateCount += dao.stateInTransitChange(bco_ordernumList[i]);
			FcmTokenList.add(memberDao.getFcmToken(bco_ordernumList[i]));
		}
		if(updateCount == bco_ordernumList.length) {
			result = "success";
		}

		String Apikey = "AAAAj07M2yI:APA91bEo4mpDxoDwLqu15vOeEPxt2v5b0fCmkwOBcDG61Ae10bFxCkGtzuFyazCfeEpdGzyXmTeHZlQ6eZjcoowehFNOV-PXNfScKABlqkpR5ftClhby5Zqp9bLKJ8ksNEcpPzeZqz_U";
		String fcmURL = "https://fcm.googleapis.com/fcm/send";

		String notiTitle = "배송시작";
		String notiBody = "배송이 시작되었습니다.";
		String message = "배송이 시작되었습니다.";

		try {
			//디바이스 아이디 담기
			ArrayList deviceList = FcmTokenList;


			URL url = new URL(fcmURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setUseCaches(false);
			conn.setDoInput(true);
			conn.setDoOutput(true);

			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization","key="+Apikey);
			conn.setRequestProperty("Content-Type","application/json");

			JSONObject json = new JSONObject();

			JSONObject noti = new JSONObject();
			noti.put("title", notiTitle);
			noti.put("body",notiBody);

			JSONObject data = new JSONObject();
			data.put("message",message);


			json.put("registration_ids",deviceList);//여러명한테 보낼때..

			json.put("notification",noti);
			json.put("data", data);

			try {

				OutputStreamWriter wr = new OutputStreamWriter(
						conn.getOutputStream());
//				System.out.println("json.toString() = " + json.toString());
				wr.write(json.toString());
				wr.flush();

				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String output;
//				System.out.println("Output from Server .... \n");
				while ((output = br.readLine()) != null){
					System.out.println(output);
				}

			}catch (Exception e){
				e.printStackTrace();
			}

			model.addAttribute("notiTitle",notiTitle);
			model.addAttribute("notiBody",notiBody);
			model.addAttribute("message",message);
			model.addAttribute("result", "FCM 발송됨");



		}catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	@Override
	public String stateChange(HttpServletRequest request, Model model) {
		String status = request.getParameter("status");
		String[] bco_ordernum = request.getParameterValues("bco_ordernum");
		int count = 0;
		String result = "";
		for(int i=0; i<bco_ordernum.length; i++) {
			count += dao.stateChange(status, bco_ordernum[i]);
		}
		if(count == bco_ordernum.length) {
			result = "success";
		}
		return result;
	}
	
	
	
	public PageInfo articlePage(int curPage, int count, String type, String word) {
		String searchType = type;
		String searchWord = word;
		// 총 게시물의 갯수
		int totalCount = count;

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
		pinfo.setSearchType(searchType);
		pinfo.setSearchWord(searchWord);
		
		return pinfo;
	}
}
