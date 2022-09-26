package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.MemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Service
public class ModifyMemberViewServiceImpl implements ModifyMemberViewService{
    @Autowired
    MemberDao memberDao;
    HttpSession session;
    @Override
    public MemberDto modifyMemberView(HttpServletRequest request, Model model) {
        session = request.getSession();
        int bcm_num = (int) session.getAttribute("num");
        MemberDto memberDto = memberDao.selectUser(bcm_num);
        model.addAttribute("user",memberDto);
        return memberDto;
    }
}
