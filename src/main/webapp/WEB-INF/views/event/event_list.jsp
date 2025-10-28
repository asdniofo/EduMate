<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 목록</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/common/main_banner.css">
<link rel="stylesheet" href="/resources/css/event/event_list.css">
</head>
<body>

<jsp:include page="../common/header.jsp"/>

<!-- 메인 배너 -->
<section class="main-banner">
    <div class="banner-text">
        이벤트
    </div>
    <div class="object">
        <img src="/resources/images/event/icon/event_icon.png" alt="이벤트 아이콘">
    </div>
</section>

<main class="main-content">
    <!-- 검색창 -->
    <form action="/event/search" method="get">
            <div class="search-bar">
                <input type="text" placeholder="검색어를 입력하세요" 
				name="searchKeyword" value="${searchKeyword }"/>
                <button type="submit">🔍</button>
                <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
                    <a href="/event/insert" class="write-button">글쓰기</a>
                </c:if>
			</div>
		</form>

    <!-- 이벤트 목록 -->
    <section class="event-list">
        <!-- 현재 날짜 -->
        <jsp:useBean id="now" class="java.util.Date" />

        <c:forEach items="${eList}" var="event">
            <!-- eventStart, eventEnd가 Date 타입이면 바로 사용 가능 -->
            <c:set var="startDate" value="${event.eventStart}" />
            <c:set var="endDate" value="${event.eventEnd}" />

            <!-- 진행 여부 계산 -->
            <c:choose>
                <c:when test="${now.time >= startDate.time && now.time <= endDate.time}">
                    <c:set var="eventYn" value="Y" />
                </c:when>
                <c:otherwise>
                    <c:set var="eventYn" value="N" />
                </c:otherwise>
            </c:choose>

            <!-- 남은 일수 계산 -->
            <c:set var="remainDays" value="${(endDate.time - now.time) / (1000*60*60*24)}" />

            <a href="/event/detail?eventId=${event.eventId}" class="event-card">
                <div class="event-banner">
                    <img src="${event.eventSubpath}" alt="이벤트 배너" class="event-banner-img">
                </div>
                <div class="event-info">
                    <div class="event-status ${eventYn eq 'Y' ? 'on' : 'end'}">
                        <c:choose>
                            <c:when test="${eventYn eq 'Y'}">
                                진행중
                                <c:if test="${remainDays <= 3 && remainDays >= 0}">
                                    <span style="font-weight:500; color:yellow;">(D-${remainDays})</span>
                                </c:if>
                            </c:when>
                            <c:otherwise>종료</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="event-text">
                        <h3 class="event-title">${event.eventTitle}</h3>
                        <p class="event-desc">${event.eventSubtitle}</p>
                        <div class="event-date">
                            <fmt:formatDate value="${startDate}" pattern="yyyy.MM.dd"/> ~ 
                            <fmt:formatDate value="${endDate}" pattern="yyyy.MM.dd"/>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </section>

    <!-- 페이지네이션 + 글쓰기 -->
    <div class="bottom-actions">
        <div class="pagination">
            <c:if test="${startNavi ne 0}">
                <a href="/event/list?page=${startNavi - 1}"><button class="page-btn">이전</button></a>
            </c:if>
            <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                <a href="/event/list?page=${n}">
                    <button class="page-btn ${currentPage eq n ? 'active' : ''}">${n+1}</button>
                </a>
            </c:forEach>
            <c:if test="${endNavi ne maxPage}">
                <a href="/event/list?page=${endNavi + 1}"><button class="page-btn">다음</button></a>
            </c:if>
        </div>

        <!-- ADMIN만 글쓰기 버튼 -->
        <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
            <a href="/event/insert" class="write-button">글쓰기</a>
        </c:if>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
