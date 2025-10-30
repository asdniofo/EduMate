<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?���? ?��?��조회</title>
<link rel="stylesheet" href="../resources/css/reference/detail.css">
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
  	<jsp:include page="../common/header.jsp" />
	<!-- 메인 배너 -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ?���? ?��?��?���?
    </div>
    <div class="object">
        <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?��료실 ?��?���?">
    </div>
	</section>
<div class="container">
<c:choose>
<c:when test="${empty reference}">
<div class="content-wrapper no-data">
<p>?���??�� ?��료�?? 찾을 ?�� ?��?��?��?��.</p>
<a href="/reference/list" class="btn btn-secondary" style="margin-top: 20px;">목록?���? ?��?���?�?</a>
</div>
</c:when>
<c:otherwise>
<!-- Header -->
<div class="header">
<div style="margin-bottom: 10px;">
<span class="category-badge">${reference.archiveType}</span>
</div>
<h1>${reference.archiveTitle}</h1>
<div class="header-info">
<div class="header-meta">
<span>?��?��?��: <strong>${reference.memberId}</strong></span>
<span>?��?��?��: <strong><fmt:formatDate value="${reference.writeDate}" pattern="yyyy.MM.dd HH:mm"/></strong></span>
<span>조회?��: <strong>${reference.viewCount}</strong></span>
</div>
</div>
</div>


<!-- Content -->
<div class="content-wrapper">
<h2>?��?��</h2>
<div class="content-body">
${reference.archiveContent}
</div>

<!-- Attachment -->
<c:if test="${not empty reference.attachmentName}">
<div class="attachment-section">
<h3>첨�??��?��</h3>
<div class="attachment-item">
<a href="${reference.attachmentPath}" download>
?��? ${reference.attachmentName}
</a>
</div>
</div>
</c:if>

<!-- Action Buttons -->
<div class="action-buttons">
<a href="/reference/list" class="btn btn-secondary">목록</a>
<!-- ?��?��/?��?�� 버튼: ?��?��?�� 본인 ?��?�� �?리자�? ?��?�� -->
<c:if test="${canModify}">
<a href="/reference/modify?archiveNo=${reference.archiveNo}" class="btn btn-primary">?��?��</a>
<a href="/reference/delete?archiveNo=${reference.archiveNo}" class="btn btn-danger" onclick="return confirm('?���? ?��?��?��?��겠습?���??');">?��?��</a>
</c:if>
</div>
</div>
</c:otherwise>
</c:choose>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>