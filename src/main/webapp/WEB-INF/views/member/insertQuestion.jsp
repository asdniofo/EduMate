<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>질문 등록</title>
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
                    질문 등록
                </div>
                <div class="object">
                    <img src="/resources/images/teacher/QnAIcon.png" alt="질문 등록 아이콘">
                </div>
            </section>

            <!-- 질문 등록 폼 -->
            <form action="/member/insertQuestion" method="post">
                <div class="form-container">
                    <div class="form-wrapper">
                        <!-- 질문 제목 -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">질문 제목</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                placeholder="제목을 입력해주세요." 
                                name="questionTitle"/>
                        </div>

                        <!-- 질문 내용 -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">질문 내용</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                placeholder="질문을 입력해주세요"
                                name="questionContent"></textarea>
                        </div>

                        <!-- 제출 버튼 -->
                        <button class="submit-button">등록</button>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>
</html>
