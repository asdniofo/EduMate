<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Edumate 메인</title>
    </head>
    <link rel="stylesheet" href="/resources/css/main/index.css">
    <link rel="stylesheet" href="/resources/css/common/header.css" />
    <link rel="stylesheet" href="/resources/css/common/footer.css" />
  	<script src="/resources/js/main/index.js"></script>
    <body>
        <jsp:include page="common/header.jsp" />
        <!-- 메인 배너 -->
        <section class="main-banner">
            <div class="banner-text">
                AI와 함께하는 최상급 공부<br />
                언제 어디서나, 당신의 성장을 응원합니다.
            </div>
            <div class="object">
                <img src="/resources/images/adv/gemini.png" alt="Gemini AI">
            </div>
        </section>

        <!-- ===== 광고 영역 (교체용) ===== -->
        <section class="ads-section">
            <div class="ads-wrapper">
                <!-- 뷰포트: 가운데 정렬, 한 화면에 3개 보임 -->
                <div class="ads-viewport" id="adsViewport">
                    <div class="ads-track" id="adsTrack">
                        <!-- 실제 광고들 (원본 순서대로) -->
                        <div class="ad-box" id = "ad1" onclick="location.href='/event/list'">광고 1</div>
                        <div class="ad-box" id = "ad2" onclick="location.href='/event/list'">광고 2</div>
                        <div class="ad-box" id = "ad3" onclick="location.href='/event/list'">광고 3</div>
                        <div class="ad-box" id = "ad4" onclick="location.href='/event/list'">광고 4</div>
                    </div>
                </div>

                <!-- 컨트롤 (JS가 위치를 계산합니다) -->
                <div class="ads-controls" id="adsControls">
                    <button id="prevBtn">◀</button>
                    <button id="pauseBtn">⏸</button>
                    <button id="nextBtn">▶</button>
                </div>
            </div>
        </section>

        <!-- 아이콘 네비게이션 -->
        <div class="icon-nav">
            <div class="icon-item">
                <button class="icon" onclick=""></button> <br>
                <a href="#">홈</a>
            </div>
            <div class="icon-item">
                <button class="icon" onclick=""></button> <br>
                <a href="#">코딩</a>
            </div>
            <div class="icon-item">
                <button class="icon" onclick=""></button> <br>
                <a href="#">찜</a>
            </div>
            <div class="icon-item">
                <button class="icon" onclick=""></button> <br>
                <a href="#">장바구니</a>
            </div>
            <div class="icon-item">
                <button class="icon" onclick=""></button> <br>
                <a href="#">배송</a>
            </div>
        </div>

        <!-- 인기 강의 -->
        <section class="lecture-section">
            <h2>인기 강의</h2>
            <div class="lecture-grid">
                <c:forEach items="${pList }" var="popular" varStatus="i">
                <div class="lecture-card" onclick="location.href='/lecture/details?lectureNo=${popular.lectureNo}'">
                    <img class="lecture-img" src="/images/lecture/${popular.lecturePath}"></img>
                    <div class="lecture-info">
                        <p><b>${popular.lectureName }</b></p>
                        <p>${popular.time}</p>
                        <p>₩ <fmt:formatNumber value="${popular.lecturePrice}" pattern="#,###"/></p>
                    </div>
                </div>
                </c:forEach>
            </div>
        </section>

        <!-- 최근 올라온 강의 -->
        <section class="lecture-section">
            <h2>최근 올라온 강의</h2>
            <div class="lecture-grid">
                <c:forEach items="${rList }" var="recent" varStatus="i">
                    <div class="lecture-card" onclick="location.href='/lecture/details?lectureNo=${recent.lectureNo}'">
                        <img class="lecture-img" src="/images/lecture/${recent.lecturePath}"></img>
                        <div class="lecture-info">
                            <p><b>${recent.lectureName }</b></p>
                            <p>${recent.time}</p>
                            <p>₩ <fmt:formatNumber value="${recent.lecturePrice}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <!-- 공지사항 / 자유게시판 -->
        <section class="board-section">
            <div class="board">
                <h3><a href="/notice/list">공지사항</a></h3>
                <ul>
                    <c:forEach items="${nList }" var="notice" varStatus="i">
                    <li><a href="/notice/detail?noticeId=${notice.noticeId }">${notice.noticeTitle}</a><span><fmt:formatDate value="${notice.writeDate}" pattern="yyyy.MM.dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>

            <div class="board">
                <h3><a href="/notice/list">질문게시판</a></h3>
                <ul>
                    <c:forEach items="${tList }" var="teacher" varStatus="i">
                        <li><a href="/teacher/question/detail?questionNo=${teacher.questionNo }">${teacher.questionTitle}</a><span><fmt:formatDate value="${teacher.writeDate}" pattern="yyyy.MM.dd"/></span></li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <jsp:include page="common/footer.jsp" />
    </body>
</html>