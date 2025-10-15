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
public class LectureListRequest {
    private int lectureNo;
    private String memberId;
    private String memberName;
    private String lectureName;
    private double lectureRating;
    private int countReview;
    private int countStudent;
    private int lecturePrice;
    private String lectureCategory;
    private String lecturePath;
    private String lectureContent;
    private String lectureYn;
    private Timestamp lectureCreatedDate;
}

