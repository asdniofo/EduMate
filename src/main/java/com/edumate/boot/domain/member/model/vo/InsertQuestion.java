package com.edumate.boot.domain.member.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class InsertQuestion {
	int questionNo;
	String memberId;
	String questionTitle;
	String questionContent;
	Timestamp writeDate;
	String questionStatus;
	String questionYn;
}
