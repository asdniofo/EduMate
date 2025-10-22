package com.edumate.boot.domain.member.model.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.edumate.boot.domain.member.model.mapper.RequestCommentMapper;
import com.edumate.boot.domain.member.model.service.RequestCommentService;
import com.edumate.boot.domain.member.model.vo.RequestComment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RequestCommentServiceImpl implements RequestCommentService{
	
	private final RequestCommentMapper rcMapper;
	
	@Override
	public List<RequestComment> selectRcList(int rNo) {
		List<RequestComment> rcList = rcMapper.selectRcList(rNo);
		return rcList;
	}

}
