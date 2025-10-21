package com.edumate.boot.domain.member.model.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Request {
	private int requestNo;
	private String memberId;
	private String requestTitle;
	private String requestContent;
	private Timestamp writeDate;
	private String requestStatus;
	private String requestYn;
}
