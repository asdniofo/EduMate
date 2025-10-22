package com.edumate.boot.domain.event.model.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class Event {
    private int eventId;
    private String eventTitle;
    private String eventSubtitle;
    private Date eventStart;
    private Date eventEnd;
    private String eventPath;
    private String eventSubpath;
    private String eventYn;
    private String boardYn;
    private Date regDate;
}