package com.study.springboot.member.service.wjapp;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.TransactionCallbackWithoutResult;
import org.springframework.transaction.support.TransactionTemplate;

import java.util.HashMap;
import java.util.List;

@Service
public class AppAfterPaymentServiceImple implements AppAfterPaymentService{
    @Autowired
    MemberDao memberDao;
    @Autowired
    TransactionTemplate transactionTemplate;
    @Override
    public void afterPayment(HashMap<String, Object> json) {
        try {
            transactionTemplate.execute(new TransactionCallbackWithoutResult() {
                @Override
                protected void doInTransactionWithoutResult(TransactionStatus status) {
                    String bcmNum = (String) json.get("bcmNum");
                    String bcmName = (String) json.get("bcmName");
                    String orderNum = (String) json.get("orderNum");
                    String totalPrice = (String) json.get("totalPrice");
                    String phoneNum1 = (String) json.get("phoneNum1");
                    String phoneNum2 = (String) json.get("phoneNum2");
                    String phoneNum3 = (String) json.get("phoneNum3");
                    String zipcode = (String) json.get("zipcode");
                    String address1 = (String) json.get("address1");
                    String address2 = "";
                    String address3 = (String) json.get("address3");
                    String deliveryRequest = (String) json.get("deliveryRequest");
                    String reciName = (String) json.get("reciName");
                    String orderName = (String) json.get("orderName");
                    List<HashMap<String, Object>> orderList = (List<HashMap<String, Object>>) json.get("orderList");
//                    System.out.println("bcmNum = " + bcmNum);
//                    System.out.println("bcmName = " + bcmName);
//                    System.out.println("orderNum = " + orderNum);
//                    System.out.println("totalPrice = " + totalPrice);
//                    System.out.println("phoneNum1 = " + phoneNum1);
//                    System.out.println("phoneNum2 = " + phoneNum2);
//                    System.out.println("phoneNum3 = " + phoneNum3);
//                    System.out.println("zipcode = " + zipcode);
//                    System.out.println("address1 = " + address1);
//                    System.out.println("address2 = " + address2);
//                    System.out.println("address3 = " + address3);
//                    System.out.println("deliveryRequest = " + deliveryRequest);
//                    System.out.println("reciName = " + reciName);
//                    System.out.println("orderList = " + orderList.toString());

                    memberDao.insertOrderHistory(Integer.parseInt(bcmNum),phoneNum1,phoneNum2,phoneNum3,orderNum,
                            bcmName,reciName,totalPrice,orderName);
                    memberDao.insertDeliveryInfo(Integer.parseInt(bcmNum),orderNum,zipcode,address1,address3,address2,deliveryRequest);
                    for (HashMap<String, Object> stringObjectHashMap : orderList) {
                        int bcgKey= (int) stringObjectHashMap.get("bcgKey");
                        int bcgDetailkey= (int) stringObjectHashMap.get("bcgDetailkey");
                        String count= (String) stringObjectHashMap.get("count");
                        memberDao.insertOrderDetail(orderNum,bcgKey,bcgDetailkey,count);
                        memberDao.updateGoodsStock(bcgKey);
                        memberDao.updateDetailGoodsStock(bcgKey,bcgDetailkey);
                        memberDao.deleteBasketAfterPayment(Integer.parseInt(bcmNum),bcgKey,bcgDetailkey);
                    }
                }
            });
//            System.out.println("커밋");
//            return 1;
        }catch (Exception e) {
//            System.out.println("롤백");
//            return 0;
            e.printStackTrace();
        }
    }
}
