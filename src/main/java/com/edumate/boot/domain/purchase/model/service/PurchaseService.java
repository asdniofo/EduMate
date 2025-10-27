package com.edumate.boot.domain.purchase.model.service;

public interface PurchaseService {

    int updateMoney(String memberId, int amount);

    int minusMoney(String memberId, int amount);

    int updatePurchase(int lectureNo, String memberId, int videoNo);

    int findVideo(int lectureNo);
    
    int updateRecentVideo(String memberId, int lectureNo, int videoNo);
    
    int getRecentVideoNo(String memberId, int lectureNo);
    
    int payToTeacher(String teacherId, int amount);
    
    int withdrawMoney(String memberId, int amount);
    
    int refundMoney(String memberId, int amount);
    
    int insertWithdrawRequest(String memberId, String bank, String accountNumber, int amount);
}
