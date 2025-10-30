<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>? •ë³´ì°¾ê¸? | EduMate</title>
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
        <!-- ?™¼ìª? ?˜?—­ -->
        <div class="login-left">
            <div class="login-icon">?Ÿ”?</div>
            <h2>? •ë³? ì°¾ê¸°</h2>
        </div>

        <!-- ?˜¤ë¥¸ìª½ ?˜?—­ -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

      <h2>ë¹„ë?ë²ˆí˜¸ ?ž¬?„¤? •</h2>
<form id="signupForm" action="/member/updatePw" method="post">
	<div class="form-group">
		<label for="memberId">?•„?´?””</label>
		<input type="text" name="memberId" value="${memberId}" readonly>
	</div>
    <div class="form-group">
        <label for="memberPw">ë¹„ë?ë²ˆí˜¸</label>
        <input type="password" id="memberPw" name="memberPw" placeholder="ë¹„ë?ë²ˆí˜¸ ?ž…? ¥" required>
    </div>

    <div class="form-group">
        <label for="memberPwCheck">ë¹„ë?ë²ˆí˜¸ ?ž¬?ž…? ¥</label>
        <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="ë¹„ë?ë²ˆí˜¸ ?ž¬?ž…? ¥" required>
        <p id="pw-error" class="error-text">ë¹„ë?ë²ˆí˜¸ê°? ?¼ì¹˜í•˜ì§? ?•Š?Šµ?‹ˆ?‹¤.</p>
    </div>

    <button id="next-btn" type="submit">ë³?ê²?</button>
</form>
</section>

<div class="modal-overlay" id="modal">
    <div class="modal">
        <h3>ë¹„ë?ë²ˆí˜¸ê°? ?„±ê³µì ?œ¼ë¡? ë³?ê²½ë˜?—ˆ?Šµ?‹ˆ?‹¤.</h3>
        <button id="confirmBtn">?™•?¸</button>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />

</body>
</html>
