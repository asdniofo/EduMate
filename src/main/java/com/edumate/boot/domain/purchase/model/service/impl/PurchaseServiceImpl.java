package com.edumate.boot.domain.purchase.model.service.impl;

import com.edumate.boot.domain.purchase.model.service.PurchaseService;
import com.edumate.boot.domain.purchase.model.mapper.PurchaseMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PurchaseServiceImpl implements PurchaseService {

    private final PurchaseMapper pMapper;

    @Override
    public int updateMoney(String memberId, int amount) {
        int result = pMapper.updateMoney(memberId, amount);
        return result;
    }

    @Override
    public int minusMoney(String memberId, int amount) {
        int result = pMapper.minusMoney(memberId, amount);
        return result;
    }

    @Override
    public int updatePurchase(int lectureNo, String memberId, int videoNo) {
        int result = pMapper.updatePurchase(lectureNo, memberId, videoNo);
        return result;
    }

    @Override
    public int findVideo(int lectureNo) {
        int result = pMapper.findVideo(lectureNo);
        return result;
    }
    
    @Override
    public int updateRecentVideo(String memberId, int lectureNo, int videoNo) {
        int result = pMapper.updateRecentVideo(memberId, lectureNo, videoNo);
        return result;
    }
    
    @Override
    public int getRecentVideoNo(String memberId, int lectureNo) {
        int result = pMapper.getRecentVideoNo(memberId, lectureNo);
        return result;
    }
    
    @Override
    public int payToTeacher(String teacherId, int amount) {
        int result = pMapper.payToTeacher(teacherId, amount);
        return result;
    }
    
    @Override
    public int withdrawMoney(String memberId, int amount) {
        return pMapper.withdrawMoney(memberId, amount);
    }
    
    @Override
    public int refundMoney(String memberId, int amount) {
        return pMapper.refundMoney(memberId, amount);
    }
    
    @Override
    public int insertWithdrawRequest(String memberId, String bank, String accountNumber, int amount) {
        // 출금 신청 시 먼저 돈을 차감
        int withdrawResult = pMapper.withdrawMoney(memberId, amount);
        if (withdrawResult > 0) {
            // 돈 차감 성공 시 출금 요청 등록
            return pMapper.insertWithdrawRequest(memberId, bank, accountNumber, amount);
        }
        return 0;
    }
}
