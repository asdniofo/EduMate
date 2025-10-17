package com.edumate.boot.domain.member.model.service;

import com.edumate.boot.domain.member.model.vo.Member;

public interface MemberService {

    // 회원가입
    int 	signup(Member member);
    Member	findByMemberId(String memberId);

    // 로그인
    Member login(String memberId, String memberPw);

}