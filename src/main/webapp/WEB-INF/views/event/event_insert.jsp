<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>?ù¥Î≤§Ìä∏ Í≤åÏãúÎ¨? ?ûë?Ñ±</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/event/event_insert.css">
<link rel="stylesheet" href="/resources/css/common/main_banner.css">
</head>
<body>
    <!-- ===== ?ó§?çî ===== -->
    <jsp:include page="../common/header.jsp" />

    <!-- ===== Î©îÏù∏ ===== -->
    <main>
        <!-- Î∞∞ÎÑà -->
<section class="main-banner">
            <div class="banner-text">
                ?ù¥Î≤§Ìä∏ ?ûë?Ñ±
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/event/event_insert_icon.png">
            </div>
</section>

        <!-- ?èº ?òÅ?ó≠ -->
        <section class="event-insert-section">
            <form action="/event/insert" method="post" enctype="multipart/form-data" class="event-form">
                <!-- ?†úÎ™? -->
                <div class="form-group">
                    <label>?†úÎ™?</label>
                    <input type="text" name="eventTitle" placeholder="?†úÎ™©ÏùÑ ?ûÖ?†•?ï¥Ï£ºÏÑ∏?öî." required>
                </div>

                <!-- Î∂??†úÎ™? -->
                <div class="form-group">
                    <label>Î∂??†úÎ™?</label>
                    <input type="text" name="eventSubtitle" placeholder="Î∂??†úÎ™©ÏùÑ ?ûÖ?†•?ï¥Ï£ºÏÑ∏?öî.">
                </div>

                <!-- ÏßÑÌñâ Í∏∞Í∞Ñ -->
                <div class="form-group">
                    <label>ÏßÑÌñâ Í∏∞Í∞Ñ</label>
                    <div class="date-range">
                        <input type="date" name="eventStart" required> ~
                        <input type="date" name="eventEnd" required>
                    </div>
                </div>

                <!-- ?ç∏?Ñ§?ùº ?óÖÎ°úÎìú -->
                <div class="form-group">
                    <label>?ù¥Î≤§Ìä∏ ?ç∏?Ñ§?ùº</label>
                    <input type="file" name="thumbnailFile" id="thumbnailFile" accept="image/*" required>
                    <div id="thumbnailPreview" class="preview-box"></div>
                </div>

                <!-- ?ÉÅ?Ñ∏ ?ù¥ÎØ∏Ï? ?óÖÎ°úÎìú -->
                <div class="form-group">
                    <label>?ÉÅ?Ñ∏ ?ù¥ÎØ∏Ï?</label>
                    <input type="file" name="contentFiles" id="contentFiles" accept="image/*" multiple>
                    <div id="contentPreview" class="preview-box"></div>
                </div>

                <!-- Î≤ÑÌäº -->
                <div class="form-actions">
                    <button type="submit" class="submit-btn">?ì±Î°ùÌïòÍ∏?</button>
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
