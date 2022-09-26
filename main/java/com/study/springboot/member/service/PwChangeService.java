package com.study.springboot.member.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;

import com.study.springboot.member.dto.ValidationMember;

public interface PwChangeService {
	public String pwChange(HttpServletRequest request, Model model);
	public String joinValidation(ValidationMember validationMember, BindingResult bindingResult);
}
