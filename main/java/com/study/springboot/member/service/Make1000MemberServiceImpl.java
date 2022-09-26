package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class Make1000MemberServiceImpl implements Make1000MemberService{
    @Autowired
    MemberDao memberDao;

    @Override
    public void makeMember() {

        Random random = new Random();
        String firstName = "";
        String secondName = "";
        String tirdName = "";
        for (int i = 0 ; i<1000 ; i++){
            int num1 = random.nextInt(9);

            if(num1==0){
                firstName="김";
            } else if (num1==1) {
                firstName="이";
            } else if (num1==2) {
                firstName="박";
            } else if (num1==3) {
                firstName="윤";
            } else if (num1==4) {
                firstName="나";
            } else if (num1==5) {
                firstName="강";
            } else if (num1==6) {
                firstName="최";
            } else if (num1==7) {
                firstName="문";
            } else if (num1==8) {
                firstName="곽";
            } else if(num1==9) {
                firstName="심";
            }

            int num2 = random.nextInt(9);

            if(num2==0){
                secondName="하";
            } else if (num2==1) {
                secondName="도";
            } else if (num2==2) {
                secondName="윤";
            } else if (num2==3) {
                secondName="우";
            } else if (num2==4) {
                secondName="동";
            } else if (num2==5) {
                secondName="지";
            } else if (num2==6) {
                secondName="은";
            } else if (num2==7) {
                secondName="희";
            } else if (num2==8) {
                secondName="선";
            } else if(num2==9) {
                secondName="환";
            }
            int num3 = random.nextInt(9);

            if(num3==0){
                tirdName="하";
            } else if (num3==1) {
                tirdName="도";
            } else if (num3==2) {
                tirdName="윤";
            } else if (num3==3) {
                tirdName="우";
            } else if (num3==4) {
                tirdName="동";
            } else if (num3==5) {
                tirdName="지";
            } else if (num3==6) {
                tirdName="은";
            } else if (num3==7) {
                tirdName="희";
            } else if (num3==8) {
                tirdName="선";
            } else if(num3==9) {
                tirdName="환";
            }

            String bcm_id = "cosmetics"+String.valueOf(i);
            String pw = "qwer1234!@#$";
            String bcm_name = firstName +secondName+tirdName;
            String firstEmail = "BestCosmetics"+String.valueOf(i);
            String secondEmail = "gmail.com";

            //비밀번호 복호화
            String bcm_pw= PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(pw);
            System.out.println(bcm_pw);
            //이메일 합치기
            String bcm_email = firstEmail+"@"+secondEmail;

            memberDao.join(bcm_id,bcm_pw,bcm_name,bcm_email);
        }

    }
}
