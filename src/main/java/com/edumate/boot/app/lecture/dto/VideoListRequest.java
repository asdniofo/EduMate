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
public class VideoListRequest {
    private int videoNo;
    private int lectureNo;
    private String videoTitle;
    private int videoOrder;
    private int videoTime;
    private String time;
    private String videoPath;
    private String videoYn;

    public String getTime() {
        StringBuilder timeFormatted = new StringBuilder();
        int hour = videoTime / 3600;
        int minute = (videoTime % 3600) / 60;
        int second = videoTime % 60;
        if (hour > 0) timeFormatted.append(hour).append(":");
        timeFormatted.append(String.format("%02d:%02d", minute, second));
        return timeFormatted.toString();
    }
}
