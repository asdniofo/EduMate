package com.edumate.boot.domain.teacher.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.app.teacher.dto.QuestionCommentAddRequest;
import com.edumate.boot.domain.teacher.model.vo.QuestionComment;

@Mapper
public interface QuestionCommentMapper {

	List<QuestionComment> selectQcList(int qNo);

	int insertQuestionCommnet(QuestionCommentAddRequest questionComment);

}
