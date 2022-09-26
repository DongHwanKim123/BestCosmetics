package com.study.springboot.member.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.DeliveryInfoDto;

@Service
public class UtilServiceImpl implements UtilService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public String createOrderNum(HttpServletRequest request , Model model) {
        Random random = new Random();
        //한번에 랜덤뽑기
        int num = random.nextInt(100000000);
        String strNum="";
        if(num>10000000){
            strNum = ""+Integer.toString(num);
        } else if(num>1000000){
            strNum = "0"+Integer.toString(num);
        }else if(num>100000){
            strNum = "0"+Integer.toString(num);
        } else if (num>10000) {
            strNum = "00"+Integer.toString(num);
        } else if (num>1000) {
            strNum = "000"+Integer.toString(num);
        } else if (num>100) {
            strNum = "0000"+Integer.toString(num);
        } else if (num>10) {
            strNum = "00000"+Integer.toString(num);
        } else {
            strNum = "000000"+Integer.toString(num);
        }
        strNum = "B"+strNum;
//        System.out.println(strNum);

        model.addAttribute("orderNum", strNum);
        return strNum;
    }

    @Override
    public JSONObject lastDeliveryDestination(HttpServletRequest request) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        ArrayList<DeliveryInfoDto> dtos = memberDao.lastDeliveryDestination(bcm_num);
        JSONObject object = new JSONObject();
        object.put("lastDelivery", dtos);
        return object;
    }

    @Override
    public ArrayList<DeliveryInfoDto> appLastDeliveryDestination(HttpServletRequest request) {
        return memberDao.lastDeliveryDestination(Integer.parseInt(request.getParameter("bcmNum")));
    }

    @Override
    public void fcmAllmember(Model model, HttpServletRequest request, HttpServletResponse response) {
        String Apikey = "";
        String fcmURL = "";

        response.setCharacterEncoding("UTF-8");
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

        String notiTitle = request.getParameter("notiTitle");
        String notiBody = request.getParameter("notiBody");
        String message = request.getParameter("message");
//        System.out.println("notiTitle = " + notiTitle);
//        System.out.println("notiBody = " + notiBody);
//        System.out.println("message = " + message);

        try {
            //디바이스 아이디 담기
            ArrayList deviceList = new ArrayList();
            String[] deviceId = memberDao.getAllFcmToken();
            for (int i = 0; i < deviceId.length; i++) {
                deviceList.add(deviceId[i]);
            }

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
//                System.out.println("json.toString() = " + json.toString());
                wr.write(json.toString());
                wr.flush();

                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

                String output;
//                System.out.println("Output from Server .... \n");
                while ((output = br.readLine()) != null){
//                    System.out.println(output);
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
    }
}
