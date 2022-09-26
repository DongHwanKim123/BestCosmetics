package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import com.study.springboot.member.dao.KMemberDao;
import com.study.springboot.member.dto.ValidationMember;

@Service
public class PwChangeServiceImpl implements PwChangeService {

	@Autowired
	KMemberDao dao;
	
	@Override
	public String pwChange(HttpServletRequest request, Model model) {
		String result = "";
		String bcm_num = request.getParameter("bcm_num");
		String nPw = request.getParameter("nPwConfirm");
		
		String bcm_pw = PasswordEncoderFactories.createDelegatingPasswordEncoder().encode(nPw);
		
		int updateCount = dao.pwChange(bcm_num, bcm_pw);
		if(updateCount == 1) {
			result = "성공";
		}
		else {
			result = "에러";
		}
		return result;
		
	}
	@Override
	public String joinValidation(ValidationMember validationMember, BindingResult bindingResult) {
		
		if(bindingResult.hasErrors()) {
            if (bindingResult.getFieldError("nPw") != null) {
                return bindingResult.getFieldError("nPw").getDefaultMessage();
            }
        }
		return null;
	}
}
