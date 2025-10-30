<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?���? ?��?��</title>
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
            <div class="login-icon">?��?</div>
            <h2>?���? ?��?��</h2>
        </div>

        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

            <div class="error-message" id="error-message">?��?�� ?���? ?��?���? ?��?��?��?��?��.</div>

            <form id="terms-form" action="/member/signup/info" method="get">
                <div class="terms-list">

                    <!-- ?���? ?��?�� -->
                    <label class="terms-item all-agree">
                        <input type="checkbox" id="agreeAll">
                        <span><strong>?���? ?���??�� ?��?��?��?��?��.</strong></span>
                    </label>

                    <!-- ?��?�� ?���? -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms1" class="required-term">
                            <span>개인?���? ?��?��?���??�� ?��?��?��?��?��.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="1">?���??��?��</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms2" class="required-term">
                            <span>?��비스 ?��?��?���??�� ?��?��?��?��?��.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="2">?���??��?��</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms3" class="required-term">
                            <span>?��치기�? ?��비스 ?��?��?���??�� ?��?��?��?��?��.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="3">?���??��?��</a>
                    </div>

                    <!-- ?��?�� ?���? -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms4">
                            <span>(?��?��) 마�??�� ?���? ?��?��?�� ?��?��?��?��?��.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="4">?���??��?��</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms5">
                            <span>(?��?��) 맞춤?�� 광고 ?��?��?�� ?��?��?��?��?��.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="5">?���??��?��</a>
                    </div>
                </div>

                <button type="submit" id="next-btn" class="btn-next" onclick="location.href='/info'">?��?��</button>
            </form>
        </div>
    </div>
</section>

<!-- ?��? ?���? ?��?�� 모달 -->
<div id="terms-modal" class="modal">
    <div class="modal-content">
        <h2 id="modal-title">?���? ?���?</h2>
        <div id="modal-text" class="modal-text">?���? ?��?��?�� ?��기에 ?��?��?��?��?��.</div>
        <button id="modal-close" class="btn-close">?���?</button>
    </div>
</div>

    <jsp:include page="../common/footer.jsp" />
</body>