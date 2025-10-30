<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ÏßàÎ¨∏Í≥? ?ãµÎ≥?</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
<link rel="stylesheet" href="/resources/css/notice/list.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Î©îÏù∏ Î∞∞ÎÑà -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        Í≥µÏ??Ç¨?ï≠
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/notice/noticeIcon.png" alt="Í≥µÏ??Ç¨?ï≠ ?ïÑ?ù¥ÏΩ?">
        </div>
	</section>
	<div class="main-container">

	<!-- Î©îÏù∏ ÏΩòÌÖêÏ∏? -->
	<main class="main-content">
		<form action="/notice/search" method="get">
			<div class="search-bar">
				<input type="text" placeholder="Í≤??Éâ?ñ¥Î•? ?ûÖ?†•?ïò?Ñ∏?öî" 
				name="searchKeyword" value="${searchKeyword }"/>
			</div>
		</form>

		<section class="question-list">
			<c:forEach items="${nList }" var="notice" varStatus="i">
				<a href="/notice/detail?noticeId=${notice.noticeId }"
					class="question-link">
					<article class="question-item">
						<div class="question-left">
							<span class="status-tag">Í≥µÏ??Ç¨?ï≠</span>
							<h2 class="question-title">${notice.noticeTitle }</h2>
						</div>
					</article> <span class="write-date"><fmt:formatDate
							value="${notice.writeDate}" pattern="yyyy-MM-dd" /></span>
				</a>
			</c:forEach>
		</section>

		<!-- ?ïò?ã® ?éò?ù¥Ïß??Ñ§?ù¥?Öò + Í∏??ì∞Í∏? Î≤ÑÌäº -->
		<div class="bottom-actions">
			<div class="pagination">
				<c:if test="${startNavi ne 1 }">
						<a href="/notice/list?page=${startNavi-1 }">
							<button class="page-btn">?ù¥?†Ñ</button>
						</a>
				</c:if>
				<c:forEach begin="${startNavi }" end="${endNavi }" var="n">
					<a href="/notice/list?page=${n }"> 
					<button class="page-btn <c:if test="${currentPage eq n }">active</c:if>">
						${n }
					</button>
					</a>
				</c:forEach>
				<c:if test="${endNavi ne maxPage }">
					<a href="/notice/list?page=${endNavi + 1 }">
						<button class="page-btn">?ã§?ùå</button>
					</a>
				</c:if>
			</div>
			<a href="/notice/insert" class="write-button">Í∏??ì∞Í∏?</a>
		</div>
	</main>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>
