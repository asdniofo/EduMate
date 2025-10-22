package com.edumate.boot.domain.member.model.service;

import java.util.List;
import java.util.Map;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.app.member.dto.InsertRequestRequest;
import com.edumate.boot.domain.member.model.vo.Member;
import com.edumate.boot.domain.member.model.vo.Request;
import com.edumate.boot.domain.teacher.model.vo.Question;

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
	
	List<Question> selectRequestList(Map<String, Object> searchMap);
	int getTotalCount(Map<String, Object> searchMap);
	int insertRequest(InsertRequestRequest request);
	Request selectOneByNo(int requestNo);
	Integer selectPrevRequestNo(Map<String, Object> map); 
	Integer selectNextRequestNo(Map<String, Object> map);
	int changeRequestStatus(int requestNo);
	int deleteRequest(int requestNo);
	int updateQuestion(Request request);

}