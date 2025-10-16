package com.edumate.boot.domain.reference.model.vo;

import java.util.Date;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reference {
	
	private int archiveNo;              // 자료 번호
	private String memberId;           // 작성자 ID
	private String archiveTitle;       // 자료 제목
	private String archiveContent;     // 자료 내용
	private String archiveType;		   // 자료 카테고리
	private Date writeDate;            // 작성일
	private int viewCount;             // 조회수
	private String attachmentName;     // 첨부파일명 (원본명)
	private String attachmentRename;   // 첨부파일명 (변경명)
	private String attachmentPath;     // 첨부파일 경로
	private Date attachmentDate;       // 첨부파일 업로드 날짜
	private String boardYn;            // 게시 여부 (Y: 공개, N: 비공개)
	
}