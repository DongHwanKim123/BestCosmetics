package com.study.springboot.member.dao;

import com.study.springboot.member.dto.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.ArrayList;



@Mapper
public interface MemberDao {
    public int join(String bcm_id,String bcm_pw,String bcm_name,String bcm_email);
    public MemberDto userCheck(String bcm_id);
    public ArrayList<OrderDeliveryDto> orderDeliveryView(int bcm_num,int nEnd, int nStart);
    public int articlePage(int bcm_num);
    public int cancellationRequest(int bcm_num, String bco_ordernum);
    public int exchangeRequest(int bcm_num, String bco_ordernum);
    public int refundRequest(int bcm_num, String bco_ordernum);
    public int purchaseConfirmation(int bcm_num, String bco_ordernum);
    public ArrayList<OrderDeliveryDto> cancelExchangeRefund(int bcm_num, int nEnd, int nStart);
    public int articlePage2(int bcm_num);
    public MemberDto selectUser(int bcm_num);
    public int modifyMember(String bcm_email,String bcm_phonenum1,String bcm_phonenum2,String bcm_phonenum3,
                            String bcm_zipcode,String bcm_address1,String bcm_address2,String bcm_address3,
                            int bcm_num );
    public ArrayList<GoodsJoinBasketJoinGoodDetailDto> basketListView(int bcm_num);
    public int deleteBasket(int bcm_num,String bcg_key,String bcd_detailkey);
    public GoodsJoinDetailGoodsDto orderCheck(String bcg_key, String bcd_detailkey);
    public int basketUpCount(int bcm_num,String bcg_key,String bcd_detailkey);
    public int basketDownCount(int bcm_num,String bcg_key,String bcd_detailkey);
    public int insertOrderDetail(String bco_ordernum, int bcg_key, int bcd_detailkey, String bco_count);
    public int insertOrderHistory(int bcm_num,String bco_phonenum1,String bco_phonenum2,
                                  String bco_phonenum3,String bco_ordernum,String bcm_name,
                                  String bco_recipient,String bco_totalprice,String bco_order_name);
    public int insertDeliveryInfo(int bcm_num,String bco_ordernum,String bcd_zipcode,
                                  String bcd_address1,String bcd_address2,String bcd_address3,
                                  String bcd_request );
    public int updateGoodsStock(int bcg_key);
    public int updateDetailGoodsStock(int bcg_key,int bcd_detailkey);
    public int deleteBasketAfterPayment(int bcm_num,int bcg_key,int bcd_detailkey);
    public ArrayList<MemberJoinOrderHistoryDto> memberManagement(int nEnd, int nStart);
    public int memberManagementArticlePage();
    public ArrayList<MemberJoinOrderHistoryDto> serchByNameMemberManagement(String searchWord,int nEnd, int nStart);
    public int serchByNameMemberManagementArticlePage(String searchWord);
    public ArrayList<MemberJoinOrderHistoryDto> serchByIdMemberManagement(String searchWord,int nEnd, int nStart);
    public int serchByIdMemberManagementArticlePage(String searchWord);
    public ArrayList<MemberJoinOrderHistoryDto> serchByNumMemberManagement(String searchWord,int nEnd, int nStart);
    public int serchByNumMemberManagementArticlePage(String searchWord);
    public int upgradeAdmin(String bcm_num);
    public int updatePurchaseConfirmation();
    public int basketCount(int bcm_num);
    public ArrayList<DeliveryInfoDto> lastDeliveryDestination(int bcm_num);
    public String[] getAllFcmToken();
    public String getFcmToken(String orderNum);
}
