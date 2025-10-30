<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>질문 ?��?��</title>
        <link rel="stylesheet" href="/resources/css/member/insertQuestion.css" />
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
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
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png" alt="질문 게시?�� ?��?���?">
        </div>
	</section>
        <div class="main-container">
            <!-- ?��?�� ?��?�� -->
            <div class="header-section">
                <div class="title">질문 ?��?��</div>
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png"
				alt="질문 ?��?���?" class="hero-image" />
            </div>

            <!-- 질문 ?���? ?�� -->
            <form action="/teacher/question/modify" method="post" enctype="application/x-www-form-urlencoded">
                <div class="form-container">
                    <div class="form-wrapper">
                    <input type="hidden" name="questionNo" value="${question.questionNo}"/>
                        <!-- 질문 ?���? -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">질문 ?���?</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                value="${question.questionTitle}"
                                name="questionTitle"/>
                        </div>

                        <!-- 질문 ?��?�� -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">질문 ?��?��</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                name="questionContent">${question.questionContent}</textarea>
                        </div>

                        <!-- ?���? 버튼 -->
                        <button class="submit-button">?���?</button>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>
</html>
