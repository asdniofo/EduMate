package com.edumate.boot.app.teacher.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QuestionCommentAddRequest {
	private String questionCommentContent;
	private String memberId;
	private int questionNo;
}
