package com.edumate.boot.domain.teacher.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	int questionNo;
	String memberId;
	String questionTitle;
	String questionContent;
	Timestamp writeDate;
	String questionStatus;
	String questionYn;
}
