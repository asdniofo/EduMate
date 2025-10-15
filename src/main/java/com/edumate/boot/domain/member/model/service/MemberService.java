package com.edumate.boot.domain.member.model.service;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;

public interface MemberService {

	int insertQuestion(InsertQuestionRequest question);

}
