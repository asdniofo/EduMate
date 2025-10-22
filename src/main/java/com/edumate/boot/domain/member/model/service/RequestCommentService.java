package com.edumate.boot.domain.member.model.service;

import java.util.List;

import com.edumate.boot.domain.member.model.vo.RequestComment;

public interface RequestCommentService {

	List<RequestComment> selectRcList(int rNo);

}
