package com.edumate.boot.domain.admin.model.mapper;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.app.admin.dto.WithDrawRequest;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface AdminMapper {

    UserStatusRequest getUserStatus();
    
    List<UserListRequest> getUserListPaging(int startRow, int endRow, String sortType, String searchKeyword);
    
    int getUserSearchCount(String searchKeyword);

    int updateUser(UserListRequest user);

    int deleteUser(String memberId);
    
    List<Map<String, Object>> getRecentWithdrawRequests();

    int getTotalWithDraw();

    int getTotalWithDrawByStatus(String status);

    List<WithDrawRequest> getWithDrawListPaging(int startRow, int endRow, String sortType);
    
    int approveWithdrawRequest(int withdrawNo);
    
    int rejectWithdrawRequest(int withdrawNo);
    
    WithDrawRequest getWithdrawRequestById(int withdrawNo);
}
