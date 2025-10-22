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
    private String lectureAdYn;
    private Timestamp lectureCreatedDate;
    private int totalVideoTime;
    private String time;
    
    public String getTime() {
        StringBuilder timeFormatted = new StringBuilder();
        int hour = totalVideoTime / 3600;
        int minute = (totalVideoTime % 3600) / 60;
        int second = totalVideoTime % 60;
        if (hour > 0) timeFormatted.append("약 ").append(hour).append("시간 ");
        if (minute > 0) timeFormatted.append(minute).append("분");
        if (hour == 0 && minute == 0 && second > 0) timeFormatted.append("약 ").append(second).append("초");
        return timeFormatted.toString().trim();
    }
}

