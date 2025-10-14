package com.edumate.boot.domain.lecture.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class Lecture {
    private int lectureNo;
    private int teacherNo;
    private String teacherName;
    private String lectureName;
    private int lecturePrice;
    private String lectureCategory;
    private String lecturePath;
}
