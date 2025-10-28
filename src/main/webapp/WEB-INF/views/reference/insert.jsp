<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료 등록</title>

<!-- ✅ 독립 스타일 -->
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="../resources/css/reference/insert.css">

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
  	<jsp:include page="../common/header.jsp" />
	<!-- 메인 배너 -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        공지사항
    </div>
        <div class="object">
            <img src="/resources/images/reference/reference-icon.png" alt="자료실 아이콘">
        </div>
	</section>
  <div class="container">
    <!-- ✅ 콘텐츠 영역 -->
    <div class="content">
      <div class="reference-write-container">

        <form action="/reference/insert" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

          <!-- 제목 -->
          <div class="form-group">
            <label for="archiveTitle" class="form-label">제목</label>
            <input type="text" id="archiveTitle" name="archiveTitle" class="form-input" placeholder="제목을 입력하세요" required />
          </div>

          <!-- 유형 -->
          <div class="form-group">
            <label class="form-label">자료 유형</label>
            <div class="tag-group">
              <input type="radio" id="type1" name="archiveType" value="강의 자료" class="tag-radio" checked />
              <label for="type1" class="tag-label">강의 자료</label>

              <input type="radio" id="type2" name="archiveType" value="기타 자료" class="tag-radio" />
              <label for="type2" class="tag-label">기타 자료</label>
            </div>
          </div>

          <!-- 내용 -->
          <div class="form-group">
            <label for="archiveContent" class="form-label">내용</label>
            <textarea id="archiveContent" name="archiveContent" class="form-textarea" placeholder="내용을 입력하세요" required></textarea>
          </div>

          <!-- 파일 업로드 -->
          <div class="form-group file-upload-section">
            <label class="file-upload-label">첨부파일</label>
            <div class="file-upload-wrapper">
              <input type="file" id="file" name="uploadFile" class="file-input" />
              <button type="button" class="file-upload-btn" onclick="document.getElementById('file').click()">파일 선택</button>
              <span class="file-name-display" id="fileName">선택된 파일 없음</span>
            </div>
          </div>

          <!-- 버튼 -->
          <div class="button-group">
            <button type="button" class="btn btn-cancel" onclick="location.href='/reference/list'">취소</button>
            <button type="submit" class="btn btn-submit">등록</button>
          </div>

        </form>
      </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../common/footer.jsp" />

  </div>

  <!-- JS -->
  <script>
    document.getElementById("file").addEventListener("change", function() {
      const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
      document.getElementById("fileName").textContent = fileName;
    });

    function validateForm() {
      const title = document.getElementById("archiveTitle").value.trim();
      const content = document.getElementById("archiveContent").value.trim();
      if (!title) {
        alert("제목을 입력해주세요.");
        document.getElementById("archiveTitle").focus();
        return false;
      }
      if (!content) {
        alert("내용을 입력해주세요.");
        document.getElementById("archiveContent").focus();
        return false;
      }
      return true;
    }
  </script>
</body>
</html>
