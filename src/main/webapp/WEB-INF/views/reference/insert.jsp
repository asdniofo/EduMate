<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료실 작성</title>
    <link rel="stylesheet" href="../resources/css/reference/insert.css">
    <link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    <div class="reference-write-container">
        <h1 class="page-title">자료실 작성</h1>
        
        <form action="${pageContext.request.contextPath}/reference/insert" 
              method="post" 
              enctype="multipart/form-data"
              onsubmit="return validateForm()">
            
            <!-- 제목 -->
            <div class="form-group">
                <label class="form-label" for="archiveTitle">제목</label>
                <input type="text" 
                       id="archiveTitle" 
                       name="archiveTitle" 
                       class="form-input" 
                       placeholder="제목을 입력해주세요."
                       required>
            </div>

            <!-- 유형 -->
            <div class="form-group">
                <label class="form-label">유형</label>
                <div class="tag-group">
                    <input type="radio" 
                           id="tag1" 
                           name="archiveType" 
                           value="강의 자료" 
                           class="tag-radio"
                           checked>
                    <label for="tag1" class="tag-label">강의 자료</label>
                    
                    <input type="radio" 
                           id="tag2" 
                           name="archiveType" 
                           value="기타 자료" 
                           class="tag-radio">
                    <label for="tag2" class="tag-label">기타 자료</label>
                </div>
            </div>

            <!-- 본문 -->
            <div class="form-group">
                <label class="form-label" for="archiveContent">본문</label>
                <textarea id="archiveContent" 
                          name="archiveContent" 
                          class="form-textarea" 
                          placeholder="내용을 입력해주세요."
                          required></textarea>
            </div>

            <!-- 첨부파일 -->
            <div class="file-upload-section">
                <label class="file-upload-label">첨부파일</label>
                <div class="file-upload-wrapper">
                    <input type="file" 
                           id="uploadFile" 
                           name="uploadFile" 
                           class="file-input"
                           onchange="displayFileName()">
                    <label for="uploadFile" class="file-upload-btn">파일 선택</label>
                    <span id="fileNameDisplay" class="file-name-display">
                        첨부파일이 없습니다.
                    </span>
                </div>
            </div>

            <!-- 버튼 -->
            <div class="button-group">
                <button type="button" class="btn btn-cancel" onclick="history.back()">
                    취소
                </button>
                <button type="submit" class="btn btn-submit">
                    글쓰기
                </button>
            </div>
        </form>
    </div>
    <jsp:include page="../common/footer.jsp" />

    <script>
        // 파일명 표시 함수
        function displayFileName() {
            const fileInput = document.getElementById('uploadFile');
            const fileNameDisplay = document.getElementById('fileNameDisplay');
            
            if (fileInput.files.length > 0) {
                fileNameDisplay.textContent = fileInput.files[0].name;
            } else {
                fileNameDisplay.textContent = '첨부파일이 없습니다.';
            }
        }

        // 폼 유효성 검사
        function validateForm() {
            const title = document.getElementById('archiveTitle').value.trim();
            const content = document.getElementById('archiveContent').value.trim();

            if (title === '') {
                alert('제목을 입력해주세요.');
                document.getElementById('archiveTitle').focus();
                return false;
            }

            if (content === '') {
                alert('내용을 입력해주세요.');
                document.getElementById('archiveContent').focus();
                return false;
            }

            return true;
        }
    </script>

</body>
</html>