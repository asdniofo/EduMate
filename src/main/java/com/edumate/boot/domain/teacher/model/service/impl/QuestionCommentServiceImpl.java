package com.edumate.boot.domain.teacher.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.edumate.boot.app.teacher.dto.QuestionCommentAddRequest;
import com.edumate.boot.domain.teacher.model.mapper.QuestionCommentMapper;
import com.edumate.boot.domain.teacher.model.service.QuestionCommentService;
import com.edumate.boot.domain.teacher.model.vo.QuestionComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class QuestionCommentServiceImpl implements QuestionCommentService {
	
	private final QuestionCommentMapper qcMapper;
	
	@Override
	public List<QuestionComment> selectQcList(int qNo) {
		List<QuestionComment> qcList = qcMapper.selectQcList(qNo);
		return qcList;
	}

	@Override
	public int insertQuestionCommnet(QuestionCommentAddRequest questionComment) {
		int result = qcMapper.insertQuestionCommnet(questionComment);
		return result;
	}

	@Override
	public int deleteComment(int questionCommentNo) {
		int result = qcMapper.deleteComment(questionCommentNo);
		return result;
	}
	
}
