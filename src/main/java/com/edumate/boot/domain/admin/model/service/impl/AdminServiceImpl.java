package com.edumate.boot.domain.admin.model.service.impl;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.domain.admin.model.mapper.AdminMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper aMapper;

    @Override
    public UserStatusRequest getUserStatus() {
        UserStatusRequest uStatus = aMapper.getUserStatus();
        return uStatus;
    }

    @Override
    public List<UserListRequest> getUserListPaging(int currentPage, int userCountPerPage, String sortType, String searchKeyword) {
        int startRow = (currentPage - 1) * userCountPerPage + 1;
        int endRow = startRow + userCountPerPage - 1;
        return aMapper.getUserListPaging(startRow, endRow, sortType, searchKeyword);
    }
    
    @Override
    public int getUserSearchCount(String searchKeyword) {
        int result = aMapper.getUserSearchCount(searchKeyword);
        return result;
    }

    @Override
    public void updateUser(UserListRequest user) {
        aMapper.updateUser(user);
    }

    @Override
    public void deleteUser(String memberId) {
        aMapper.deleteUser(memberId);
    }
}
