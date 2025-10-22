package com.edumate.boot.app.member.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AddRequestCommentRequest {
	private String requestCommentContent;
	private String memberId;
	private int requestNo;
}
