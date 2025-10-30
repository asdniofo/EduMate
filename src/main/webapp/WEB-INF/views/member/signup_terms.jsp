<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>약관 동의</title>
    <link rel="stylesheet" href="/resources/css/member/signup_terms.css">
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
</head>
<!-- JavaScript -->
<script src="/resources/js/member/signup_terms.js"></script>
<body>
    <jsp:include page="../common/header.jsp" />

<section class="login-container">
    <div class="login-box">
        <div class="login-left">
            <div class="login-icon">📝</div>
            <h2>약관 동의</h2>
        </div>

        <div class="login-right">
            <img class="login-logo" src="${pageContext.request.contextPath}/resources/images/common/logo.png">

            <div class="error-message" id="error-message">필수 항목 동의가 필요합니다.</div>

            <form id="terms-form" action="/member/signup/info" method="get">
                <div class="terms-list">

                    <!-- 전체 동의 -->
                    <label class="terms-item all-agree">
                        <input type="checkbox" id="agreeAll">
                        <span><strong>전체 약관에 동의합니다.</strong></span>
                    </label>

                    <!-- 필수 약관 -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms1" class="required-term">
                            <span>개인정보 이용약관에 동의합니다.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="1">약관확인</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms2" class="required-term">
                            <span>서비스 이용약관에 동의합니다.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="2">약관확인</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms3" class="required-term">
                            <span>위치기반 서비스 이용약관에 동의합니다.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="3">약관확인</a>
                    </div>

                    <!-- 선택 약관 -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms4">
                            <span>(선택) 마케팅 정보 수신에 동의합니다.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="4">약관확인</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms5">
                            <span>(선택) 맞춤형 광고 수신에 동의합니다.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="5">약관확인</a>
                    </div>
                </div>

                <button type="submit" id="next-btn" class="btn-next" onclick="location.href='/info'">다음</button>
            </form>
        </div>
    </div>
</section>

<!-- 📄 약관 팝업 모달 -->
<div id="terms-modal" class="modal">
    <div class="modal-content">
        <h2 id="modal-title">약관 제목</h2>
        <div id="modal-text" class="modal-text">약관 내용이 여기에 표시됩니다.</div>
        <button id="modal-close" class="btn-close">닫기</button>
    </div>
</div>

    <jsp:include page="../common/footer.jsp" />
</body>