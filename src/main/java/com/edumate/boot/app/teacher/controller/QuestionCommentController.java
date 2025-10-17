package com.edumate.boot.app.teacher.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.edumate.boot.app.teacher.dto.QuestionCommentAddRequest;
import com.edumate.boot.domain.teacher.model.service.QuestionCommentService;
import com.edumate.boot.domain.teacher.model.vo.QuestionComment;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/question/comment")
@RequiredArgsConstructor
public class QuestionCommentController {
	
	private final QuestionCommentService qcService;
	
	@GetMapping("/list")
	public List<QuestionComment> selectQcList(@RequestParam("questionNo") int qNo) {
		List<QuestionComment> qcList = qcService.selectQcList(qNo);
		return qcList;
	}
	
	@PostMapping("/add")
	public int insertComment(@RequestBody QuestionCommentAddRequest questionComment) {
		try {
			int result = qcService.insertQuestionCommnet(questionComment);
			System.out.println(questionComment);
			return result;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return -1;
		}
	}
	
}
