<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>?Çò?ùò ?åìÍ∏? | EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/member/mycomment.css">
    <link rel="stylesheet" href="/resources/css/common/main_banner.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />
        <section class="main-banner">
            <div class="banner-text">
                ?Çò?ùò ?åìÍ∏?
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/postcomment.png" alt="?Çò?ùò ?åìÍ∏? ?ïÑ?ù¥ÏΩ?">
            </div>
        </section>

        <!-- Î©îÏù∏ ÏΩòÌÖêÏ∏? -->
        <div class="main-content">
            <div class="mycomment-content">
                <a href="/member/mypage" class="back-btn">?Üê ÎßàÏù¥?éò?ù¥Ïß?Î°? ?èå?ïÑÍ∞?Í∏?</a>
                
                <!-- ?Çò?ùò ?åìÍ∏? ?Ñπ?Öò -->
                <div class="mycomment-section">
                    <div class="section-header">
                        <h2 class="section-title">?Çò?ùò ?ûë?Ñ±?åìÍ∏?</h2>
                        <div class="stats-info">
                            Ï¥? <strong>${totalComments}</strong>Í∞úÏùò ?åìÍ∏?
                        </div>
                    </div>
                    
                    <!-- Í≤??Éâ Î∞ïÏä§ -->
                    <form action="/member/mycomment" method="get">
                        <div class="search-box">
                            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="?åìÍ∏? ?Ç¥?ö©?ù¥?Çò ?õêÍ∏? ?†úÎ™©ÏúºÎ°? Í≤??Éâ...">
                            <button type="submit">?üî?</button>
                        </div>
                    </form>
                    
                    <!-- ?åìÍ∏? Î™©Î°ù -->
                    <div class="comment-list" id="commentList">
                        <c:choose>
                            <c:when test="${not empty myComments}">
                                <c:forEach items="${myComments}" var="comment">
                                    <div class="comment-item" onclick="goToParentPost('${comment.parentPostType}', ${comment.parentPostNo})">
                                        <div class="comment-header">
                                            <c:choose>
                                                <c:when test="${comment.commentType == 'REQUEST'}">
                                                    <span class="comment-type-badge comment-type-request">Í±¥Ïùò?Ç¨?ï≠ ?åìÍ∏?</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="comment-type-badge comment-type-question">ÏßàÎ¨∏ ?åìÍ∏?</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <span class="comment-date">
                                                <fmt:formatDate value="${comment.writeDate}" pattern="yyyy-MM-dd HH:mm" />
                                            </span>
                                        </div>
                                        
                                        <!-- ?õêÍ∏? ?†ïÎ≥? -->
                                        <div class="parent-post">
                                            <div class="parent-post-label">
                                                <c:choose>
                                                    <c:when test="${comment.parentPostType == 'REQUEST'}">?åìÍ∏??ùÑ ?ûë?Ñ±?ïú Í±¥Ïùò?Ç¨?ï≠:</c:when>
                                                    <c:otherwise>?åìÍ∏??ùÑ ?ûë?Ñ±?ïú ÏßàÎ¨∏:</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="parent-post-title">${comment.parentPostTitle}</div>
                                        </div>
                                        
                                        <!-- Íµ¨Î∂Ñ?Ñ† -->
                                        <div class="divider"></div>
                                        
                                        <!-- ?åìÍ∏? ?Ç¥?ö© -->
                                        <div class="comment-content">
                                            <c:choose>
                                                <c:when test="${fn:length(comment.commentContent) > 100}">
                                                    ${fn:substring(comment.commentContent, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${comment.commentContent}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="no-comments">
                                    <c:choose>
                                        <c:when test="${not empty searchKeyword}">
                                            '${searchKeyword}' Í≤??Éâ Í≤∞Í≥ºÍ∞? ?óÜ?äµ?ãà?ã§.
                                        </c:when>
                                        <c:otherwise>
                                            ?ûë?Ñ±?ïú ?åìÍ∏??ù¥ ?óÜ?äµ?ãà?ã§.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- ?éò?ù¥Ïß??Ñ§?ù¥?Öò -->
                    <c:if test="${maxPage > 1}">
                        <div class="pagination-wrapper">
                            <div class="pagination">
                                <!-- ?ù¥?†Ñ Î≤ÑÌäº -->
                                <c:if test="${startNavi > 1}">
                                    <a href="/member/mycomment?page=${startNavi-1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?ù¥?†Ñ</a>
                                </c:if>
                                
                                <!-- ?éò?ù¥Ïß? Î≤àÌò∏ -->
                                <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                                    <a href="/member/mycomment?page=${n}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" 
                                       class="page-btn <c:if test='${currentPage eq n}'>active</c:if>">
                                        ${n}
                                    </a>
                                </c:forEach>
                                
                                <!-- ?ã§?ùå Î≤ÑÌäº -->
                                <c:if test="${endNavi < maxPage}">
                                    <a href="/member/mycomment?page=${endNavi+1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?ã§?ùå</a>
                                </c:if>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        // ?õêÍ∏?Î°? ?ù¥?èô
        function goToParentPost(postType, postNo) {
            if (postType === 'REQUEST') {
                window.location.href = '/member/request/detail?requestNo=' + postNo;
            } else if (postType === 'QUESTION') {
                window.location.href = '/teacher/question/detail?questionNo=' + postNo;
            }
        }

        // ?éò?ù¥Ïß? Î°úÎìú ?ãú ?ã§?ñâ
        document.addEventListener('DOMContentLoaded', function() {
            console.log('?Çò?ùò ?åìÍ∏? ?éò?ù¥Ïß?Í∞? Î°úÎìú?êò?óà?äµ?ãà?ã§.');
            
            // Í≤??Éâ?ñ¥Í∞? ?ûà?ùÑ ?ïå ?ûÖ?†•Ï∞ΩÏóê ?è¨Ïª§Ïä§
            const searchInput = document.querySelector('input[name="searchKeyword"]');
            if (searchInput && searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>