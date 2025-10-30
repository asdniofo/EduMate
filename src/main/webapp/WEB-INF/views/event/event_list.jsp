<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>?ù¥Î≤§Ìä∏ Î™©Î°ù</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/common/main_banner.css">
<link rel="stylesheet" href="/resources/css/event/event_list.css">
</head>
<body>

<jsp:include page="../common/header.jsp"/>

<!-- Î©îÏù∏ Î∞∞ÎÑà -->
<section class="main-banner">
    <div class="banner-text">
        ?ù¥Î≤§Ìä∏
    </div>
    <div class="object">
        <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/event/event_icon.png" alt="?ù¥Î≤§Ìä∏ ?ïÑ?ù¥ÏΩ?">
    </div>
</section>

<main class="main-content">
    <!-- Í≤??ÉâÏ∞? -->
    <form action="/event/search" method="get">
            <div class="search-bar">
                <input type="text" placeholder="Í≤??Éâ?ñ¥Î•? ?ûÖ?†•?ïò?Ñ∏?öî" 
				name="searchKeyword" value="${searchKeyword }"/>
                <button type="submit">?üî?</button>
                <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
                    <a href="/event/insert" class="write-button">Í∏??ì∞Í∏?</a>
                </c:if>
			</div>
		</form>

    <!-- ?ù¥Î≤§Ìä∏ Î™©Î°ù -->
    <section class="event-list">
        <!-- ?òÑ?û¨ ?Ç†Ïß? -->
        <jsp:useBean id="now" class="java.util.Date" />

        <c:forEach items="${eList}" var="event">
            <!-- eventStart, eventEndÍ∞? Date ???ûÖ?ù¥Î©? Î∞îÎ°ú ?Ç¨?ö© Í∞??ä• -->
            <c:set var="startDate" value="${event.eventStart}" />
            <c:set var="endDate" value="${event.eventEnd}" />

            <!-- ÏßÑÌñâ ?ó¨Î∂? Í≥ÑÏÇ∞ -->
            <c:choose>
                <c:when test="${now.time >= startDate.time && now.time <= endDate.time}">
                    <c:set var="eventYn" value="Y" />
                </c:when>
                <c:otherwise>
                    <c:set var="eventYn" value="N" />
                </c:otherwise>
            </c:choose>

            <!-- ?Ç®?? ?ùº?àò Í≥ÑÏÇ∞ -->
            <c:set var="remainDays" value="${(endDate.time - now.time) / (1000*60*60*24)}" />

            <a href="/event/detail?eventId=${event.eventId}" class="event-card">
                <div class="event-banner">
                    <img src="${event.eventSubpath}" alt="?ù¥Î≤§Ìä∏ Î∞∞ÎÑà" class="event-banner-img">
                </div>
                <div class="event-info">
                    <div class="event-status ${eventYn eq 'Y' ? 'on' : 'end'}">
                        <c:choose>
                            <c:when test="${eventYn eq 'Y'}">
                                ÏßÑÌñâÏ§?
                                <c:if test="${remainDays <= 3 && remainDays >= 0}">
                                    <span style="font-weight:500; color:yellow;">(D-${remainDays})</span>
                                </c:if>
                            </c:when>
                            <c:otherwise>Ï¢ÖÎ£å</c:otherwise>
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

    <!-- ?éò?ù¥Ïß??Ñ§?ù¥?Öò + Í∏??ì∞Í∏? -->
    <div class="bottom-actions">
        <div class="pagination">
            <c:if test="${startNavi ne 0}">
                <a href="/event/list?page=${startNavi - 1}"><button class="page-btn">?ù¥?†Ñ</button></a>
            </c:if>
            <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                <a href="/event/list?page=${n}">
                    <button class="page-btn ${currentPage eq n ? 'active' : ''}">${n+1}</button>
                </a>
            </c:forEach>
            <c:if test="${endNavi ne maxPage}">
                <a href="/event/list?page=${endNavi + 1}"><button class="page-btn">?ã§?ùå</button></a>
            </c:if>
        </div>

        <!-- ADMINÎß? Í∏??ì∞Í∏? Î≤ÑÌäº -->
        <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
            <a href="/event/insert" class="write-button">Í∏??ì∞Í∏?</a>
        </c:if>
    </div>
</main>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
