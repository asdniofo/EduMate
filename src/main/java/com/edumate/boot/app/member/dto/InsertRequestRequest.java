package com.edumate.boot.app.member.dto;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InsertRequestRequest {
	private String memberId;
	private String requestTitle;
	private String requestContent;
	private Timestamp writeDate;
}
