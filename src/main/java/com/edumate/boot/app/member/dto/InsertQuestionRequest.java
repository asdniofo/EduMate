package com.edumate.boot.app.member.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InsertQuestionRequest {
	private String memberId;
	private String questionTitle;
	private String questionContent;
	private Timestamp writeDate;
}
