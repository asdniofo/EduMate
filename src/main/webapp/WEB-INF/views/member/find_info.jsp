<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?†ïÎ≥¥Ï∞æÍ∏? | EduMate</title>
    <!-- CSS -->
    <link rel="stylesheet" href="/resources/css/member/find_info.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>
<!-- JavaScript -->
<script src="/resources/js/member/find_info.js"></script>
<body>
<!-- Header -->
<jsp:include page="../common/header.jsp" />

<!-- Find Info -->
<section class="login-container">
    <div class="login-box">
        <!-- ?ôºÏ™? ?òÅ?ó≠ -->
        <div class="login-left">
            <div class="login-icon">?üî?</div>
            <h2>?†ïÎ≥? Ï∞æÍ∏∞</h2>
        </div>

        <!-- ?ò§Î•∏Ï™Ω ?òÅ?ó≠ -->
        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

            <!-- ?ÉÅ?ã® ?É≠ -->
            <div class="tab-container">
                <button class="tab-btn active" id="tab-id">?ïÑ?ù¥?îî</button>
                <button class="tab-btn" id="tab-pw">ÎπÑÎ?Î≤àÌò∏</button>
            </div>
            <c:choose>
        <c:when test="${empty foundId}">
            <p>${msg }</p>
        </c:when>
        <c:when test="${empty foundPw}">
            <p>${msg }</p>
        </c:when>
        </c:choose>

            <!-- ?ïÑ?ù¥?îî Ï∞æÍ∏∞ ?èº -->
            <form id="find-id-form" class="form-section active" method="post" action="/member/findId">
                <input type="text" name="memberName" placeholder="?ù¥Î¶?" required>
                <input type="date" name="memberBirth" placeholder="?Éù?ÖÑ?õî?ùº" required>
                <input type="email" name="memberEmail" placeholder="?ù¥Î©îÏùº" required>
                <button type="submit" class="btn-login">Ï∞æÍ∏∞</button>
            </form>

            <!-- ÎπÑÎ?Î≤àÌò∏ Ï∞æÍ∏∞ ?èº -->
            <form id="find-pw-form" class="form-section" method="post" action="/member/findPw">
                <input type="text" name="memberId" placeholder="?ïÑ?ù¥?îî" required>
                <input type="email" name="memberEmail" placeholder="?ù¥Î©îÏùº" required>
                <button type="submit" class="btn-login">Ï∞æÍ∏∞</button>
            </form>
        </div>
    </div>
</section>

<!-- Footer -->
<jsp:include page="../common/footer.jsp" />
</body>
</html>
