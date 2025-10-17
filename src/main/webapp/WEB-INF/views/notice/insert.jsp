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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<main>
		<section class="notice-banner">
			<h1>공지사항</h1>
			<img src="notice-img.png" alt="공지 아이콘" />
		</section>
		<section class="notice-write">
			<h2>공지사항 작성</h2>

			<!-- 제목 -->
			<div class="form-group">
				<label for="title">제목</label> <input type="text" id="title"
					placeholder="제목을 입력해주세요." />
			</div>

			<!-- 유형 -->
			<div class="form-group">
				<label>유형</label>
				<div class="type-buttons">
					<button type="button" class="type-btn active">공지사항</button>
					<button type="button" class="type-btn urgent">긴급</button>
				</div>
			</div>

			<!-- 본문 -->
			<div class="form-group">
				<label for="content">본문</label>
				<textarea id="content" rows="10" placeholder="내용을 입력해주세요."></textarea>
			</div>

			<!-- 첨부파일 -->
			<div class="form-group file-group">
				<label for="file">첨부파일</label> <input type="file" id="file" />
			</div>

			<!-- 작성 버튼 -->
			<form class="form-actions">
				<button type="submit" class="submit-btn">글쓰기</button>
			</form>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
