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
        ê³µì??‚¬?•­ ?ˆ˜? •
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/notice/noticeIcon.png" alt="ê³µì??‚¬?•­ ?•„?´ì½?">
        </div>
	</section>
			<form class="form-actions" action="/notice/update" method="post">
			<!-- ? œëª? -->
			<div class="form-group">
			    <input type="hidden" name="noticeId" value="${notice.noticeId}">
				<label for="title">? œëª?</label> 
				<input type="text" id="title"
					placeholder="? œëª©ì„ ?ž…? ¥?•´ì£¼ì„¸?š”." name="noticeTitle"
						value="${notice.noticeTitle }"/>
			</div>

			<!-- ë³¸ë¬¸ -->
			<div class="form-group">
				<label for="content">ë³¸ë¬¸</label>
				<textarea id="content" rows="10" 
					placeholder="?‚´?š©?„ ?ž…? ¥?•´ì£¼ì„¸?š”." name="noticeContent">${notice.noticeContent }</textarea>
			</div>

			<!-- ?ž‘?„± ë²„íŠ¼ -->

				<button type="submit" class="submit-btn">?ˆ˜? •?•˜ê¸?</button>
			</form>
		</section>
	</main>
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
