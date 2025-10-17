package com.edumate.boot.domain.notice.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Notice {
	private int noticeId;
	private String memberId;
	private String noticeTitle;
	private String noticeCotent;
	private Timestamp writeDate;
	private int viewCount;
	private String boardYn;
}
