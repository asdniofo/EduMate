package com.edumate.boot.app.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MyCommentRequest {
    private int commentNo;           // 댓글 번호
    private String commentType;      // "REQUEST" 또는 "QUESTION"
    private String commentContent;   // 댓글 내용
    private Date writeDate;          // 댓글 작성일
    private String memberId;         // 작성자 ID
    private String status;           // 댓글 상태
    
    // 원글 정보
    private int parentPostNo;        // 원글 번호
    private String parentPostTitle;  // 원글 제목
    private String parentPostType;   // 원글 타입 (REQUEST/QUESTION)
}