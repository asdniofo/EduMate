package com.edumate.boot.domain.admin.model.service.impl;

import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.domain.admin.model.mapper.AdminMapper;

import java.util.List;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper adminMapper;

	@Override
	public List<UserListRequest> getUserList() {
		return adminMapper.selectAllUser();
	}

	@Override
	public void updateUser(UserListRequest user) {
		adminMapper.updateUser(user);
		
	}

	@Override
	public void deleteUser(String memberId) {
		adminMapper.deleteUser(memberId);
		
	}

}
