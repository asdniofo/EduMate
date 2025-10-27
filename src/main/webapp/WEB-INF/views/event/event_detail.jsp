<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>${event.eventTitle} - 이벤트 상세</title>
<link rel="stylesheet" href="/resources/css/event/event_detail.css" />
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
    <!-- ===== 헤더 ===== -->
    <jsp:include page="../common/header.jsp" />

    <!-- ===== 메인 ===== -->
    <main>
        <!-- 배너 -->
        <section class="event-banner">
            <h1>이벤트</h1>
            <img src="/resources/images/event_icon.png" alt="이벤트 아이콘" />
        </section>

        <!-- 이벤트 상세 -->
        <section class="event-detail">
            <!-- 헤더 -->
            <div class="event-header">
                <div class="event-path">이벤트 &gt; ${event.eventTitle}</div>
                <div class="event-meta">
                    <span>
                        <fmt:formatDate value="${event.eventStart}" pattern="yyyy-MM-dd" /> ~ 
                        <fmt:formatDate value="${event.eventEnd}" pattern="yyyy-MM-dd" />
                    </span>
                    <span class="event-status ${event.eventYn eq 'Y' ? 'on' : 'end'}">
                        ${event.eventYn eq 'Y' ? '진행중' : '종료'}
                    </span>
                </div>
            </div>

            <!-- 본문 -->
            <div class="event-content">
                <!-- 메인 이미지 -->
                <c:if test="${not empty event.eventPath}">
                    <img src="${event.eventPath}" alt="이벤트 상세 메인 이미지" class="main-detail-img" />
                </c:if>

                <!-- 상세 이미지들 -->
                <c:if test="${not empty contents}">
                    <div class="event-content-list">
                        <c:forEach var="content" items="${contents}">
                            <div class="event-content-item">
                                <%-- 원본 경로 사용 (파일이 존재하는 경우) --%>
                                <c:set var="contentStr" value="${content.toString()}" />
                                <c:set var="startPath" value="${fn:substringAfter(contentStr, 'eContentPath=\\'')}" />
                                <c:set var="imagePath" value="${fn:substringBefore(startPath, '\\'')}" />
                                <img src="${imagePath}" alt="Event Content Image" />
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                
                <!-- 콘텐츠가 없을 경우 메시지 -->
                <c:if test="${empty contents}">
                    <div class="no-content-message">
                        <p>추가 이미지가 없습니다.</p>
                    </div>
                </c:if>
            </div>

            <!-- 버튼 -->
            <div class="event-buttons">
                <!-- 관리자 전용 -->
                <div class="event-buttons-left">
                    <c:if test="${sessionScope.loginMember.adminYN eq 'Y'}">
                        <a href="/event/update?eventId=${event.eventId}" style="text-decoration:none">
                            <button class="edit-btn">수정</button>
                        </a>
                        <a href="javascript:void(0)" onclick="checkDelete();" style="text-decoration:none">
                            <button class="delete-btn">삭제</button>
                        </a>
                    </c:if>
                </div>

                <!-- 이동 버튼 -->
                <div class="event-buttons-right">
                    <c:if test="${not empty prevEventId}">
                        <button class="prev-btn" onclick="location.href='/event/detail?eventId=${prevEventId}'">이전</button>
                    </c:if>
                    <c:if test="${not empty nextEventId}">
                        <button class="next-btn" onclick="location.href='/event/detail?eventId=${nextEventId}'">다음</button>
                    </c:if>
                    <button class="list-btn" onclick="location.href='/event/list'">목록</button>
                </div>
            </div>
        </section>
    </main>

    <!-- ===== 푸터 ===== -->
    <jsp:include page="../common/footer.jsp" />

    <script>
        function checkDelete() {
            if (confirm('정말로 삭제하시겠습니까?')) {
                location.href = '/event/delete?eventId=${event.eventId}';
            }
        }
    </script>
</body>
</html>