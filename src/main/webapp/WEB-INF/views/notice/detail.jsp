<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<!-- ===== 메인 ===== -->
	<main>
		<section class="notice-banner">
			<h1>공지사항</h1>
			<img src="notice-img.png" alt="공지 아이콘" />
		</section>

		<section class="notice-detail">
			<div class="notice-header">
				<div class="notice-path">공지사항 &gt; 공지사항 첫번째 공지사항</div>
				<div class="notice-meta">
					<span>2025.10.02</span> <span>조회수 0</span>
				</div>
			</div>

			<div class="notice-content">
				<p>
					안녕하세요. KH정보교육원입니다.<br /> <br /> 쾌적하고 청결한 교육 환경을 위해 2025년 6월 1일부터
					기간 내에서 배달음식 주문 및 섭취를 금합니다.<br /> <br /> 그동안 음식을 인한 불편에 대한 여러 의견이
					꾸준히 접수되어 왔으며, 다음과 같은 문제들이 발생함에 따라 이와 같은 결정을 내리게 되었습니다.<br /> <br />
					- 음식물 쓰레기로 인한 위생 문제<br /> - 음식 냄새로 인한 학습 방해<br /> - 주변 청결도 저하 등<br />
					<br /> 이러한 문제를 예방하고 보다 쾌적한 환경을 만들기 위해 여러분의 협조 부탁드립니다.
				</p>

				<div class="notice-file">
					<strong>첨부파일:</strong> <a href="#">훈련기관의 의무 공지.pdf</a>
				</div>
			</div>

			<div class="notice-buttons">
				<div class="notice-buttons-left">
					<button class="edit-btn">수정</button>
					<button class="delete-btn">삭제</button>
				</div>
				<div class="notice-buttons-right">
					<button class="prev-btn">이전</button>
					<button class="next-btn">다음</button>
				</div>
			</div>
		</section>
	</main>
	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
