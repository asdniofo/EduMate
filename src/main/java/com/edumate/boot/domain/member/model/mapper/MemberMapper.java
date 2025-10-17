package com.edumate.boot.domain.member.model.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.vo.Member;

@Mapper
public interface MemberMapper {
	// 조회
	Member selectByMemberId(String memberId);

	// 회원가입
	int insertMember(Member member);

	// 로그인
	Member loginMember(Map<String, Object> map);

	int insertQuestion(InsertQuestionRequest question);
	
	String findMemberId(Member member);

	int checkMemberForPwReset(Member member);

	int updateMemberPw(Member member);



}
