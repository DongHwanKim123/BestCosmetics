package com.study.springboot.member.service;

import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.ValidationMember;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;


public interface JoinService {
    public String join(HttpServletRequest request, Model model);
    public MemberDto userCheck(HttpServletRequest request, Model model);
    public String joinValidation(@ModelAttribute("dto") @Valid ValidationMember validationMember,
                                 BindingResult bindingResult);
}
