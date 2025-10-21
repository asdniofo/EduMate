package com.edumate.boot.domain.member.model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.app.member.dto.InsertRequestRequest;
import com.edumate.boot.domain.member.model.vo.Member;
import com.edumate.boot.domain.member.model.vo.Request;
import com.edumate.boot.domain.teacher.model.vo.Question;

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

	List<Question> selectRequestList(Map<String, Object> searchMap, RowBounds rowBounds);

	int getRequestTotalCount(Map<String, Object> searchMap);

	int insertRequest(InsertRequestRequest request);

	Request selectOneByNo(int requestNo);

	Integer selectPrevRequestNo(Map<String, Object> map);
	
	Integer selectNextRequestNo(Map<String, Object> map);



}
