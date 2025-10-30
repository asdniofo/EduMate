<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>공�??��?�� ?��?��</title>
<link rel="stylesheet" href="/resources/css/notice/detail.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- 메인 배너 -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        공�??��?��
    </div>
    <div class="object">
        <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/notice/noticeIcon.png" alt="공�??��?�� ?��?���?">
    </div>
	</section>
		<section class="notice-detail">
			<div class="notice-header">
				<div class="notice-path">공�??��?�� &gt; ${notice.noticeTitle }</div>
				<div class="notice-meta">
					<span><fmt:formatDate value="${notice.writeDate}"
							pattern="yyyy-MM-dd HH:mm" /></span> 
							<span style="margin-left:20px">조회?�� ${notice.viewCount}</span>
				</div>
			</div>

			<div class="notice-content">
				<p>${notice.noticeContent }</p>
			</div>

			<div class="notice-buttons">
				<div class="notice-buttons-left">
					<c:if test="${adminYn eq 'Y'}">
						<a href="update?noticeId=${notice.noticeId }" style="text-decoration: none"><button class="edit-btn">?��?��</button></a>
						<a href="javascript:void(0)" onclick="checkDelete();"style="text-decoration: none"><button class="delete-btn">?��?��</button></a>
					</c:if>
				</div>
				<div class="notice-buttons-right">
				<c:if test="${not empty prevNoticeNo}">
					<button class="prev-btn" onclick="location.href='detail?noticeId=${prevNoticeNo}'">?��?��</button>
				</c:if>
				<c:if test="${not empty nextNoticeNo}">
					<button class="next-btn" onclick="location.href='detail?noticeId=${nextNoticeNo}'">?��?��</button>
				</c:if>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="../common/footer.jsp" />
	<script>
		function checkDelete(){
			if(confirm('?��말로 ?��?��?��?��겠습?���??')){
				location.href = '/notice/delete?noticeId=${notice.noticeId}';
			}
		}
	</script>
</body>
</html>
