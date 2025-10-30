<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?žë£? ?ˆ˜? •</title>
<link rel="stylesheet" href="../resources/css/reference/modify.css">
<link rel="stylesheet" href="/resources/css/common/header.css" />
<link rel="stylesheet" href="/resources/css/common/footer.css" />
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
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?žë£Œì‹¤ ?•„?´ì½?">
        </div>
	</section>
<div class="container">
<c:choose>
<c:when test="${empty reference}">
<div class="no-data">
<p>?š”ì²??•œ ?žë£Œë?? ì°¾ì„ ?ˆ˜ ?—†?Šµ?‹ˆ?‹¤.</p>
<a href="/reference/list" class="btn btn-secondary">ëª©ë¡?œ¼ë¡? ?Œ?•„ê°?ê¸?</a>
</div>
</c:when>
<c:otherwise>
<div class="form-wrapper">
<h1>?žë£? ?ˆ˜? •</h1>

<form action="/reference/modify" method="post" enctype="multipart/form-data">
    <input type="hidden" name="archiveNo" value="${reference.archiveNo}" />
    
    <!-- ì¹´í…Œê³ ë¦¬ ?„ ?ƒ -->
    <div class="form-group">
        <label for="archiveType">ì¹´í…Œê³ ë¦¬<span class="required">*</span></label>
        <select id="archiveType" name="archiveType" required>
            <option value="">ì¹´í…Œê³ ë¦¬ë¥? ?„ ?ƒ?•˜?„¸?š”</option>
            <option value="ê°•ì˜ ?žë£?" ${reference.archiveType == 'ê°•ì˜ ?žë£?' ? 'selected' : ''}>ê°•ì˜ ?žë£?</option>
            <option value="ê¸°í? ?žë£?" ${reference.archiveType == 'ê¸°í? ?žë£?' ? 'selected' : ''}>ê¸°í? ?žë£?</option>
        </select>
    </div>

    <!-- ? œëª? ?ž…? ¥ -->
    <div class="form-group">
        <label for="archiveTitle">? œëª?<span class="required">*</span></label>
        <input type="text" id="archiveTitle" name="archiveTitle" 
               value="${reference.archiveTitle}" 
               placeholder="? œëª©ì„ ?ž…? ¥?•˜?„¸?š”" required />
    </div>

    <!-- ?‚´?š© ?ž…? ¥ -->
    <div class="form-group">
        <label for="archiveContent">?‚´?š©<span class="required">*</span></label>
        <textarea id="archiveContent" name="archiveContent" 
                  placeholder="?‚´?š©?„ ?ž…? ¥?•˜?„¸?š”" required>${reference.archiveContent}</textarea>
    </div>

    <!-- ì²¨ë??ŒŒ?¼ -->
    <div class="form-group">
        <label for="reloadFile">ì²¨ë??ŒŒ?¼</label>
        <c:if test="${not empty reference.attachmentName}">
            <div class="current-file">
                <strong>?˜„?ž¬ ?ŒŒ?¼:</strong> ?Ÿ“? ${reference.attachmentName}
            </div>
        </c:if>
        <input type="file" id="reloadFile" name="reloadFile" />
        <p class="file-help-text">* ?ƒˆ ?ŒŒ?¼?„ ?„ ?ƒ?•˜ë©? ê¸°ì¡´ ?ŒŒ?¼?´ êµì²´?©?‹ˆ?‹¤.</p>
    </div>

    <!-- ê²Œì‹œ ?—¬ë¶? -->
    <div class="form-group">
        <label for="boardYn">ê²Œì‹œ ?—¬ë¶?<span class="required">*</span></label>
        <select id="boardYn" name="boardYn" required>
            <option value="Y" ${reference.boardYn == 'Y' ? 'selected' : ''}>ê³µê°œ</option>
            <option value="N" ${reference.boardYn == 'N' ? 'selected' : ''}>ë¹„ê³µê°?</option>
        </select>
    </div>

    <!-- ?ž‘?„± ? •ë³? -->
    <div class="form-group">
        <div class="form-info-box">
            <div class="info-row">
                <span><strong>?ž‘?„±?ž:</strong> ${reference.memberId}</span>
                <span><strong>?ž‘?„±?¼:</strong> <fmt:formatDate value="${reference.writeDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                <span><strong>ì¡°íšŒ?ˆ˜:</strong> ${reference.viewCount}</span>
            </div>
        </div>
    </div>

    <!-- ë²„íŠ¼ -->
    <div class="action-buttons">
        <button type="submit" class="btn btn-primary">?ˆ˜? • ?™„ë£?</button>
        <a href="/reference/detail?archiveNo=${reference.archiveNo}" class="btn btn-secondary">ì·¨ì†Œ</a>
    </div>
</form>
</div>
</c:otherwise>
</c:choose>
</div>
<jsp:include page="../common/footer.jsp" />
</body>
</html>