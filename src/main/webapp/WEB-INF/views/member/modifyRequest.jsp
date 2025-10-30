<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Í±¥Ïùò?Ç¨?ï≠ ?àò?†ï</title>
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
                    Í±¥Ïùò?Ç¨?ï≠ ?àò?†ï
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/request/requestIcon.png" alt="Í±¥Ïùò?Ç¨?ï≠ ?ïÑ?ù¥ÏΩ?">
                </div>
            </section>

            <!-- ÏßàÎ¨∏ ?ì±Î°? ?èº -->
            <form action="/member/request/modify" method="post" enctype="application/x-www-form-urlencoded">
                <div class="form-container">
                    <div class="form-wrapper">
                    <input type="hidden" name="requestNo" value="${request.requestNo}"/>
                        <!-- ÏßàÎ¨∏ ?†úÎ™? -->
                        <div class="input-section">
                            <label for="question-title" class="input-label">ÏßàÎ¨∏ ?†úÎ™?</label>
                            <input
                                type="text"
                                id="question-title"
                                class="input-field"
                                value="${request.requestTitle}"
                                name="requestTitle"/>
                        </div>

                        <!-- ÏßàÎ¨∏ ?Ç¥?ö© -->
                        <div class="input-section">
                            <label for="question-content" class="input-label">ÏßàÎ¨∏ ?Ç¥?ö©</label>
                            <textarea
                                id="question-content"
                                class="input-field"
                                name="requestContent">${request.requestContent}</textarea>
                        </div>

                        <!-- ?†úÏ∂? Î≤ÑÌäº -->
                        <button class="submit-button">?ì±Î°?</button>
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../common/footer.jsp" />
    </body>
</html>
