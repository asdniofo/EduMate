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
    public int updatePurchase(int lectureNo, String memberId) {
        int result = pMapper.updatePurchase(lectureNo, memberId);
        return result;
    }
}
