<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?ë£? ?ƒ?„¸ì¡°íšŒ</title>
<link rel="stylesheet" href="../resources/css/reference/detail.css">
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
</head>
<body>
  	<jsp:include page="../common/header.jsp" />
	<!-- ë©”ì¸ ë°°ë„ˆ -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ?ë£? ?ƒ?„¸? •ë³?
    </div>
    <div class="object">
        <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?ë£Œì‹¤ ?•„?´ì½?">
    </div>
	</section>
<div class="container">
<c:choose>
<c:when test="${empty reference}">
<div class="content-wrapper no-data">
<p>?š”ì²??•œ ?ë£Œë?? ì°¾ì„ ?ˆ˜ ?—†?Šµ?‹ˆ?‹¤.</p>
<a href="/reference/list" class="btn btn-secondary" style="margin-top: 20px;">ëª©ë¡?œ¼ë¡? ?Œ?•„ê°?ê¸?</a>
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
<span>?‘?„±?: <strong>${reference.memberId}</strong></span>
<span>?‘?„±?¼: <strong><fmt:formatDate value="${reference.writeDate}" pattern="yyyy.MM.dd HH:mm"/></strong></span>
<span>ì¡°íšŒ?ˆ˜: <strong>${reference.viewCount}</strong></span>
</div>
</div>
</div>


<!-- Content -->
<div class="content-wrapper">
<h2>?‚´?š©</h2>
<div class="content-body">
${reference.archiveContent}
</div>

<!-- Attachment -->
<c:if test="${not empty reference.attachmentName}">
<div class="attachment-section">
<h3>ì²¨ë??ŒŒ?¼</h3>
<div class="attachment-item">
<a href="${reference.attachmentPath}" download>
?Ÿ“? ${reference.attachmentName}
</a>
</div>
</div>
</c:if>

<!-- Action Buttons -->
<div class="action-buttons">
<a href="/reference/list" class="btn btn-secondary">ëª©ë¡</a>
<!-- ?ˆ˜? •/?‚­? œ ë²„íŠ¼: ?‘?„±? ë³¸ì¸ ?˜?Š” ê´?ë¦¬ìë§? ?‘œ?‹œ -->
<c:if test="${canModify}">
<a href="/reference/modify?archiveNo=${reference.archiveNo}" class="btn btn-primary">?ˆ˜? •</a>
<a href="/reference/delete?archiveNo=${reference.archiveNo}" class="btn btn-danger" onclick="return confirm('? •ë§? ?‚­? œ?•˜?‹œê² ìŠµ?‹ˆê¹??');">?‚­? œ</a>
</c:if>
</div>
</div>
</c:otherwise>
</c:choose>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>