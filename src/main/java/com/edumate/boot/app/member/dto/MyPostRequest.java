package com.edumate.boot.app.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MyPostRequest {
    private int postNo;          // REQUEST_NO 또는 QUESTION_NO
    private String postType;     // "REQUEST" 또는 "QUESTION"
    private String postTitle;    // REQUEST_TITLE 또는 QUESTION_TITLE
    private String postContent;  // REQUEST_CONTENT 또는 QUESTION_CONTENT
    private Date writeDate;      // WRITE_DATE
    private String memberId;     // MEMBER_ID
    private String status;       // REQUEST_STATUS 또는 QUESTION_STATUS (있는 경우)
}