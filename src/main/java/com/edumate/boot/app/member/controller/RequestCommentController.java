package com.edumate.boot.app.member.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.edumate.boot.domain.member.model.service.RequestCommentService;
import com.edumate.boot.domain.member.model.vo.RequestComment;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/request/comment")
@RequiredArgsConstructor
public class RequestCommentController {
	
	private final RequestCommentService rcService;
	
	@GetMapping("/list")
	public List<RequestComment> selectRcList(@RequestParam("requestNo") int rNo) {
		List<RequestComment> rcList = rcService.selectRcList(rNo);
		return rcList;
	}
}





