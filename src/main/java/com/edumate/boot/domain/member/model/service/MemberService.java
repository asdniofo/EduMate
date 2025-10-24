package com.edumate.boot.domain.member.model.service;

import java.util.List;
import java.util.Map;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.app.member.dto.InsertRequestRequest;
import com.edumate.boot.app.purchase.dto.LectureNoRequest;
import com.edumate.boot.app.member.dto.MemberStatsRequest;
import com.edumate.boot.app.member.dto.MyPostRequest;
import com.edumate.boot.app.member.dto.MyCommentRequest;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
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

    int getCount();

    List<LectureNoRequest> findLectureById(String memberId);
    
    int updateMemberInfo(Member member);
    
    MemberStatsRequest getMemberStats(String memberId);
    
    List<MyPostRequest> getMyPosts(String memberId);
    
    List<MyPostRequest> getMyPostsWithSearch(Map<String, Object> searchMap);
    
    int getMyPostsTotalCount(Map<String, Object> searchMap);
    
    List<MyCommentRequest> getMyComments(String memberId);
    
    List<MyCommentRequest> getMyCommentsWithSearch(Map<String, Object> searchMap);
    
    int getMyCommentsTotalCount(Map<String, Object> searchMap);

    List<Lecture> findTeacherLecture(String memberId);
}