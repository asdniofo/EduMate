<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>공지사항 상세</title>
<link rel="stylesheet" href="/resources/css/notice/detail.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- ===== 메인 ===== -->
	<main>
		<section class="notice-banner">
			<h1>공지사항</h1>
			<img src="notice-img.png" alt="공지 아이콘" />
		</section>

		<section class="notice-detail">
			<div class="notice-header">
				<div class="notice-path">공지사항 &gt; ${notice.noticeTitle }</div>
				<div class="notice-meta">
					<span><fmt:formatDate value="${notice.writeDate}"
							pattern="yyyy-MM-dd HH:mm" /></span> 
							<span style="margin-left:20px">조회수 ${notice.viewCount}</span>
				</div>
			</div>

			<div class="notice-content">
				<p>${notice.noticeContent }</p>
			</div>

			<div class="notice-buttons">
				<div class="notice-buttons-left">
					<button class="edit-btn">수정</button>
					<button class="delete-btn">삭제</button>
				</div>
				<div class="notice-buttons-right">
				<c:if test="${not empty prevNoticeNo}">
					<button class="prev-btn" onclick="location.href='detail?noticeId=${prevNoticeNo}'">이전</button>
				</c:if>
				<c:if test="${not empty nextNoticeNo}">
					<button class="next-btn" onclick="location.href='detail?noticeId=${nextNoticeNo}'">다음</button>
				</c:if>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
