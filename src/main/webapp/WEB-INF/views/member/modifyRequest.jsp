<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>건의사항 수정</title>
        <link rel="stylesheet" href="/resources/css/member/insertQuestion.css" />
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
    </head>
    <body>
        <jsp:include page="../common/header.jsp" />
        <div class="main-container">
            <!-- 상단 영역 -->
            <div class="header-section">
                <div class="title">건의사항 수정</div>
                <img src="/resources/images/request/requestIcon.png"
				alt="공지 아이콘" class="hero-image" />
            </div>

            <!-- 질문 등록 폼 -->
            <form action="/member/request/modify" method="post" enctype="application/x-www-form-urlencoded">
                <div class="form-container">
                    <div class="form-wrapper">
                    <input type="hidden" name="requestNo" value="${request.requestNo}"/>
                        <!-- 질문 제목 -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">질문 제목</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                value="${request.requestTitle}"
                                name="requestTitle"/>
                        </div>

                        <!-- 질문 내용 -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">질문 내용</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                name="requestContent">${request.requestContent}</textarea>
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
