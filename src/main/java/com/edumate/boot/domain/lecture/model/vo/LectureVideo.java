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
public class LectureVideo {
    private int videoNo;
    private int lectureNo;
    private String videoTitle;
    private int videoOrder;
    private int videoTime;
    private String videoPath;
    private String videoYn;
}
