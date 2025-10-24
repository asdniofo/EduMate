package com.edumate.boot.domain.admin.model.service;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.app.admin.dto.WithDrawRequest;

import java.util.List;
import java.util.Map;

public interface AdminService {
    UserStatusRequest getUserStatus();
    List<UserListRequest> getUserListPaging(int currentPage, int userCountPerPage, String sortType, String searchKeyword);
    int getUserSearchCount(String searchKeyword);
    void updateUser(UserListRequest user);
    void deleteUser(String memberId);
    int getTotalWithDraw();
    int getTotalWithDrawByStatus(String status);
    List<WithDrawRequest> getWithDrawListPaging(int currentPage, int withDrawCountPerPage, String sortType);
    
    int approveWithdrawRequest(int withdrawNo);
    
    int rejectWithdrawRequest(int withdrawNo);
}