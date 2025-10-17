package com.edumate.boot.domain.teacher.model.service;

import java.util.List;

import com.edumate.boot.app.teacher.dto.QuestionCommentAddRequest;
import com.edumate.boot.domain.teacher.model.vo.QuestionComment;

public interface QuestionCommentService {

	List<QuestionComment> selectQcList(int qNo);

	int insertQuestionCommnet(QuestionCommentAddRequest questionComment);

	int deleteComment(int questionCommentNo);

}
