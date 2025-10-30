<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그?�� | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/login.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>
<!-- JavaScript -->
<script src="/resources/js/member/login.js"></script>
<body>
<!-- Header -->
    <jsp:include page="../common/header.jsp" />
<!-- Login -->
<section class="login-container">
    <div class="login-box">
        <div class="login-left">
            <div class="login-icon">?��?</div>
            <h2>로그?��</h2>
        </div>

        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">
            <div class="error-message" id="error-message"></div>

            <form id="login-form" action="/member/login" method="post">
                <input type="text" name="memberId" placeholder="?��?��?��">
                <input type="password" name="memberPw" placeholder="비�?번호">
                
                <c:if test="${param.error == 1}">
        			<p style="color:red;">?��?��?�� ?��?�� 비�?번호�? ?��못되?��?��?��?��.</p>
    			</c:if>

                <button type="submit" class="btn-login">로그?��</button>
            </form>

            <button type="button" class="btn-join" onclick="location.href='signup/terms'">?��?���??��</button>
            <p class="find-info">
                <a href="/member/find">?��?��?�� / 비�?번호�? ?��?��버렸?��?��?��.</a>
            </p>
        </div>
    </div>
</section>
<!-- Footer -->
    <jsp:include page="../common/footer.jsp" />
</body>
</html>
