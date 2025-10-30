<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>공�??��?�� ?��?��</title>
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
        공�??��?�� ?��?��
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/notice/noticeIcon.png" alt="공�??��?�� ?��?���?">
        </div>
	</section>
		<section class="notice-write">
			<h2>공�??��?�� ?��?��</h2>

			<!-- ?���? -->
			
			<form class="form-actions" action="/notice/insert" method="post">
			<div class="form-group">
				<label for="title">?���?</label> 
				<input type="text" id="title"
					placeholder="?��목을 ?��?��?��주세?��." 
						name="noticeTitle" required="required"/>
			</div>

			<!-- 본문 -->
			<div class="form-group">
				<label for="content">본문</label>
				<textarea id="content" rows="10" 
					placeholder="?��?��?�� ?��?��?��주세?��." 
						name="noticeContent" required="required"></textarea>
			</div>

			<!-- ?��?�� 버튼 -->
				<button type="submit" class="submit-btn">�??���?</button>
			</form>
		</section>
	</main>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
