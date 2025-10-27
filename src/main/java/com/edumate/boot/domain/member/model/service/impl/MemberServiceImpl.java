package com.edumate.boot.domain.member.model.service.impl;

import com.edumate.boot.app.purchase.dto.LectureNoRequest;
import com.edumate.boot.app.member.dto.MemberStatsRequest;
import com.edumate.boot.app.member.dto.MyPostRequest;
import com.edumate.boot.app.member.dto.MyCommentRequest;
import com.edumate.boot.domain.lecture.model.vo.Lecture;
import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.member.model.vo.Member;
import com.edumate.boot.domain.member.model.vo.Request;
import com.edumate.boot.domain.teacher.model.vo.Question;
import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.app.member.dto.InsertRequestRequest;
import com.edumate.boot.domain.member.model.mapper.MemberMapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;

    @Override
    public int signup(Member member) {
        return memberMapper.insertMember(member);
    }

    @Override
    public Member findByMemberId(String memberId) {
        return memberMapper.selectByMemberId(memberId);
    }

    @Override
    public Member login(String memberId, String memberPw) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberId", memberId);
        map.put("memberPw", memberPw);

        return memberMapper.loginMember(map);
    }

	@Override
	public int insertQuestion(InsertQuestionRequest question) {
    	int result = memberMapper.insertQuestion(question); 
		return result;
    }
	public String findMemberId(Member member) {
		return memberMapper.findMemberId(member);
	}

	@Override
	public boolean checkMemberForPwReset(Member member) {
		int count = memberMapper.checkMemberForPwReset(member);
        return count > 0;
	}

	@Override
	public int updateMemberPw(Member member) {
		return memberMapper.updateMemberPw(member);
	}

	@Override
	public List<Question> selectRequestList(Map<String, Object> searchMap) {
		int currentPage = (int)searchMap.get("currentPage");
		int boardLimit = (int)searchMap.get("boardLimit");
		int offset = (currentPage-1)*boardLimit;
		RowBounds rowBounds = new RowBounds(offset, boardLimit);
		List<Question> searchList = memberMapper.selectRequestList(searchMap, rowBounds);
		return searchList;
	}

	@Override
	public int getTotalCount(Map<String, Object> searchMap) {
		int totalCount = memberMapper.getRequestTotalCount(searchMap);
		return totalCount;
	}

	@Override
	public int insertRequest(InsertRequestRequest request) {
		int result = memberMapper.insertRequest(request); 
		return result;
	}

	@Override
	public Request selectOneByNo(int requestNo) {
		Request request = memberMapper.selectOneByNo(requestNo);
		return request;
	}

	@Override
	public Integer selectPrevRequestNo(Map<String, Object> map) {
		return memberMapper.selectPrevRequestNo(map);
	}

	@Override
	public Integer selectNextRequestNo(Map<String, Object> map) {
		return memberMapper.selectNextRequestNo(map);
	}

	@Override
	public int changeRequestStatus(int requestNo) {
		return memberMapper.changeRequestStatus(requestNo);
	}

	@Override
	public int deleteRequest(int requestNo) {
		int result = memberMapper.deleteRequest(requestNo);
		return result;
	}

	@Override
	public int updateQuestion(Request request) {
		return memberMapper.updateRequest(request);
	}

    @Override
    public int getCount() {
        int result = memberMapper.getCount();
        return result;
    }

    @Override
    public List<LectureNoRequest> findLectureById(String memberId) {
        List<LectureNoRequest> lList = memberMapper.findLectureById(memberId);
        return lList;
    }

    @Override
    public int updateMemberInfo(Member member) {
        return memberMapper.updateMemberInfo(member);
    }

    @Override
    public MemberStatsRequest getMemberStats(String memberId) {
        return memberMapper.getMemberStats(memberId);
    }

    @Override
    public List<MyPostRequest> getMyPosts(String memberId) {
        return memberMapper.getMyPosts(memberId);
    }

    @Override
    public List<MyPostRequest> getMyPostsWithSearch(Map<String, Object> searchMap) {
        int currentPage = (int) searchMap.get("currentPage");
        int boardLimit = (int) searchMap.get("boardLimit");
        int offset = (currentPage - 1) * boardLimit;
        RowBounds rowBounds = new RowBounds(offset, boardLimit);
        return memberMapper.getMyPostsWithSearch(searchMap, rowBounds);
    }

    @Override
    public int getMyPostsTotalCount(Map<String, Object> searchMap) {
        return memberMapper.getMyPostsTotalCount(searchMap);
    }

    @Override
    public List<MyCommentRequest> getMyComments(String memberId) {
        return memberMapper.getMyComments(memberId);
    }

    @Override
    public List<MyCommentRequest> getMyCommentsWithSearch(Map<String, Object> searchMap) {
        int currentPage = (int) searchMap.get("currentPage");
        int boardLimit = (int) searchMap.get("boardLimit");
        int offset = (currentPage - 1) * boardLimit;
        RowBounds rowBounds = new RowBounds(offset, boardLimit);
        return memberMapper.getMyCommentsWithSearch(searchMap, rowBounds);
    }

    @Override
    public int getMyCommentsTotalCount(Map<String, Object> searchMap) {
        return memberMapper.getMyCommentsTotalCount(searchMap);
    }

    @Override
    public List<Lecture> findTeacherLecture(String memberId) {
        List<Lecture> lList = memberMapper.findTeacherLecture(memberId);
        return lList;
    }

}
