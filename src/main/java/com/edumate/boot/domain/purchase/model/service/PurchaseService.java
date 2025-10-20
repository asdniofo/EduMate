package com.edumate.boot.domain.purchase.model.service;

public interface PurchaseService {

    int updateMoney(String memberId, int amount);

    int minusMoney(String memberId, int amount);

    int updatePurchase(int lectureNo, String memberId);
}
