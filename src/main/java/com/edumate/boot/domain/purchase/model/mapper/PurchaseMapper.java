package com.edumate.boot.domain.purchase.model.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PurchaseMapper {

    int updateMoney(String memberId, int amount);

    int minusMoney(String memberId, int amount);

    int updatePurchase(int lectureNo, String memberId);
}
