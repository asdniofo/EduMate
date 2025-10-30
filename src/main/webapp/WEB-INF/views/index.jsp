<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Edumate 메인</title>
    </head>
    <link rel="stylesheet" href="/resources/css/main/index.css">
    <link rel="stylesheet" href="/resources/css/common/header.css"/>
    <link rel="stylesheet" href="/resources/css/common/footer.css"/>
    <script src="/resources/js/main/index.js"></script>
    <body>
        <jsp:include page="common/header.jsp"/>
        <!-- 메인 배너 -->
        <section class="main-banner">
            <div class="banner-text">
                AI?? ?��께하?�� 최상�? 공�?<br/>
                ?��?�� ?��?��?��?��, ?��?��?�� ?��?��?�� ?��?��?��?��?��.
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/adv/gemini.png" alt="Gemini AI">
            </div>
        </section>

        <!-- 광고 ?��?�� -->
        <section class="ads-section">
            <div class="ads-wrapper">
                <div class="ads-viewport" id="adsViewport">
                    <div class="ads-track" id="adsTrack">
                        <c:forEach items="${adEvents}" var="event" varStatus="i">
                            <div class="ad-box"
                                 style="background: url('${event.eventPath}') center/cover no-repeat;"
                                 onclick="location.href='/event/detail?eventId=${event.eventId}'">
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="ads-controls" id="adsControls">
                    <button id="prevBtn">??</button>
                    <button id="pauseBtn">?��</button>
                    <button id="nextBtn">?��</button>
                </div>
            </div>
        </section>
        <!-- ?���? 강의 -->
        <section class="lecture-section">
            <h2>?���? 강의</h2>
            <div class="lecture-grid">
                <c:forEach items="${pList }" var="popular" varStatus="i">
                    <div class="lecture-card" onclick="location.href='/lecture/details?lectureNo=${popular.lectureNo}'">
                        <img class="lecture-img" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/lecture/${popular.lecturePath}"></img>
                        <div class="lecture-info">
                            <p><b>${popular.lectureName }</b></p>
                            <p>${popular.time}</p>
                            <p>?�� <fmt:formatNumber value="${popular.lecturePrice}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- 최근 ?��?��?�� 강의 -->
        <section class="lecture-section">
            <h2>최근 ?��?��?�� 강의</h2>
            <div class="lecture-grid">
                <c:forEach items="${rList }" var="recent" varStatus="i">
                    <div class="lecture-card" onclick="location.href='/lecture/details?lectureNo=${recent.lectureNo}'">
                        <img class="lecture-img" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/lecture/${recent.lecturePath}"></img>
                        <div class="lecture-info">
                            <p><b>${recent.lectureName }</b></p>
                            <p>${recent.time}</p>
                            <p>?�� <fmt:formatNumber value="${recent.lecturePrice}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- 공�??��?�� / ?��?��게시?�� -->
        <section class="board-section">
            <div class="board">
                <h3><a href="/notice/list">공�??��?��</a></h3>
                <ul>
                    <c:forEach items="${nList }" var="notice" varStatus="i">
                        <li>
                            <a href="/notice/detail?noticeId=${notice.noticeId }">${notice.noticeTitle}</a><span><fmt:formatDate
                                value="${notice.writeDate}" pattern="yyyy.MM.dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="board">
                <h3><a href="/notice/list">질문게시?��</a></h3>
                <ul>
                    <c:forEach items="${tList }" var="teacher" varStatus="i">
                        <li>
                            <a href="/teacher/question/detail?questionNo=${teacher.questionNo }">${teacher.questionTitle}</a><span><fmt:formatDate
                                value="${teacher.writeDate}" pattern="yyyy.MM.dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <jsp:include page="common/footer.jsp"/>
    </body>
</html>