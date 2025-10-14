package com.edumate.boot.app.lecture.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import java.sql.Timestamp;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class ReviewListRequest {
    private int lectureNo;
    private String memberId;
    private String memberName;
    private double reviewRating;
    private String reviewContent;
    private String reviewYn;
    private Timestamp reviewDate;
}
