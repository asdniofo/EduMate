<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>EduMate - 공�? ?��?��</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
<link rel="stylesheet" href="/resources/css/notice/list.css" />
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

	<!-- 메인 콘텐�? -->
	<main class="main-content">
			<div class="search-bar">
		<form action="/notice/search" method="get">
				<input type="text" placeholder="�??��?���? ?��?��?��?��?��" 
				name="searchKeyword" value="${searchKeyword }"/>
			</div>
		</form>

		<section class="question-list">
			<c:forEach items="${searchList }" var="notice" varStatus="i">
				<a href="/notice/detail?noticeId=${notice.noticeId }"
					class="question-link">
					<article class="question-item">
						<div class="question-left">
							<span class="status-tag">공�??��?��</span>
							<h2 class="question-title">${notice.noticeTitle }</h2>
						</div>
					</article> <span class="write-date"><fmt:formatDate
							value="${notice.writeDate}" pattern="yyyy-MM-dd" /></span>
				</a>
			</c:forEach>
		</section>

		<!-- ?��?�� ?��?���??��?��?�� + �??���? 버튼 -->
		<div class="bottom-actions">
			<div class="pagination">
				<c:if test="${startNavi ne 1 }">
						<a href="/notice/search?page=${startNavi-1 }&searchKeyword=${searchKeyword}">
							<button class="page-btn">?��?��</button>
						</a>
				</c:if>
				<c:forEach begin="${startNavi }" end="${endNavi }" var="n">
					<a href="/notice/search?page=${n }&searchKeyword=${searchKeyword}"> 
					<button class="page-btn <c:if test="${currentPage eq n }">active</c:if>">
						${n }
					</button>
					</a>
				</c:forEach>
				<c:if test="${endNavi ne maxPage }">
					<a href="/notice/search?page=${endNavi + 1 }&searchKeyword=${searchKeyword}">
						<button class="page-btn">?��?��</button>
					</a>
				</c:if>
			</div>
			<a href="/notice/insert" class="write-button">�??���?</a>
		</div>
	</main>
	<jsp:include page="../common/footer.jsp" />
</body>
</html>
