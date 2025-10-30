<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.edumate.boot.domain.event.model.vo.EventContent" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>?ù¥Î≤§Ìä∏ Í≤åÏãúÎ¨? ?àò?†ï</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/event/event_insert.css">
</head>
<body>
    <!-- ===== ?ó§?çî ===== -->
    <jsp:include page="../common/header.jsp" />

    <!-- ===== Î©îÏù∏ ===== -->
    <main>
        <!-- Î∞∞ÎÑà -->
        <section class="event-banner">
            <h1>?ù¥Î≤§Ìä∏ Í≤åÏãúÎ¨? ?àò?†ï</h1>
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/event/event_icon.png" alt="?ù¥Î≤§Ìä∏ ?ïÑ?ù¥ÏΩ?" />
        </section>

        <!-- ?èº ?òÅ?ó≠ -->
        <section class="event-insert-section">
            <form action="/event/update" method="post" enctype="multipart/form-data" class="event-form">
                <input type="hidden" name="eventId" value="${event.eventId}">

                <!-- ?†úÎ™? -->
                <div class="form-group">
                    <label>?†úÎ™?</label>
                    <input type="text" name="eventTitle" value="${event.eventTitle}" required>
                </div>

                <!-- Î∂??†úÎ™? -->
                <div class="form-group">
                    <label>Î∂??†úÎ™?</label>
                    <input type="text" name="eventSubtitle" value="${event.eventSubtitle}">
                </div>

                <!-- ÏßÑÌñâ Í∏∞Í∞Ñ -->
                <div class="form-group">
                    <label>ÏßÑÌñâ Í∏∞Í∞Ñ</label>
                    <div class="date-range">
                        <input type="date" name="eventStart" value="${event.eventStart}" required> ~
                        <input type="date" name="eventEnd" value="${event.eventEnd}" required>
                    </div>
                </div>

                <!-- ?ç∏?Ñ§?ùº ?óÖÎ°úÎìú -->
                <div class="form-group">
                    <label>?ù¥Î≤§Ìä∏ ?ç∏?Ñ§?ùº</label>
                    <input type="file" name="thumbnailFile" id="thumbnailFile" accept="image/*">
                    <div id="thumbnailPreview" class="preview-box">
                        <c:if test="${not empty event.eventPath}">
                            <img src="${event.eventPath}" alt="?ç∏?Ñ§?ùº">
                        </c:if>
                    </div>
                </div>

                <!-- ?ÉÅ?Ñ∏ ?ù¥ÎØ∏Ï? ?óÖÎ°úÎìú -->
                <div class="form-group">
                    <label>?ÉÅ?Ñ∏ ?ù¥ÎØ∏Ï?</label>
                    <input type="file" name="contentFiles" id="contentFiles" accept="image/*" multiple>
                    <div id="contentPreview" class="preview-box">
<c:if test="${not empty contents}">
    <c:forEach items="${contents}" var="content">
        <img src="${content.eContentPath}" alt="?ù¥Î≤§Ìä∏ ?ù¥ÎØ∏Ï?"/>
    </c:forEach>
</c:if>
                    </div>
                </div>

                <!-- Î≤ÑÌäº -->
                <div class="form-actions">
                    <button type="submit" class="submit-btn">?àò?†ï?ïòÍ∏?</button>
                    <button type="button" class="cancel-btn" onclick="location.href='/event/list'">Ï∑®ÏÜå</button>
                </div>
            </form>
        </section>
    </main>

    <!-- ===== ?ë∏?Ñ∞ ===== -->
    <jsp:include page="../common/footer.jsp" />

    <script>
        // ?ç∏?Ñ§?ùº ÎØ∏Î¶¨Î≥¥Í∏∞
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

        // ?ÉÅ?Ñ∏ ?ù¥ÎØ∏Ï? ÎØ∏Î¶¨Î≥¥Í∏∞
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
