<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>? •ë³´ì°¾ê¸? | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/find_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>

<body>
<!-- Header -->
<jsp:include page="../common/header.jsp" />

<!-- Find Info -->
<section class="login-container">
    <div class="login-box">
        <!-- ?™¼ìª? ?˜?—­ -->
        <div class="login-left">
            <div class="login-icon">?Ÿ”?</div>
            <h2>? •ë³? ì°¾ê¸°</h2>
        </div>

        <!-- ?˜¤ë¥¸ìª½ ?˜?—­ -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

        <h2>?•„?´?”” ì°¾ê¸° ê²°ê³¼</h2>
        <c:choose>
        <c:when test="${not empty foundId}">
            <p>?šŒ?›?‹˜?˜ ?•„?´?””?Š” <strong>${foundId}</strong> ?ž…?‹ˆ?‹¤.</p>
            <a href="/member/login">ë¡œê·¸?¸?•˜?Ÿ¬ ê°?ê¸?</a>
        </c:when>
        <c:otherwise>
            <p>?¼ì¹˜í•˜?Š” ?šŒ?› ? •ë³´ë?? ì°¾ì„ ?ˆ˜ ?—†?Šµ?‹ˆ?‹¤.</p>
            <a href="/member/find">?‹¤?‹œ ?‹œ?„</a>
        </c:otherwise>
        </c:choose>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>
