package com.edumate.boot.app.admin.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserStatusRequest {
    private int adminCount;
    private int teacherCount;
    private int studentCount;
    private int totalCount;
}