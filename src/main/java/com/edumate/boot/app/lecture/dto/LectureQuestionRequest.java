package com.edumate.boot.app.lecture.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class LectureQuestionRequest {
    private String memberId;
    private String questionTitle;
    private String questionContent;
}
