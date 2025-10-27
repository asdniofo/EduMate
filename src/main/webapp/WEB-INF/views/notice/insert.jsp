<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>공지사항 작성</title>
<link rel="stylesheet" href="/resources/css/notice/insert.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- 메인 배너 -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        공지사항 작성
    </div>
    <div class="object">
        <img src="/resources/images/event/icon/event_icon.png" alt="이벤트 아이콘">
    </div>
	</section>
		<section class="notice-write">
			<h2>공지사항 작성</h2>

			<!-- 제목 -->
			
			<form class="form-actions" action="/notice/insert" method="post">
			<div class="form-group">
				<label for="title">제목</label> 
				<input type="text" id="title"
					placeholder="제목을 입력해주세요." 
						name="noticeTitle" required="required"/>
			</div>

			<!-- 본문 -->
			<div class="form-group">
				<label for="content">본문</label>
				<textarea id="content" rows="10" 
					placeholder="내용을 입력해주세요." 
						name="noticeContent" required="required"></textarea>
			</div>

			<!-- 작성 버튼 -->
				<button type="submit" class="submit-btn">글쓰기</button>
			</form>
		</section>
	</main>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
