<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>?���? ?���?</title>
        <link rel="stylesheet" href="/resources/css/member/insertQuestion.css" />
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
        <link rel="stylesheet" href="/resources/css/common/main_banner.css">
    </head>
    <body>
        <jsp:include page="../common/header.jsp" />
        <div class="main-container">
            <section class="main-banner">
                <div class="banner-text">
                    ?���? ?���?
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/request/requestIcon.png" alt="?���? ?���? ?��?���?">
                </div>
            </section>

            <!-- 질문 ?���? ?�� -->
            <form action="/member/request/insert" method="post">
                <div class="form-container">
                    <div class="form-wrapper">
                        <!-- 질문 ?���? -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">?���? ?���?</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                placeholder="?��목을 ?��?��?��주세?��." 
                                name="requestTitle"/>
                        </div>

                        <!-- 질문 ?��?�� -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">?���? ?��?��</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                placeholder="질문?�� ?��?��?��주세?��"
                                name="requestContent"></textarea>
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
