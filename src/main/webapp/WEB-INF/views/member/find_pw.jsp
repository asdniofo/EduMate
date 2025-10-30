<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?��보찾�? | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/find_pw.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <body>
    <script src="/resources/js/member/find_pw.js"></script>
</head>
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

      <h2>비�?번호 ?��?��?��</h2>
<form id="signupForm" action="/member/updatePw" method="post">
	<div class="form-group">
		<label for="memberId">?��?��?��</label>
		<input type="text" name="memberId" value="${memberId}" readonly>
	</div>
    <div class="form-group">
        <label for="memberPw">비�?번호</label>
        <input type="password" id="memberPw" name="memberPw" placeholder="비�?번호 ?��?��" required>
    </div>

    <div class="form-group">
        <label for="memberPwCheck">비�?번호 ?��?��?��</label>
        <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="비�?번호 ?��?��?��" required>
        <p id="pw-error" class="error-text">비�?번호�? ?��치하�? ?��?��?��?��.</p>
    </div>

    <button id="next-btn" type="submit">�?�?</button>
</form>
</section>

<div class="modal-overlay" id="modal">
    <div class="modal">
        <h3>비�?번호�? ?��공적?���? �?경되?��?��?��?��.</h3>
        <button id="confirmBtn">?��?��</button>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />

</body>
</html>
