<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 목록</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/event/event_list.css">
</head>
<body>
<jsp:include page="../common/header.jsp"/>

<!-- Hero Section -->
<section class="hero-section-wrapper">
    <div class="hero-section">
        <h1 class="hero-title">이벤트</h1>
        <div class="hero-image" style="border:2px dashed #aaa; width:180px; height:180px; border-radius:20px; display:inline-block;">
            📢 이벤트 아이콘
        </div>
    </div>
</section>

<main class="main-content">
    <!-- 검색창 -->
    <form action="/event/search" method="get">
        <div class="search-bar">
            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="이벤트를 검색하세요.">
            <button type="submit">🔍</button>
        </div>
    </form>

    <!-- 이벤트 목록 -->
    <section class="event-list">
        <c:forEach items="${eList}" var="event">
            <a href="/event/detail?eventId=${event.eventId}" class="event-card">
                <div class="event-banner">
                    <img src="${event.eventSubpath}" alt="이벤트 배너" class="event-banner-img">
                </div>
                <div class="event-info">
                    <div class="event-status ${event.eventYn eq 'Y' ? 'on' : 'end'}">
                        <c:choose>
                            <c:when test="${event.eventYn eq 'Y'}">진행중</c:when>
                            <c:otherwise>종료</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="event-text">
                        <h3 class="event-title">${event.eventTitle}</h3>
                        <p class="event-desc">${event.eventSubtitle}</p>
                        <div class="event-date">
                            <fmt:formatDate value="${event.eventStart}" pattern="yyyy.MM.dd"/> ~ 
                            <fmt:formatDate value="${event.eventEnd}" pattern="yyyy.MM.dd"/>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </section>

    <!-- 페이지네이션 + 글쓰기 -->
    <div class="bottom-actions">
        <div class="pagination">
            <c:if test="${startNavi ne 1}">
                <a href="/event/list?page=${startNavi - 1}"><button class="page-btn">이전</button></a>
            </c:if>
            <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                <a href="/event/list?page=${n}">
                    <button class="page-btn ${currentPage eq n ? 'active' : ''}">${n}</button>
                </a>
            </c:forEach>
            <c:if test="${endNavi ne maxPage}">
                <a href="/event/list?page=${endNavi + 1}"><button class="page-btn">다음</button></a>
            </c:if>
        </div>

        <!-- ADMIN만 글쓰기 버튼 노출 -->
        <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
            <a href="/event/insert" class="write-button">글쓰기</a>
        </c:if>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
