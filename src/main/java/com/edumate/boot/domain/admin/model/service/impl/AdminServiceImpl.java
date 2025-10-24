package com.edumate.boot.domain.admin.model.service.impl;

import com.edumate.boot.app.admin.dto.UserListRequest;
import com.edumate.boot.app.admin.dto.UserStatusRequest;
import com.edumate.boot.app.admin.dto.WithDrawRequest;
import com.edumate.boot.domain.admin.model.service.AdminService;
import com.edumate.boot.domain.admin.model.mapper.AdminMapper;
import com.edumate.boot.domain.purchase.model.mapper.PurchaseMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class AdminServiceImpl implements AdminService {

    private final AdminMapper aMapper;
    private final PurchaseMapper pMapper;

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

    @Override
    public int getTotalWithDraw() {
        int result = aMapper.getTotalWithDraw();
        return result;
    }

    @Override
    public int getTotalWithDrawByStatus(String status) {
        return aMapper.getTotalWithDrawByStatus(status);
    }

    @Override
    public List<WithDrawRequest> getWithDrawListPaging(int currentPage, int withDrawCountPerPage, String sortType) {
        int startRow = (currentPage - 1) * withDrawCountPerPage + 1;
        int endRow = startRow + withDrawCountPerPage - 1;
        return aMapper.getWithDrawListPaging(startRow, endRow, sortType);
    }
    
    @Override
    public int approveWithdrawRequest(int withdrawNo) {
        return aMapper.approveWithdrawRequest(withdrawNo);
    }
    
    @Override
    public int rejectWithdrawRequest(int withdrawNo) {
        // 출금 요청 정보 조회
        WithDrawRequest withdrawRequest = aMapper.getWithdrawRequestById(withdrawNo);
        
        // 상태를 거절로 변경
        int result = aMapper.rejectWithdrawRequest(withdrawNo);
        
        // 거절 시 돈을 되돌려줌 (기존 updateMoney 활용)
        if (result > 0 && withdrawRequest != null) {
            pMapper.updateMoney(withdrawRequest.getMemberId(), withdrawRequest.getAmount());
        }
        
        return result;
    }
}
