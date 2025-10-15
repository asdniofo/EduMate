package com.edumate.boot.domain.member.model.service.impl;

import com.edumate.boot.domain.member.model.service.MemberService;
import com.edumate.boot.app.member.dto.InsertQuestionRequest;
import com.edumate.boot.domain.member.model.mapper.MemberMapper;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final MemberMapper memberMapper;
    
    public int insertQuestion(InsertQuestionRequest question) {
    	int result = memberMapper.insertQuestion(question); 
		return result;
    }

}
