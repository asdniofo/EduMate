package com.edumate.boot.app.admin.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserListRequest {
    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberBirth;
    private String memberType;
    private String teacherYn;
    private String adminYn;
}