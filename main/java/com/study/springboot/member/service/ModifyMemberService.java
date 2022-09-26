package com.study.springboot.member.service;

import com.study.springboot.member.dto.ValidationMember;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

public interface ModifyMemberService {
    public String modifyValidation(@ModelAttribute("dto") @Valid ValidationMember validationMember,
                         BindingResult bindingResult);
    public int modify(HttpServletRequest request, Model model);

}
