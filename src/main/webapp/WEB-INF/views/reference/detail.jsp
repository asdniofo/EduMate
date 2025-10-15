<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료 상세조회</title>
<link rel="stylesheet" href="../resources/css/notice/detail.css">
</head>
<body>
	<div class="container">
		<c:choose>
			<c:when test="${empty reference}">
				<div class="content-wrapper no-data">
					<p>요청한 자료를 찾을 수 없습니다.</p>
					<a href="/reference/list" class="btn btn-secondary" style="margin-top: 20px;">목록으로 돌아가기</a>
				</div>
			</c:when>
			<c:otherwise>
				<!-- Header -->
				<div class="header">
					<div style="margin-bottom: 10px;">
						<span class="category-badge">${reference.referenceCategory}</span>
					</div>
					<h1>${reference.referenceTitle}</h1>
					<div class="header-info">
						<div class="header-meta">
							<span>작성자: <strong>${reference.referenceWriter}</strong></span>
							<span>작성일: <strong><fmt:formatDate value="${reference.referenceDate}" pattern="yyyy.MM.dd HH:mm"/></strong></span>
							<span>조회수: <strong>${reference.referenceViewCount}</strong></span>
						</div>
						<c:if test="${not empty reference.referenceModifyDate}">
							<span style="color: #999999;">수정일: <fmt:formatDate value="${reference.referenceModifyDate}" pattern="yyyy.MM.dd HH:mm"/></span>
						</c:if>
					</div>
				</div>

				<!-- Content -->
				<div class="content-wrapper">
					<h2>내용</h2>
					<div class="content-body">
						${reference.referenceContent}
					</div>

					<!-- Attachment -->
					<c:if test="${not empty reference.attachmentName}">
						<div class="attachment-section">
							<h3>첨부파일</h3>
							<div class="attachment-item">
								<a href="${reference.attachmentPath}" download>
									📎 ${reference.attachmentName}
								</a>
							</div>
						</div>
					</c:if>

					<!-- Action Buttons -->
					<div class="action-buttons">
						<a href="/reference/list" class="btn btn-secondary">목록</a>
						<a href="/reference/modify?referenceNo=${reference.referenceNo}" class="btn btn-primary">수정</a>
						<a href="/reference/delete?referenceNo=${reference.referenceNo}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>