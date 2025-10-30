<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*, java.text.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${event.eventTitle} - ?ù¥Î≤§Ìä∏ ?ÉÅ?Ñ∏</title>
<link rel="stylesheet" href="/resources/css/event/event_detail.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
<main>
<link rel="stylesheet" href="/resources/css/common/main_banner.css">
<section class="main-banner">
            <div class="banner-text">
                ?ù¥Î≤§Ìä∏ ?†ïÎ≥?
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/event/event_icon.png">
            </div>
</section>
    
    <section class="event-detail">
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
            Date now = new Date();
            Date startDate = null;
            Date endDate = null;
            try {
                startDate = sdf.parse(String.valueOf(request.getAttribute("event")).replaceAll(".*eventStart=(.*?),.*", "$1"));
                endDate = sdf.parse(String.valueOf(request.getAttribute("event")).replaceAll(".*eventEnd=(.*?),.*", "$1"));
            } catch (Exception e) { }

            boolean isOngoing = false;
            long remainDays = 0;
            if (startDate != null && endDate != null) {
                isOngoing = now.after(startDate) && now.before(endDate);
                remainDays = (endDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
            }
        %>

        <div class="event-header">
            <div class="event-path">?ù¥Î≤§Ìä∏ &gt; ${event.eventTitle}</div>
            <div class="event-meta">
                <span>
                    <fmt:formatDate value="${event.eventStart}" pattern="yyyy-MM-dd" /> ~ 
                    <fmt:formatDate value="${event.eventEnd}" pattern="yyyy-MM-dd" />
                </span>
                <span class="event-status <%= isOngoing ? "on" : "end" %>">
                    <%= isOngoing ? "ÏßÑÌñâÏ§?" : "Ï¢ÖÎ£å" %>
                    <% if (isOngoing && remainDays <= 3 && remainDays >= 0) { %>
                        <span style="font-weight:500; color:yellow;">(D-<%= remainDays %>)</span>
                    <% } %>
                </span>
            </div>
        </div>
        <div class="event-buttons">
            <div class="event-buttons-left">
                <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
                    <a href="/event/update?eventId=${event.eventId}" style="text-decoration:none">
                        <button class="edit-btn">?àò?†ï</button>
                    </a>
                    <a href="javascript:void(0)" onclick="checkDelete();" style="text-decoration:none">
                        <button class="delete-btn">?Ç≠?†ú</button>
                    </a>
                </c:if>
            </div>

            <div class="event-buttons-right">
                <c:if test="${not empty prevEventId}">
                    <button class="prev-btn" onclick="location.href='/event/detail?eventId=${prevEventId}'">?ù¥?†Ñ</button>
                </c:if>
                <c:if test="${not empty nextEventId}">
                    <button class="next-btn" onclick="location.href='/event/detail?eventId=${nextEventId}'">?ã§?ùå</button>
                </c:if>
                <button class="list-btn" onclick="location.href='/event/list'">Î™©Î°ù</button>
            </div>
        </div>
        <div class="event-content">

            <c:if test="${not empty contents}">
                <div class="event-content-list">
                    <c:forEach var="content" items="${contents}">
                        <div class="event-content-item">
                            <c:set var="contentStr" value="${content.toString()}" />
                            <c:set var="startPath" value="${fn:substringAfter(contentStr, 'eContentPath=\\'')}" />
                            <c:set var="imagePath" value="${fn:substringBefore(startPath, '\\'')}" />
                            <img src="${imagePath}" alt="Event Content Image" />
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${empty contents}">
                <div class="no-content-message">
                    <p>Ï∂îÍ? ?ù¥ÎØ∏Ï?Í∞? ?óÜ?äµ?ãà?ã§.</p>
                </div>
            </c:if>
        </div>

        <div class="event-buttons">
            <div class="event-buttons-left">
                <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
                    <a href="/event/update?eventId=${event.eventId}" style="text-decoration:none">
                        <button class="edit-btn">?àò?†ï</button>
                    </a>
                    <a href="javascript:void(0)" onclick="checkDelete();" style="text-decoration:none">
                        <button class="delete-btn">?Ç≠?†ú</button>
                    </a>
                </c:if>
            </div>

            <div class="event-buttons-right">
                <c:if test="${not empty prevEventId}">
                    <button class="prev-btn" onclick="location.href='/event/detail?eventId=${prevEventId}'">?ù¥?†Ñ</button>
                </c:if>
                <c:if test="${not empty nextEventId}">
                    <button class="next-btn" onclick="location.href='/event/detail?eventId=${nextEventId}'">?ã§?ùå</button>
                </c:if>
                <button class="list-btn" onclick="location.href='/event/list'">Î™©Î°ù</button>
            </div>
        </div>
    </section>
</main>

<jsp:include page="../common/footer.jsp" />

<script>
    function checkDelete() {
        if (confirm('?†ïÎßêÎ°ú ?Ç≠?†ú?ïò?ãúÍ≤†Ïäµ?ãàÍπ??')) {
            location.href = '/event/delete?eventId=${event.eventId}';
        }
    }
</script>
</body>
</html>
