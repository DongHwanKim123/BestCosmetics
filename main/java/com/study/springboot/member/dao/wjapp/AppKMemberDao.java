package com.study.springboot.member.dao.wjapp;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.study.springboot.member.dto.AppOrderInfo;
import com.study.springboot.member.dto.MemberDto;
import com.study.springboot.member.dto.OrderDeliveryDto;

@Mapper
public interface AppKMemberDao
{
	public String AppPwCheck(String bcm_id);
	public MemberDto getMemberInfo(String bcm_id);
	public int createAppMemberAccount(String bcm_id, String bcm_pw, String bcm_name, String bcm_email);
	public AppOrderInfo orderInfo(int bcm_num);
	public ArrayList<String> selectOrdernum(int bcm_num);
	public OrderDeliveryDto appOrderList(String bco_ordernum);
	public ArrayList<String> selectCEROrdernum(int bcm_num);
	public OrderDeliveryDto appCERList(String bco_ordernum);
}
