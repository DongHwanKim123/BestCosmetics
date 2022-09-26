package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.ValidationMember;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Service
public class ModifyMemberServiceImpl implements ModifyMemberService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public String modifyValidation(@ModelAttribute("dto") @Valid ValidationMember validationMember,
                         BindingResult bindingResult) {
        if(bindingResult.hasErrors()){
            if (bindingResult.getFieldError("firstEmail") != null) {
                return bindingResult.getFieldError("firstEmail").getDefaultMessage();
            } else if (bindingResult.getFieldError("secondEmail") != null) {
                return bindingResult.getFieldError("secondEmail").getDefaultMessage();
            } else if (bindingResult.getFieldError("bcm_phonenum1") != null) {
                return bindingResult.getFieldError("bcm_phonenum1").getDefaultMessage();
            } else if (bindingResult.getFieldError("bcm_phonenum2") != null) {
                return bindingResult.getFieldError("bcm_phonenum2").getDefaultMessage();
            } else if (bindingResult.getFieldError("bcm_phonenum3") != null) {
                return bindingResult.getFieldError("bcm_phonenum3").getDefaultMessage();
            } else if (bindingResult.getFieldError("bcm_zipcode") != null) {
                return bindingResult.getFieldError("bcm_zipcode").getDefaultMessage();
            }
        }
        return null;
    }

    @Override
    public int modify(HttpServletRequest request, Model model) {
        String firstEmail = request.getParameter("firstEmail");
        String secondEmail = request.getParameter("secondEmail");
        String bcm_email = firstEmail+"@"+secondEmail;
        String bcm_phonenum1 = request.getParameter("bcm_phonenum1");
        String bcm_phonenum2 = request.getParameter("bcm_phonenum2");
        String bcm_phonenum3 = request.getParameter("bcm_phonenum3");
        String bcm_zipcode = request.getParameter("bcm_zipcode");
        String bcm_address1 = request.getParameter("bcm_address1");
        String bcm_address2 = request.getParameter("bcm_address2");
        String bcm_address3 = request.getParameter("bcm_address3");
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");

        int updateCount = memberDao.modifyMember(bcm_email,bcm_phonenum1,bcm_phonenum2,bcm_phonenum3,
                                                bcm_zipcode,bcm_address1,bcm_address2,bcm_address3,
                                                bcm_num);
//        System.out.println(updateCount);
        return updateCount;
    }
}
