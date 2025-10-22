package com.edumate.boot.domain.event.model.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class Event {
	private String 		eventId;
	private String 		memberId;
	private String 		eventTitle;
	private String 		eventPath;
	private Timestamp 	writeDate;
	private int			viewCount;
	private String		boardYn;
}
