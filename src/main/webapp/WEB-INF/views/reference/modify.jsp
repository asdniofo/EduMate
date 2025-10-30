<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?���? ?��?��</title>
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
        공�??��?��
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?��료실 ?��?���?">
        </div>
	</section>
<div class="container">
<c:choose>
<c:when test="${empty reference}">
<div class="no-data">
<p>?���??�� ?��료�?? 찾을 ?�� ?��?��?��?��.</p>
<a href="/reference/list" class="btn btn-secondary">목록?���? ?��?���?�?</a>
</div>
</c:when>
<c:otherwise>
<div class="form-wrapper">
<h1>?���? ?��?��</h1>

<form action="/reference/modify" method="post" enctype="multipart/form-data">
    <input type="hidden" name="archiveNo" value="${reference.archiveNo}" />
    
    <!-- 카테고리 ?��?�� -->
    <div class="form-group">
        <label for="archiveType">카테고리<span class="required">*</span></label>
        <select id="archiveType" name="archiveType" required>
            <option value="">카테고리�? ?��?��?��?��?��</option>
            <option value="강의 ?���?" ${reference.archiveType == '강의 ?���?' ? 'selected' : ''}>강의 ?���?</option>
            <option value="기�? ?���?" ${reference.archiveType == '기�? ?���?' ? 'selected' : ''}>기�? ?���?</option>
        </select>
    </div>

    <!-- ?���? ?��?�� -->
    <div class="form-group">
        <label for="archiveTitle">?���?<span class="required">*</span></label>
        <input type="text" id="archiveTitle" name="archiveTitle" 
               value="${reference.archiveTitle}" 
               placeholder="?��목을 ?��?��?��?��?��" required />
    </div>

    <!-- ?��?�� ?��?�� -->
    <div class="form-group">
        <label for="archiveContent">?��?��<span class="required">*</span></label>
        <textarea id="archiveContent" name="archiveContent" 
                  placeholder="?��?��?�� ?��?��?��?��?��" required>${reference.archiveContent}</textarea>
    </div>

    <!-- 첨�??��?�� -->
    <div class="form-group">
        <label for="reloadFile">첨�??��?��</label>
        <c:if test="${not empty reference.attachmentName}">
            <div class="current-file">
                <strong>?��?�� ?��?��:</strong> ?��? ${reference.attachmentName}
            </div>
        </c:if>
        <input type="file" id="reloadFile" name="reloadFile" />
        <p class="file-help-text">* ?�� ?��?��?�� ?��?��?���? 기존 ?��?��?�� 교체?��?��?��.</p>
    </div>

    <!-- 게시 ?���? -->
    <div class="form-group">
        <label for="boardYn">게시 ?���?<span class="required">*</span></label>
        <select id="boardYn" name="boardYn" required>
            <option value="Y" ${reference.boardYn == 'Y' ? 'selected' : ''}>공개</option>
            <option value="N" ${reference.boardYn == 'N' ? 'selected' : ''}>비공�?</option>
        </select>
    </div>

    <!-- ?��?�� ?���? -->
    <div class="form-group">
        <div class="form-info-box">
            <div class="info-row">
                <span><strong>?��?��?��:</strong> ${reference.memberId}</span>
                <span><strong>?��?��?��:</strong> <fmt:formatDate value="${reference.writeDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                <span><strong>조회?��:</strong> ${reference.viewCount}</span>
            </div>
        </div>
    </div>

    <!-- 버튼 -->
    <div class="action-buttons">
        <button type="submit" class="btn btn-primary">?��?�� ?���?</button>
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