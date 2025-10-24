package com.edumate.boot.domain.event.model.vo;

import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import java.sql.Timestamp;
import java.util.Date;

@Data
public class Event {
    private int eventId;
    private String eventTitle;
    private String eventSubtitle;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date eventStart;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date eventEnd;
    
    private String eventPath;     // main image path
    private String eventSubpath;  // thumbnail path (list)
    private String eventYn;
    private String boardYn;
    private Timestamp regDate;

    // 상세 이미지 목록
    private List<EventContent> contents;
}