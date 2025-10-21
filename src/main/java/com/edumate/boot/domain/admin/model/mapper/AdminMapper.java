package com.edumate.boot.domain.admin.model.mapper;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AdminMapper {

    UserStatusRequest getUserStatus();
    
    List<UserListRequest> getUserListPaging(int startRow, int endRow, String sortType, String searchKeyword);
    
    int getUserSearchCount(String searchKeyword);

    int updateUser(UserListRequest user);

    int deleteUser(String memberId);
}
