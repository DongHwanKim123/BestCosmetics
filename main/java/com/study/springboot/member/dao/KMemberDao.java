package com.study.springboot.member.dao;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.Like;
import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.OrderDeliveryDto;
import com.study.springboot.member.dto.OrderDetail;
import com.study.springboot.member.dto.PageInfo;

@Mapper
public interface KMemberDao {
	//sns 회원가입 or 로그인
	public void googleJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void facebookJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void kakaoJoin(String bcm_snsId, String bcm_name, String bcm_email);
    public void naverJoin(String bcm_snsId, String bcm_name, String bcm_email);
    // 가입되어있는지 체크
    public MemberDto googleCheck(String bcm_snsId);
    public MemberDto facebookCheck(String bcm_name, String bcm_email);
    public MemberDto kakaoCheck(String bcm_snsId);
    public MemberDto naverCheck(String bcm_snsId);
    // 세션에 회원정보 넣기
    public MemberDto memberSession(String bcm_id);
    // 찜 갯수
    public int likeCount(int bcm_num);
    // 찜 리스트
    public ArrayList<Like> likeList(int start, int end, int bcm_num);
    // 찜 삭제
    public void likeDelete(int bcm_num, int bcg_key);
    // 주문상세
    public ArrayList<OrderDetail> orderDetail(String bco_ordernum);
    // 비밀번호 확인
    public MemberDto pwCheck(String bcm_num);
    // 비밀번호 변경
    public int pwChange(String bcm_num, String bcm_pw);
    public int memberDelete(String bcm_num);    
    //관리자페이지 리스트, 페이징을 위한 카운팅, 검색된것들의 구매 총합
    public List<OrderDeliveryDto> orderManagement(String orderStatus, int nEnd, int nStart);
    public int orderManagementCount(String bco_order_status);
    public String orderManagementTotalPrice(String bco_order_status);   
    // 주문인으로 검색했을때 리스트, 카운팅, 구매 총합
    public int nameOrderManagementCount(String bco_order_status, String bcm_name);
    public String nameOrderManagementTotalPrice(String bco_order_status, String bcm_name);
    public List<OrderDeliveryDto> nameOrderManagement(String orderStatus, int nEnd, int nStart, String detail);    
    // 수령인으로 검색했을때 리스트, 카운팅, 구매 총합
    public int recipientOrderManagementCount(String bco_order_status, String bco_recipient);
    public String recipientOrderManagementTotalPrice(String bco_order_status, String bco_recipient);
    public List<OrderDeliveryDto> recipientOrderManagement(String orderStatus, int nEnd, int nStart, String detail);    
    // 주문번호로 검색했을때 리스트, 카운팅, 구매 총합
    public int ordernumOrderManagementCount(String bco_order_status, String bco_ordernum);
    public String ordernumOrderManagementTotalPrice(String bco_order_status, String bco_ordernum);
    public List<OrderDeliveryDto> ordernumOrderManagement(String orderStatus, int nEnd, int nStart, String detail);    
    // 배송준비중 인것 배송중으로 상태 변경, 상태변경날짜 sysdate
    public int stateInTransitChange(String bco_ordernum);
    // 배송중 인것 배송완료로 상태 변경, 상태변경날짜 sysdate
    public int stateDeliveryCompletedChange(String bco_ordernum);
    // 주문상태변경
    public int stateChange(String bco_order_status, String bco_ordernum);
    // 관리자 페이지 취소/교환/반품 리스트, 카운팅, 구매 총합
    public List<OrderDeliveryDto> orderManagementCER(int nEnd, int nStart);
    public int orderManagementCERCount();
    public String orderManagementCERTotalPrice();    
    // 관리자 페이지 취소/교환/반품 주문인 검색했을때 리스트, 카운팅, 구매 총합
    public int nameOrderManagementCERCount(String bcm_name);
    public String nameOrderManagementCERTotalPrice(String bcm_name);
    public List<OrderDeliveryDto> nameOrderManagementCER(String bcm_name, int nEnd, int nStart);    
    // 관리자 페이지 취소/교환/반품 주문번호로 검색했을때 리스트, 카운팅, 구매 총합
    public int ordernumOrderManagementCERCount(String bcm_name);
    public String ordernumOrderManagementCERTotalPrice(String bcm_name);
    public List<OrderDeliveryDto> ordernumOrderManagementCER(String bcm_name, int nEnd, int nStart);
    // 관리자 페이지 취소/교환/반품 주문상태로 검색했을때 리스트, 카운팅, 구매 총합
    public int orderStatusOrderManagementCERCount(String bcm_name);
    public String orderStatusOrderManagementCERTotalPrice(String bcm_name);
    public List<OrderDeliveryDto> orderStatusOrderManagementCER(String bcm_name, int nEnd, int nStart);
    // 관리자 페이지 주문리스트(전체) 리스트, 카운팅, 구매 총합
    public int TotalOrderListCount();
    public List<OrderDeliveryDto> TotalOrderList(int nEnd, int nStart);
    public String TotalOrderListTotalPrice();
    // 관리자 페이지 주문리스트(전체) 주문인검색
    public int nameTotalOrderListCount(String bcm_name);
    public List<OrderDeliveryDto> nameTotalOrderList(int nEnd, int nStart, String bcm_name);
    public String nameTotalOrderListTotalPrice(String bcm_name);
    // 관리자 페이지 주문리스트(전체) 수령인검색
    public int recipientTotalOrderListCount(String bco_recipient);
    public List<OrderDeliveryDto> recipientTotalOrderList(int nEnd, int nStart, String bco_recipient);
    public String recipientTotalOrderListTotalPrice(String bco_recipient);
    // 관리자 페이지 주문리스트(전체) 주문번호검색
    public int ordernumTotalOrderListCount(String bco_ordernum);
    public List<OrderDeliveryDto> ordernumTotalOrderList(int nEnd, int nStart, String bco_ordernum);
    public String ordernumTotalOrderListTotalPrice(String bco_ordernum);
    // 관리자 페이지 주문리스트(전체) 주문상태검색
    public int orderStatusTotalOrderListCount(String bco_order_status);
    public List<OrderDeliveryDto> orderStatusTotalOrderList(int nEnd, int nStart, String bco_order_status);
    public String orderStatusTotalOrderListTotalPrice(String bco_order_status);
}
