package com.edumate.boot.domain.member.model.service;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.vo.Member;

public interface MemberService {
	
	// 회원가입
	int 	signup(Member member);
	Member	findByMemberId(String memberId);

	int insertQuestion(InsertQuestionRequest question);

}
