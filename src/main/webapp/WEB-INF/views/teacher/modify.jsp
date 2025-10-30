<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>ì§ˆë¬¸ ?ˆ˜? •</title>
        <link rel="stylesheet" href="/resources/css/member/insertQuestion.css" />
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
    </head>
    <body>
          	<jsp:include page="../common/header.jsp" />
	<!-- ë©”ì¸ ë°°ë„ˆ -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ê³µì??‚¬?•­
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png" alt="ì§ˆë¬¸ ê²Œì‹œ?Œ ?•„?´ì½?">
        </div>
	</section>
        <div class="main-container">
            <!-- ?ƒ?‹¨ ?˜?—­ -->
            <div class="header-section">
                <div class="title">ì§ˆë¬¸ ?ˆ˜? •</div>
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png"
				alt="ì§ˆë¬¸ ?•„?´ì½?" class="hero-image" />
            </div>

            <!-- ì§ˆë¬¸ ?“±ë¡? ?¼ -->
            <form action="/teacher/question/modify" method="post" enctype="application/x-www-form-urlencoded">
                <div class="form-container">
                    <div class="form-wrapper">
                    <input type="hidden" name="questionNo" value="${question.questionNo}"/>
                        <!-- ì§ˆë¬¸ ? œëª? -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">ì§ˆë¬¸ ? œëª?</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                value="${question.questionTitle}"
                                name="questionTitle"/>
                        </div>

                        <!-- ì§ˆë¬¸ ?‚´?š© -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">ì§ˆë¬¸ ?‚´?š©</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                name="questionContent">${question.questionContent}</textarea>
                        </div>

                        <!-- ? œì¶? ë²„íŠ¼ -->
                        <button class="submit-button">?“±ë¡?</button>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>
</html>
