package com.study.springboot.member.service;

import com.study.springboot.member.dto.MemberJoinOrderHistoryDto;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;

public interface MemberManagementViewService {
    public ArrayList<MemberJoinOrderHistoryDto> memberManagementView(HttpServletRequest request, Model model);
    public void allMemberCount(Model model);
}
