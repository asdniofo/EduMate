package com.edumate.boot.app.lecture.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class VideoDetailRequest {
    private int videoNo;
    private int lectureNo;
    private String videoTitle;
    private int videoOrder;
    private String videoPath;
    private String videoYn;

}
