package com.edumate.boot.domain.member.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Member {
	private String 	memberId;
	private String 	memberPw;
	private String 	memberEmail;
	private String 	memberBirth;
	private int 	memberMoney;
	private String 	lectureYN;
	private String 	adminYN;
	
}
