package com.edumate.boot.domain.member.model.service.impl;

import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.domain.member.model.vo.Member;
import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.mapper.MemberMapper;

import java.util.HashMap;
import java.util.Map;

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

}