<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.edumate.boot.domain.event.model.vo.EventContent" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>?��벤트 게시�? ?��?��</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/event/event_insert.css">
</head>
<body>
    <!-- ===== ?��?�� ===== -->
    <jsp:include page="../common/header.jsp" />

    <!-- ===== 메인 ===== -->
    <main>
        <!-- 배너 -->
        <section class="event-banner">
            <h1>?��벤트 게시�? ?��?��</h1>
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/event/event_icon.png" alt="?��벤트 ?��?���?" />
        </section>

        <!-- ?�� ?��?�� -->
        <section class="event-insert-section">
            <form action="/event/update" method="post" enctype="multipart/form-data" class="event-form">
                <input type="hidden" name="eventId" value="${event.eventId}">

                <!-- ?���? -->
                <div class="form-group">
                    <label>?���?</label>
                    <input type="text" name="eventTitle" value="${event.eventTitle}" required>
                </div>

                <!-- �??���? -->
                <div class="form-group">
                    <label>�??���?</label>
                    <input type="text" name="eventSubtitle" value="${event.eventSubtitle}">
                </div>

                <!-- 진행 기간 -->
                <div class="form-group">
                    <label>진행 기간</label>
                    <div class="date-range">
                        <input type="date" name="eventStart" value="${event.eventStart}" required> ~
                        <input type="date" name="eventEnd" value="${event.eventEnd}" required>
                    </div>
                </div>

                <!-- ?��?��?�� ?��로드 -->
                <div class="form-group">
                    <label>?��벤트 ?��?��?��</label>
                    <input type="file" name="thumbnailFile" id="thumbnailFile" accept="image/*">
                    <div id="thumbnailPreview" class="preview-box">
                        <c:if test="${not empty event.eventPath}">
                            <img src="${event.eventPath}" alt="?��?��?��">
                        </c:if>
                    </div>
                </div>

                <!-- ?��?�� ?��미�? ?��로드 -->
                <div class="form-group">
                    <label>?��?�� ?��미�?</label>
                    <input type="file" name="contentFiles" id="contentFiles" accept="image/*" multiple>
                    <div id="contentPreview" class="preview-box">
<c:if test="${not empty contents}">
    <c:forEach items="${contents}" var="content">
        <img src="${content.eContentPath}" alt="?��벤트 ?��미�?"/>
    </c:forEach>
</c:if>
                    </div>
                </div>

                <!-- 버튼 -->
                <div class="form-actions">
                    <button type="submit" class="submit-btn">?��?��?���?</button>
                    <button type="button" class="cancel-btn" onclick="location.href='/event/list'">취소</button>
                </div>
            </form>
        </section>
    </main>

    <!-- ===== ?��?�� ===== -->
    <jsp:include page="../common/footer.jsp" />

    <script>
        // ?��?��?�� 미리보기
        document.getElementById('thumbnailFile').addEventListener('change', function (e) {
            const preview = document.getElementById('thumbnailPreview');
            preview.innerHTML = '';
            const file = e.target.files[0];
            if (file) {
                const img = document.createElement('img');
                img.src = URL.createObjectURL(file);
                preview.appendChild(img);
            }
        });

        // ?��?�� ?��미�? 미리보기
        document.getElementById('contentFiles').addEventListener('change', function (e) {
            const preview = document.getElementById('contentPreview');
            preview.innerHTML = '';
            Array.from(e.target.files).forEach(file => {
                const img = document.createElement('img');
                img.src = URL.createObjectURL(file);
                preview.appendChild(img);
            });
        });
    </script>
</body>
</html>
