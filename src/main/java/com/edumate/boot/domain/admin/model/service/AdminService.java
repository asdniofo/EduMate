package com.edumate.boot.domain.admin.model.service;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;

import java.util.List;

public interface AdminService {

    UserStatusRequest getUserStatus();
    
    List<UserListRequest> getUserListPaging(int currentPage, int userCountPerPage, String sortType, String searchKeyword);
    
    int getUserSearchCount(String searchKeyword);
}
