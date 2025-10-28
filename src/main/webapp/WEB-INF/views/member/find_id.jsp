<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정보찾기 | EduMate</title>
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
        <!-- 왼쪽 영역 -->
        <div class="login-left">
            <div class="login-icon">🔍</div>
            <h2>정보 찾기</h2>
        </div>

        <!-- 오른쪽 영역 -->
        <div class="login-right">
            <img class="login-logo" src="${pageContext.request.contextPath}/resources/images/common/logo.png">

        <h2>아이디 찾기 결과</h2>
        <c:choose>
        <c:when test="${not empty foundId}">
            <p>회원님의 아이디는 <strong>${foundId}</strong> 입니다.</p>
            <a href="/member/login">로그인하러 가기</a>
        </c:when>
        <c:otherwise>
            <p>일치하는 회원 정보를 찾을 수 없습니다.</p>
            <a href="/member/find">다시 시도</a>
        </c:otherwise>
        </c:choose>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>
