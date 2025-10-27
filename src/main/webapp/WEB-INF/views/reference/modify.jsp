<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료 수정</title>
<link rel="stylesheet" href="../resources/css/reference/modify.css">
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
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
        <img src="/resources/images/event/icon/event_icon.png" alt="이벤트 아이콘">
    </div>
	</section>
<div class="container">
<c:choose>
<c:when test="${empty reference}">
<div class="no-data">
<p>요청한 자료를 찾을 수 없습니다.</p>
<a href="/reference/list" class="btn btn-secondary">목록으로 돌아가기</a>
</div>
</c:when>
<c:otherwise>
<div class="form-wrapper">
<h1>자료 수정</h1>

<form action="/reference/modify" method="post" enctype="multipart/form-data">
    <input type="hidden" name="archiveNo" value="${reference.archiveNo}" />
    
    <!-- 카테고리 선택 -->
    <div class="form-group">
        <label for="archiveType">카테고리<span class="required">*</span></label>
        <select id="archiveType" name="archiveType" required>
            <option value="">카테고리를 선택하세요</option>
            <option value="강의 자료" ${reference.archiveType == '강의 자료' ? 'selected' : ''}>강의 자료</option>
            <option value="기타 자료" ${reference.archiveType == '기타 자료' ? 'selected' : ''}>기타 자료</option>
        </select>
    </div>

    <!-- 제목 입력 -->
    <div class="form-group">
        <label for="archiveTitle">제목<span class="required">*</span></label>
        <input type="text" id="archiveTitle" name="archiveTitle" 
               value="${reference.archiveTitle}" 
               placeholder="제목을 입력하세요" required />
    </div>

    <!-- 내용 입력 -->
    <div class="form-group">
        <label for="archiveContent">내용<span class="required">*</span></label>
        <textarea id="archiveContent" name="archiveContent" 
                  placeholder="내용을 입력하세요" required>${reference.archiveContent}</textarea>
    </div>

    <!-- 첨부파일 -->
    <div class="form-group">
        <label for="reloadFile">첨부파일</label>
        <c:if test="${not empty reference.attachmentName}">
            <div class="current-file">
                <strong>현재 파일:</strong> 📎 ${reference.attachmentName}
            </div>
        </c:if>
        <input type="file" id="reloadFile" name="reloadFile" />
        <p class="file-help-text">* 새 파일을 선택하면 기존 파일이 교체됩니다.</p>
    </div>

    <!-- 게시 여부 -->
    <div class="form-group">
        <label for="boardYn">게시 여부<span class="required">*</span></label>
        <select id="boardYn" name="boardYn" required>
            <option value="Y" ${reference.boardYn == 'Y' ? 'selected' : ''}>공개</option>
            <option value="N" ${reference.boardYn == 'N' ? 'selected' : ''}>비공개</option>
        </select>
    </div>

    <!-- 작성 정보 -->
    <div class="form-group">
        <div class="form-info-box">
            <div class="info-row">
                <span><strong>작성자:</strong> ${reference.memberId}</span>
                <span><strong>작성일:</strong> <fmt:formatDate value="${reference.writeDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                <span><strong>조회수:</strong> ${reference.viewCount}</span>
            </div>
        </div>
    </div>

    <!-- 버튼 -->
    <div class="action-buttons">
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="/reference/detail?archiveNo=${reference.archiveNo}" class="btn btn-secondary">취소</a>
    </div>
</form>
</div>
</c:otherwise>
</c:choose>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>