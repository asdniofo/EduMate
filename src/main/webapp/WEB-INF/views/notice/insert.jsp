<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ê³µì??‚¬?•­ ?ž‘?„±</title>
<link rel="stylesheet" href="/resources/css/notice/insert.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
	<jsp:include page="../common/header.jsp" />
	<!-- ë©”ì¸ ë°°ë„ˆ -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ê³µì??‚¬?•­ ?ž‘?„±
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/notice/noticeIcon.png" alt="ê³µì??‚¬?•­ ?•„?´ì½?">
        </div>
	</section>
		<section class="notice-write">
			<h2>ê³µì??‚¬?•­ ?ž‘?„±</h2>

			<!-- ? œëª? -->
			
			<form class="form-actions" action="/notice/insert" method="post">
			<div class="form-group">
				<label for="title">? œëª?</label> 
				<input type="text" id="title"
					placeholder="? œëª©ì„ ?ž…? ¥?•´ì£¼ì„¸?š”." 
						name="noticeTitle" required="required"/>
			</div>

			<!-- ë³¸ë¬¸ -->
			<div class="form-group">
				<label for="content">ë³¸ë¬¸</label>
				<textarea id="content" rows="10" 
					placeholder="?‚´?š©?„ ?ž…? ¥?•´ì£¼ì„¸?š”." 
						name="noticeContent" required="required"></textarea>
			</div>

			<!-- ?ž‘?„± ë²„íŠ¼ -->
				<button type="submit" class="submit-btn">ê¸??“°ê¸?</button>
			</form>
		</section>
	</main>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
