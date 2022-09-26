package com.study.springboot.member.service;

import com.study.springboot.member.dto.MemberDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

public interface ModifyMemberViewService {
    public MemberDto modifyMemberView(HttpServletRequest request, Model model);

}
