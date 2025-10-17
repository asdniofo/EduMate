<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>질문과 답변</title>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
<link rel="stylesheet" href="/resources/css/notice/list.css" />
</head>
<body>
    <jsp:include page="../common/header.jsp" />
	<!-- 히어로 섹션 -->
	<section class="hero-section-wrapper">
		<div class="hero-section">
			<h1 class="hero-title">공지사항</h1>
			<img src="/mnt/data/55c63bbe-ef1e-46ec-b81a-eaf12b7bcb6c.png"
				alt="공지 아이콘" class="hero-image" />
		</div>
	</section>

	<!-- 메인 콘텐츠 -->
	<main class="main-content">
		<!-- 검색창 + 필터 바 (위치 바뀜: 필터 왼쪽, 검색창 오른쪽) -->
		<div class="filter-bar">
			<div class="filter-buttons">
				<button class="filter-btn active">전체</button>
				<button class="filter-btn">공지사항</button>
				<button class="filter-btn urgent">긴급</button>
			</div>
			<div class="search-bar">
				<input type="text" placeholder="검색어를 입력하세요" />
				<button>🔍</button>
			</div>
		</div>

		<section class="question-list">
			<article class="question-item">
				<a href="/notice/detail/1" class="question-link">
					<div class="question-left">
						<span class="status-tag">공지사항</span>
						<h2 class="question-title">사이트 개설 안내</h2>
					</div> <span class="write-date">2025.10.02</span>
				</a>
			</article>

			<article class="question-item">
				<a href="/notice/detail/2" class="question-link">
					<div class="question-left">
						<span class="status-tag urgent">긴급</span>
						<h2 class="question-title">오늘만 가면 10일 쉼</h2>
					</div> <span class="write-date">2025.10.02</span>
				</a>
			</article>
		</section>

		<!-- 하단 페이지네이션 + 글쓰기 버튼 -->
		<div class="bottom-actions">
			<div class="pagination">
				<button class="page-btn">이전</button>
				<button class="page-btn active">1</button>
				<button class="page-btn">2</button>
				<button class="page-btn">3</button>
				<button class="page-btn">4</button>
				<button class="page-btn">5</button>
				<button class="page-btn">다음</button>
			</div>
			<a href="#" class="write-button">글쓰기</a>
		</div>
	</main>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
