package com.study.springboot.member.service.wjapp;

import com.study.springboot.goods.dao.InBagDao;
import com.study.springboot.member.dao.MemberDao;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

@Service
public class AppBasketServiceImpl implements AppBasketService{
    @Autowired
    MemberDao memberDao;
    @Autowired
    InBagDao inBagDao;
    @Override
    public int deleteBasket(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int deleteCount = memberDao.deleteBasket(bcm_num,bcg_key,bcd_detailkey);
        return deleteCount;
    }

    @Override
    public int basketUpCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketUpCount(bcm_num,bcg_key,bcd_detailkey);
        return updateCount;
    }

    @Override
    public int basketDownCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        String bcg_key = request.getParameter("bcg_key");
        String bcd_detailkey = request.getParameter("bcd_detailkey");
        int updateCount = memberDao.basketDownCount(bcm_num,bcg_key,bcd_detailkey);
        System.out.println(11111);
        return updateCount;
    }

    @Override
    public int basketCount(HttpServletRequest request) {
        int bcm_num = Integer.parseInt(request.getParameter("bcmNum"));
        int basketCount = memberDao.basketCount(bcm_num);
        return basketCount;
    }

    @Override
    public void basketAdd(List<HashMap<String, Object>> json) {
        //System.out.println(json);
        for (HashMap<String, Object> stringObjectHashMap : json) {
//            System.out.println(stringObjectHashMap.get("bcmNum"));
//            System.out.println(stringObjectHashMap.get("bcg_key"));
//            System.out.println(stringObjectHashMap.get("bcg_key"));
//            System.out.println(stringObjectHashMap.get("bcg_key"));
            inBagDao.addBag(Integer.parseInt((String) stringObjectHashMap.get("bcmNum")),
                    (int) stringObjectHashMap.get("bcg_key"),
                    (int) stringObjectHashMap.get("bcd_detailkey"),
                    (int) stringObjectHashMap.get("count"));
        }
    }
}
