<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?ë£? ?“±ë¡?</title>

<!-- ?œ… ?…ë¦? ?Š¤???¼ -->
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link rel="stylesheet" href="../resources/css/reference/insert.css">

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
  	<jsp:include page="../common/header.jsp" />
	<!-- ë©”ì¸ ë°°ë„ˆ -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ê³µì??‚¬?•­
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?ë£Œì‹¤ ?•„?´ì½?">
        </div>
	</section>
  <div class="container">
    <!-- ?œ… ì½˜í…ì¸? ?˜?—­ -->
    <div class="content">
      <div class="reference-write-container">

        <form action="/reference/insert" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">

          <!-- ? œëª? -->
          <div class="form-group">
            <label for="archiveTitle" class="form-label">? œëª?</label>
            <input type="text" id="archiveTitle" name="archiveTitle" class="form-input" placeholder="? œëª©ì„ ?…? ¥?•˜?„¸?š”" required />
          </div>

          <!-- ?œ ?˜• -->
          <div class="form-group">
            <label class="form-label">?ë£? ?œ ?˜•</label>
            <div class="tag-group">
              <input type="radio" id="type1" name="archiveType" value="ê°•ì˜ ?ë£?" class="tag-radio" checked />
              <label for="type1" class="tag-label">ê°•ì˜ ?ë£?</label>

              <input type="radio" id="type2" name="archiveType" value="ê¸°í? ?ë£?" class="tag-radio" />
              <label for="type2" class="tag-label">ê¸°í? ?ë£?</label>
            </div>
          </div>

          <!-- ?‚´?š© -->
          <div class="form-group">
            <label for="archiveContent" class="form-label">?‚´?š©</label>
            <textarea id="archiveContent" name="archiveContent" class="form-textarea" placeholder="?‚´?š©?„ ?…? ¥?•˜?„¸?š”" required></textarea>
          </div>

          <!-- ?ŒŒ?¼ ?—…ë¡œë“œ -->
          <div class="form-group file-upload-section">
            <label class="file-upload-label">ì²¨ë??ŒŒ?¼</label>
            <div class="file-upload-wrapper">
              <input type="file" id="file" name="uploadFile" class="file-input" />
              <button type="button" class="file-upload-btn" onclick="document.getElementById('file').click()">?ŒŒ?¼ ?„ ?ƒ</button>
              <span class="file-name-display" id="fileName">?„ ?ƒ?œ ?ŒŒ?¼ ?—†?Œ</span>
            </div>
          </div>

          <!-- ë²„íŠ¼ -->
          <div class="button-group">
            <button type="button" class="btn btn-cancel" onclick="location.href='/reference/list'">ì·¨ì†Œ</button>
            <button type="submit" class="btn btn-submit">?“±ë¡?</button>
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
      const fileName = this.files.length > 0 ? this.files[0].name : "?„ ?ƒ?œ ?ŒŒ?¼ ?—†?Œ";
      document.getElementById("fileName").textContent = fileName;
    });

    function validateForm() {
      const title = document.getElementById("archiveTitle").value.trim();
      const content = document.getElementById("archiveContent").value.trim();
      if (!title) {
        alert("? œëª©ì„ ?…? ¥?•´ì£¼ì„¸?š”.");
        document.getElementById("archiveTitle").focus();
        return false;
      }
      if (!content) {
        alert("?‚´?š©?„ ?…? ¥?•´ì£¼ì„¸?š”.");
        document.getElementById("archiveContent").focus();
        return false;
      }
      return true;
    }
  </script>
</body>
</html>
