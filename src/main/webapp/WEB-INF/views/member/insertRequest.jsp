<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>?š”ì²? ?“±ë¡?</title>
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
                    ?š”ì²? ?“±ë¡?
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/request/requestIcon.png" alt="?š”ì²? ?“±ë¡? ?•„?´ì½?">
                </div>
            </section>

            <!-- ì§ˆë¬¸ ?“±ë¡? ?¼ -->
            <form action="/member/request/insert" method="post">
                <div class="form-container">
                    <div class="form-wrapper">
                        <!-- ì§ˆë¬¸ ? œëª? -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">?š”ì²? ? œëª?</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                placeholder="? œëª©ì„ ?ž…? ¥?•´ì£¼ì„¸?š”." 
                                name="requestTitle"/>
                        </div>

                        <!-- ì§ˆë¬¸ ?‚´?š© -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">?š”ì²? ?‚´?š©</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                placeholder="ì§ˆë¬¸?„ ?ž…? ¥?•´ì£¼ì„¸?š”"
                                name="requestContent"></textarea>
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
