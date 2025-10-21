package com.edumate.boot.app.admin.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class UserListRequest {
    private String 	memberId;
    private String 	memberPw;
    private String 	memberEmail;
    private String 	memberName;
    private String 	memberBirth;
    private int 	memberMoney;
    private String 	teacherYN;
    private String 	adminYN;
    private String	type;
}
