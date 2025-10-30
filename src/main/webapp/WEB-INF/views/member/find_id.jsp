<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?��보찾�? | EduMate</title>
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
        <!-- ?���? ?��?�� -->
        <div class="login-left">
            <div class="login-icon">?��?</div>
            <h2>?���? 찾기</h2>
        </div>

        <!-- ?��른쪽 ?��?�� -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

        <h2>?��?��?�� 찾기 결과</h2>
        <c:choose>
        <c:when test="${not empty foundId}">
            <p>?��?��?��?�� ?��?��?��?�� <strong>${foundId}</strong> ?��?��?��.</p>
            <a href="/member/login">로그?��?��?�� �?�?</a>
        </c:when>
        <c:otherwise>
            <p>?��치하?�� ?��?�� ?��보�?? 찾을 ?�� ?��?��?��?��.</p>
            <a href="/member/find">?��?�� ?��?��</a>
        </c:otherwise>
        </c:choose>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>
