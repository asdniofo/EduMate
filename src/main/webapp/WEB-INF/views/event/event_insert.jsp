<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 게시물 작성</title>
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="/resources/css/event/event_insert.css">
<link rel="stylesheet" href="/resources/css/common/main_banner.css">
</head>
<body>
    <!-- ===== 헤더 ===== -->
    <jsp:include page="../common/header.jsp" />

    <!-- ===== 메인 ===== -->
    <main>
        <!-- 배너 -->
<section class="main-banner">
            <div class="banner-text">
                이벤트 작성
            </div>
            <div class="object">
                <img src="/resources/images/event/icon/event_insert_icon.png">
            </div>
</section>

        <!-- 폼 영역 -->
        <section class="event-insert-section">
            <form action="/event/insert" method="post" enctype="multipart/form-data" class="event-form">
                <!-- 제목 -->
                <div class="form-group">
                    <label>제목</label>
                    <input type="text" name="eventTitle" placeholder="제목을 입력해주세요." required>
                </div>

                <!-- 부제목 -->
                <div class="form-group">
                    <label>부제목</label>
                    <input type="text" name="eventSubtitle" placeholder="부제목을 입력해주세요.">
                </div>

                <!-- 진행 기간 -->
                <div class="form-group">
                    <label>진행 기간</label>
                    <div class="date-range">
                        <input type="date" name="eventStart" required> ~
                        <input type="date" name="eventEnd" required>
                    </div>
                </div>

                <!-- 썸네일 업로드 -->
                <div class="form-group">
                    <label>이벤트 썸네일</label>
                    <input type="file" name="thumbnailFile" id="thumbnailFile" accept="image/*" required>
                    <div id="thumbnailPreview" class="preview-box"></div>
                </div>

                <!-- 상세 이미지 업로드 -->
                <div class="form-group">
                    <label>상세 이미지</label>
                    <input type="file" name="contentFiles" id="contentFiles" accept="image/*" multiple>
                    <div id="contentPreview" class="preview-box"></div>
                </div>

                <!-- 버튼 -->
                <div class="form-actions">
                    <button type="submit" class="submit-btn">등록하기</button>
                    <button type="button" class="cancel-btn" onclick="location.href='/event/list'">취소</button>
                </div>
            </form>
        </section>
    </main>

    <!-- ===== 푸터 ===== -->
    <jsp:include page="../common/footer.jsp" />

    <script>
        // 썸네일 미리보기
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

        // 상세 이미지 미리보기
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
