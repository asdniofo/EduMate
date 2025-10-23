package com.edumate.boot.app.member.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberStatsRequest {
    private int requestCount;        // REQUEST 테이블에서 사용자가 작성한 건의사항 수
    private int requestCommentCount; // REQUEST_COMMENT 테이블에서 사용자가 작성한 댓글 수
    private int questionCount;       // QUESTION 테이블에서 사용자가 작성한 질문 수
    private int questionCommentCount; // QUESTION_COMMENT 테이블에서 사용자가 작성한 댓글 수
}