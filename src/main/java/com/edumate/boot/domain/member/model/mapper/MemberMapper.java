package com.edumate.boot.domain.member.model.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.app.member.dto.InsertQuestionRequest;

@Mapper
public interface MemberMapper {

	int insertQuestion(InsertQuestionRequest question);

}
