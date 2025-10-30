<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>?•½ê´? ?™?˜</title>
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
            <div class="login-icon">?Ÿ“?</div>
            <h2>?•½ê´? ?™?˜</h2>
        </div>

        <div class="login-right">
            <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo.png">

            <div class="error-message" id="error-message">?•„?ˆ˜ ?•­ëª? ?™?˜ê°? ?•„?š”?•©?‹ˆ?‹¤.</div>

            <form id="terms-form" action="/member/signup/info" method="get">
                <div class="terms-list">

                    <!-- ? „ì²? ?™?˜ -->
                    <label class="terms-item all-agree">
                        <input type="checkbox" id="agreeAll">
                        <span><strong>? „ì²? ?•½ê´??— ?™?˜?•©?‹ˆ?‹¤.</strong></span>
                    </label>

                    <!-- ?•„?ˆ˜ ?•½ê´? -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms1" class="required-term">
                            <span>ê°œì¸? •ë³? ?´?š©?•½ê´??— ?™?˜?•©?‹ˆ?‹¤.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="1">?•½ê´??™•?¸</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms2" class="required-term">
                            <span>?„œë¹„ìŠ¤ ?´?š©?•½ê´??— ?™?˜?•©?‹ˆ?‹¤.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="2">?•½ê´??™•?¸</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms3" class="required-term">
                            <span>?œ„ì¹˜ê¸°ë°? ?„œë¹„ìŠ¤ ?´?š©?•½ê´??— ?™?˜?•©?‹ˆ?‹¤.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="3">?•½ê´??™•?¸</a>
                    </div>

                    <!-- ?„ ?ƒ ?•½ê´? -->
                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms4">
                            <span>(?„ ?ƒ) ë§ˆì??Œ… ? •ë³? ?ˆ˜?‹ ?— ?™?˜?•©?‹ˆ?‹¤.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="4">?•½ê´??™•?¸</a>
                    </div>

                    <div class="terms-row">
                        <label class="terms-item">
                            <input type="checkbox" name="terms5">
                            <span>(?„ ?ƒ) ë§žì¶¤?˜• ê´‘ê³  ?ˆ˜?‹ ?— ?™?˜?•©?‹ˆ?‹¤.</span>
                        </label>
                        <a href="#" class="terms-link" data-terms="5">?•½ê´??™•?¸</a>
                    </div>
                </div>

                <button type="submit" id="next-btn" class="btn-next" onclick="location.href='/info'">?‹¤?Œ</button>
            </form>
        </div>
    </div>
</section>

<!-- ?Ÿ“? ?•½ê´? ?Œ?—… ëª¨ë‹¬ -->
<div id="terms-modal" class="modal">
    <div class="modal-content">
        <h2 id="modal-title">?•½ê´? ? œëª?</h2>
        <div id="modal-text" class="modal-text">?•½ê´? ?‚´?š©?´ ?—¬ê¸°ì— ?‘œ?‹œ?©?‹ˆ?‹¤.</div>
        <button id="modal-close" class="btn-close">?‹«ê¸?</button>
    </div>
</div>

    <jsp:include page="../common/footer.jsp" />
</body>