<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
            <div class="object"></div>
        </section>

        <!-- ===== 광고 영역 (교체용) ===== -->
        <section class="ads-section">
            <div class="ads-wrapper">
                <!-- 뷰포트: 가운데 정렬, 한 화면에 3개 보임 -->
                <div class="ads-viewport" id="adsViewport">
                    <div class="ads-track" id="adsTrack">
                        <!-- 실제 광고들 (원본 순서대로) -->
                        <div class="ad-box" onclick="location.href='#'">광고 1</div>
                        <div class="ad-box" onclick="location.href='#'">광고 2</div>
                        <div class="ad-box" onclick="location.href='#'">광고 3</div>
                        <div class="ad-box" onclick="location.href='#'">광고 4</div>
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
                <div class="lecture-card" onclick="location.href='#'">
                    <div class="lecture-img"></div>
                    <div class="lecture-info">
                        <p><b>강의 이름입니다.</b></p>
                        <p>약 4시간</p>
                        <p class="discount">30% 할인</p>
                        <p>₩2,000,000</p>
                    </div>
                </div>
                <div class="lecture-card" onclick="location.href='#'">
                    <div class="lecture-img"></div>
                    <div class="lecture-info">
                        <p><b>강의 이름입니다.</b></p>
                        <p>약 4시간</p>
                        <p class="discount">30% 할인</p>
                        <p>₩2,000,000</p>
                    </div>
                </div>
                <div class="lecture-card" onclick="location.href='#'">
                    <div class="lecture-img"></div>
                    <div class="lecture-info">
                        <p><b>강의 이름입니다.</b></p>
                        <p>약 4시간</p>
                        <p class="discount">30% 할인</p>
                        <p>₩2,000,000</p>
                    </div>
                </div>
                <div class="lecture-card" onclick="location.href='#'">
                    <div class="lecture-img"></div>
                    <div class="lecture-info">
                        <p><b>강의 이름입니다.</b></p>
                        <p>약 4시간</p>
                        <p class="discount">30% 할인</p>
                        <p>₩2,000,000</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 최근 올라온 강의 -->
        <section class="lecture-section">
            <h2>최근 올라온 강의</h2>
            <div class="lecture-grid">
                <div class="lecture-card" onclick="location.href='#'"><div class="lecture-img"></div><div class="lecture-info"><p><b>강의 이름입니다.</b></p><p>약 4시간</p><p class="discount">30% 할인</p><p>₩2,000,000</p></div></div>
                <div class="lecture-card" onclick="location.href='#'"><div class="lecture-img"></div><div class="lecture-info"><p><b>강의 이름입니다.</b></p><p>약 4시간</p><p class="discount">30% 할인</p><p>₩2,000,000</p></div></div>
                <div class="lecture-card" onclick="location.href='#'"><div class="lecture-img"></div><div class="lecture-info"><p><b>강의 이름입니다.</b></p><p>약 4시간</p><p class="discount">30% 할인</p><p>₩2,000,000</p></div></div>
                <div class="lecture-card" onclick="location.href='#'"><div class="lecture-img"></div><div class="lecture-info"><p><b>강의 이름입니다.</b></p><p>약 4시간</p><p class="discount">30% 할인</p><p>₩2,000,000</p></div></div>
            </div>
        </section>

        <!-- 공지사항 / 자유게시판 -->
        <section class="board-section">
            <div class="board">
                <h3>공지사항</h3>
                <ul>
                    <li><a href="#">사이트 개편 안내</a><span>2025.10.02</span></li>
                    <li><a href="#">오늘만 가입 10일 혜택</a><span>2025.10.01</span></li>
                    <li><a href="#">테스트</a><span>2025.10.01</span></li>
                    <li><a href="#">테스트 두번째</a><span>2025.09.30</span></li>
                </ul>
            </div>

            <div class="board">
                <h3>자유게시판</h3>
                <ul>
                    <li><a href="#">테코파</a><span>2025.10.02</span></li>
                    <li><a href="#">오늘만 가입 10일 혜택</a><span>2025.10.01</span></li>
                    <li><a href="#">테스트</a><span>2025.10.01</span></li>
                    <li><a href="#">테스트 두번째</a><span>2025.09.30</span></li>
                </ul>
            </div>
        </section>
        <jsp:include page="common/footer.jsp" />
    </body>
</html>