package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Array;

@Service
public class AfterPaymentServiceImpl implements AfterPaymentService {
    HttpSession session;
    @Autowired
    MemberDao memberDao;
    @Autowired
    TransactionTemplate transactionTemplate;
    @Override
    public int afterPayment(HttpServletRequest request) {
        try {
            transactionTemplate.execute(new TransactionCallbackWithoutResult() {
                @Override
                protected void doInTransactionWithoutResult(TransactionStatus status) {
                    session = request.getSession();
                    int bcm_num = (int) session.getAttribute("num");
                    String sId = request.getParameter("sId");
                    String orderNum = request.getParameter("orderNum");
                    String reciName = request.getParameter("reciName");
                    String orderListJson = request.getParameter("orderListJson");
                    String realTotalPrice = request.getParameter("realTotalPrice");
                    String bcm_phonenum1 = request.getParameter("bcm_phonenum1");
                    String bcm_phonenum2 = request.getParameter("bcm_phonenum2");
                    String bcm_phonenum3 = request.getParameter("bcm_phonenum3");
                    String bcm_zipcode = request.getParameter("bcm_zipcode");
                    String bcm_address1 = request.getParameter("bcm_address1");
                    String bcm_address2 = request.getParameter("bcm_address2");
                    String bcm_address3 = request.getParameter("bcm_address3");
                    String deliveryRequest = request.getParameter("deliveryRequest");
                    String orderName = request.getParameter("orderName");

                    memberDao.insertOrderHistory(bcm_num,bcm_phonenum1,bcm_phonenum2,bcm_phonenum3,
                            orderNum,sId,reciName,realTotalPrice,orderName);
                    memberDao.insertDeliveryInfo(bcm_num,orderNum,bcm_zipcode,bcm_address1,
                            bcm_address2,bcm_address3,deliveryRequest);
                    JSONArray jsonArray = new JSONArray(orderListJson);
                    System.out.println(jsonArray.length());
                    for (int i = 0; i<jsonArray.length() ; i++) {
                        int bcg_key = jsonArray.getJSONObject(i).getInt("bcg_key");
                        int bcg_detailkey = jsonArray.getJSONObject(i).getInt("bcg_detailkey");
                        String count = jsonArray.getJSONObject(i).getString("count");
                        memberDao.insertOrderDetail(orderNum,bcg_key,bcg_detailkey,count);
                        memberDao.updateGoodsStock(bcg_key);
                        memberDao.updateDetailGoodsStock(bcg_key, bcg_detailkey);
                        memberDao.deleteBasketAfterPayment(bcm_num,bcg_key,bcg_detailkey);
                    }
                }
            });
//            System.out.println("커밋");
            return 1;
        }catch (Exception e) {
//            System.out.println("롤백");
            return 0;
        }
    }
}
