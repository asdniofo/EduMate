package com.edumate.boot.domain.member.model.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.edumate.boot.app.member.dto.AddRequestCommentRequest;
import com.edumate.boot.domain.member.model.vo.RequestComment;

@Mapper
public interface RequestCommentMapper {

	List<RequestComment> selectRcList(int rNo);

	int insertRequestComment(AddRequestCommentRequest requestComment);

	int deleteComment(int requestCommentNo);

}
