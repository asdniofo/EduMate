<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?���? ?���?</title>

<!-- ?�� ?���? ?��???�� -->
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
        공�??��?��
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?��료실 ?��?���?">
        </div>
	</section>
  <div class="container">
    <!-- ?�� 콘텐�? ?��?�� -->
    <div class="content">
      <div class="reference-write-container">

        <form action="/reference/insert" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

          <!-- ?���? -->
          <div class="form-group">
            <label for="archiveTitle" class="form-label">?���?</label>
            <input type="text" id="archiveTitle" name="archiveTitle" class="form-input" placeholder="?��목을 ?��?��?��?��?��" required />
          </div>

          <!-- ?��?�� -->
          <div class="form-group">
            <label class="form-label">?���? ?��?��</label>
            <div class="tag-group">
              <input type="radio" id="type1" name="archiveType" value="강의 ?���?" class="tag-radio" checked />
              <label for="type1" class="tag-label">강의 ?���?</label>

              <input type="radio" id="type2" name="archiveType" value="기�? ?���?" class="tag-radio" />
              <label for="type2" class="tag-label">기�? ?���?</label>
            </div>
          </div>

          <!-- ?��?�� -->
          <div class="form-group">
            <label for="archiveContent" class="form-label">?��?��</label>
            <textarea id="archiveContent" name="archiveContent" class="form-textarea" placeholder="?��?��?�� ?��?��?��?��?��" required></textarea>
          </div>

          <!-- ?��?�� ?��로드 -->
          <div class="form-group file-upload-section">
            <label class="file-upload-label">첨�??��?��</label>
            <div class="file-upload-wrapper">
              <input type="file" id="file" name="uploadFile" class="file-input" />
              <button type="button" class="file-upload-btn" onclick="document.getElementById('file').click()">?��?�� ?��?��</button>
              <span class="file-name-display" id="fileName">?��?��?�� ?��?�� ?��?��</span>
            </div>
          </div>

          <!-- 버튼 -->
          <div class="button-group">
            <button type="button" class="btn btn-cancel" onclick="location.href='/reference/list'">취소</button>
            <button type="submit" class="btn btn-submit">?���?</button>
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
      const fileName = this.files.length > 0 ? this.files[0].name : "?��?��?�� ?��?�� ?��?��";
      document.getElementById("fileName").textContent = fileName;
    });

    function validateForm() {
      const title = document.getElementById("archiveTitle").value.trim();
      const content = document.getElementById("archiveContent").value.trim();
      if (!title) {
        alert("?��목을 ?��?��?��주세?��.");
        document.getElementById("archiveTitle").focus();
        return false;
      }
      if (!content) {
        alert("?��?��?�� ?��?��?��주세?��.");
        document.getElementById("archiveContent").focus();
        return false;
      }
      return true;
    }
  </script>
</body>
</html>
