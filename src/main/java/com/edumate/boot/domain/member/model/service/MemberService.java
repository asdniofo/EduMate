package com.edumate.boot.domain.member.model.service;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.vo.Member;

public interface MemberService {

    // 회원가입
    int 	signup(Member member);
    Member	findByMemberId(String memberId);

    // 로그인
    Member login(String memberId, String memberPw);
    
	int insertQuestion(InsertQuestionRequest question);
    // 아이디 / 비밀번호 찾기
	String findMemberId(Member member);
	boolean checkMemberForPwReset(Member member);
	int updateMemberPw(Member member);

}