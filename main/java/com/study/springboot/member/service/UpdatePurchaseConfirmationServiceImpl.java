package com.study.springboot.member.service;

import com.study.springboot.member.dao.MemberDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UpdatePurchaseConfirmationServiceImpl implements UpdatePurchaseConfirmationService{
    @Autowired
    MemberDao memberdao;
    @Override
    public int updatePurchaseConfirmation() {
        int updateCount = memberdao.updatePurchaseConfirmation();
        return updateCount;
    }
}
