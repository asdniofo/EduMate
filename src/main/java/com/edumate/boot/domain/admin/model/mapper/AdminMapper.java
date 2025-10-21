package com.edumate.boot.domain.admin.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.app.admin.dto.UserListRequest;

@Mapper
public interface AdminMapper {
    List<UserListRequest> selectAllUser();
    int updateUser(UserListRequest user);
    int deleteUser(String memberId);
}