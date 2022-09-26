package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.ValidationMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;

import javax.servlet.http.HttpServletRequest;


@Validated
@Service
public class JoinServiceImpl implements JoinService{
    @Autowired
    MemberDao memberDao;
    @Override
    public String join(HttpServletRequest request, Model model) {
        String bcm_id = request.getParameter("id");
        String pw = request.getParameter("pw");
        String bcm_name = request.getParameter("name");
        String firstEmail = request.getParameter("firstEmail");
        String secondEmail = request.getParameter("secondEmail");

        //비밀번호 복호화
        String bcm_pw=PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(pw);
//		System.out.println(bcm_pw);
        //이메일 합치기
        String bcm_email = firstEmail+"@"+secondEmail;

        int insertCount = memberDao.join(bcm_id,bcm_pw,bcm_name,bcm_email);
        if (insertCount == 1){
//            System.out.println("회원가입 데이터베이스 입력완료");
            return "1";
        }else if(insertCount == 0){
//            System.out.println("회원가입 데이터베이스 입력실패");
            return "0";
        }
//        System.out.println("회원가입 데이터베이스 오류");
        return "-1";
    }

    @Override
    public MemberDto userCheck(HttpServletRequest request, Model model) {
        String bcm_id = request.getParameter("id");
        MemberDto memberDto = memberDao.userCheck(bcm_id);
        model.addAttribute("user",memberDto);
        return memberDto;
    }

    @Override
    public String joinValidation(ValidationMember validationMember, BindingResult bindingResult) {
        if(bindingResult.hasErrors()) {
            if (bindingResult.getFieldError("id") != null){
                return bindingResult.getFieldError("id").getDefaultMessage();
            } else if (bindingResult.getFieldError("pw") != null) {
                return bindingResult.getFieldError("pw").getDefaultMessage();
            } else if (bindingResult.getFieldError("name") != null) {
                return bindingResult.getFieldError("name").getDefaultMessage();
            } else if (bindingResult.getFieldError("firstEmail") != null) {
                return bindingResult.getFieldError("firstEmail").getDefaultMessage();
            } else if (bindingResult.getFieldError("secondEmail") != null) {
                return bindingResult.getFieldError("secondEmail").getDefaultMessage();
            }
        }
        return null;
    }
}
