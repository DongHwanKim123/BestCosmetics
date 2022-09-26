package com.study.springboot.member.service.wjapp;

import javax.servlet.http.HttpServletRequest;

import com.study.springboot.member.dao.wjapp.AppGoodsDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.study.springboot.member.dao.MemberDao;
import com.study.springboot.member.dto.MemberDto;

@Service
public class AppMemberInfoServiceImpl implements AppMemberInfoService
{
	@Autowired
	MemberDao memberDao;
	@Autowired
	AppGoodsDao appGoodsDao;

	@Override
	public MemberDto appGetMemberInfo(HttpServletRequest request)
	{
		String bcm_num = request.getParameter("num");
		MemberDto memberDto = memberDao.selectUser(Integer.parseInt(bcm_num));
        return memberDto;
	}

	@Override
	public void appUpdateMemberInfo(HttpServletRequest request)
	{		
		String bcm_num = request.getParameter("num");
		String firstEmail = request.getParameter("firstEmail");
        String secondEmail = request.getParameter("secondEmail");
        String bcm_email = firstEmail+"@"+secondEmail;
        String bcm_phonenum1 = request.getParameter("phone1");
        String bcm_phonenum2 = request.getParameter("phone2");
        String bcm_phonenum3 = request.getParameter("phone3");
        String bcm_zipcode = request.getParameter("zipcode");
        String bcm_address1 = request.getParameter("address1");
        String bcm_address2 = request.getParameter("address2");
        String bcm_address3 = request.getParameter("address3");

        memberDao.modifyMember(bcm_email,bcm_phonenum1,bcm_phonenum2,bcm_phonenum3,
                               bcm_zipcode,bcm_address1,bcm_address2,bcm_address3,
                               Integer.parseInt(bcm_num));
	}

	@Override
	public int updateFcmToken(HttpServletRequest request) {
		return appGoodsDao.updateFcmToken(request.getParameter("fcmToken"),request.getParameter("bcmNum"));
	}
}
