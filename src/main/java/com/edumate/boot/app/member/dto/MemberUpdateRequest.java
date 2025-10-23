package com.edumate.boot.app.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberUpdateRequest {
    private String memberId;
    private String memberPw;
    private String memberName;
    private String memberEmail;
    private String memberBirth;
    private String recaptchaResponse;
}