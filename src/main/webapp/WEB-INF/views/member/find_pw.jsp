<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>정보찾기 | EduMate</title>
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
        <!-- 왼쪽 영역 -->
        <div class="login-left">
            <div class="login-icon">🔍</div>
            <h2>정보 찾기</h2>
        </div>

        <!-- 오른쪽 영역 -->
        <div class="login-right">
            <h1 class="login-logo">■ LOGO</h1>

      <h2>비밀번호 재설정</h2>
<form id="signupForm" action="/member/login" method="post">
	<div class="form-group">
		<label for="memberId">아이디</label>
		<input type="text" name="memberId" value="${memberId}" readonly>
	</div>
    <div class="form-group">
        <label for="memberPw">비밀번호</label>
        <input type="password" id="memberPw" name="memberPw" placeholder="비밀번호 입력" required>
    </div>

    <div class="form-group">
        <label for="memberPwCheck">비밀번호 재입력</label>
        <input type="password" id="memberPwCheck" name="memberPwCheck" placeholder="비밀번호 재입력" required>
        <p id="pw-error" class="error-text">비밀번호가 일치하지 않습니다.</p>
    </div>

    <button id="next-btn" type="submit">변경</button>
</form>
</section>

<div class="modal-overlay" id="modal">
    <div class="modal">
        <h3>비밀번호가 성공적으로 변경되었습니다.</h3>
        <button id="confirmBtn">확인</button>
    </div>
</div>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />

</body>
</html>
