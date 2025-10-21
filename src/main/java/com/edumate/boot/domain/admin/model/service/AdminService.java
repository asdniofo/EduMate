package com.edumate.boot.domain.admin.model.service;

import java.util.List;

import com.edumate.boot.app.admin.dto.UserListRequest;

public interface AdminService {
    List<UserListRequest> getUserList();
    void updateUser(UserListRequest user);
    void deleteUser(String memberId);
}
