<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>?Çò?ùò Í∏? | EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/member/mypost.css">
    <link rel="stylesheet" href="/resources/css/common/main_banner.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />
        <section class="main-banner">
            <div class="banner-text">
                ?Çò?ùò Í∏?
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/postcomment.png" alt="?Çò?ùò Í∏? ?ïÑ?ù¥ÏΩ?">
            </div>
        </section>

        <!-- Î©îÏù∏ ÏΩòÌÖêÏ∏? -->
        <div class="main-content">
            <div class="mypost-content">
                <a href="/member/mypage" class="back-btn">?Üê ÎßàÏù¥?éò?ù¥Ïß?Î°? ?èå?ïÑÍ∞?Í∏?</a>
                
                <!-- ?Çò?ùò Í∏? ?Ñπ?Öò -->
                <div class="mypost-section">
                    <div class="section-header">
                        <h2 class="section-title">?Çò?ùò ?ûë?Ñ±Í∏?</h2>
                        <div class="stats-info">
                            Ï¥? <strong>${totalPosts}</strong>Í∞úÏùò Í∏?
                        </div>
                    </div>
                    
                    <!-- Í≤??Éâ Î∞ïÏä§ -->
                    <form action="/member/mypost" method="get">
                        <div class="search-box">
                            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="?†úÎ™©ÏúºÎ°? Í≤??Éâ...">
                            <button type="submit">?üî?</button>
                        </div>
                    </form>
                    
                    <!-- Í∏? Î™©Î°ù -->
                    <div class="post-list" id="postList">
                        <c:choose>
                            <c:when test="${not empty myPosts}">
                                <c:forEach items="${myPosts}" var="post">
                                    <div class="post-item" onclick="goToPost('${post.postType}', ${post.postNo})">
                                        <div class="post-header">
                                            <c:choose>
                                                <c:when test="${post.postType == 'REQUEST'}">
                                                    <span class="post-type-badge post-type-request">Í±¥Ïùò?Ç¨?ï≠</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge post-type-question">ÏßàÎ¨∏</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:choose>
                                                <c:when test="${post.status == 'Y'}">
                                                    <span class="post-status status-y">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">Ï≤òÎ¶¨?ôÑÎ£?</c:when>
                                                            <c:otherwise>?ï¥Í≤?</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-status status-n">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">Í≤??Ü†Ï§?</c:when>
                                                            <c:otherwise>ÎØ∏Ìï¥Í≤?</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <span class="post-date">
                                                <fmt:formatDate value="${post.writeDate}" pattern="yyyy-MM-dd" />
                                            </span>
                                        </div>
                                        <div class="post-title">${post.postTitle}</div>
                                        <div class="post-content">
                                            <c:choose>
                                                <c:when test="${fn:length(post.postContent) > 100}">
                                                    ${fn:substring(post.postContent, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${post.postContent}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="no-posts">
                                    <c:choose>
                                        <c:when test="${not empty searchKeyword}">
                                            '${searchKeyword}' Í≤??Éâ Í≤∞Í≥ºÍ∞? ?óÜ?äµ?ãà?ã§.
                                        </c:when>
                                        <c:otherwise>
                                            ?ûë?Ñ±?ïú Í∏??ù¥ ?óÜ?äµ?ãà?ã§.
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
                                    <a href="/member/mypost?page=${startNavi-1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?ù¥?†Ñ</a>
                                </c:if>
                                
                                <!-- ?éò?ù¥Ïß? Î≤àÌò∏ -->
                                <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                                    <a href="/member/mypost?page=${n}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" 
                                       class="page-btn <c:if test='${currentPage eq n}'>active</c:if>">
                                        ${n}
                                    </a>
                                </c:forEach>
                                
                                <!-- ?ã§?ùå Î≤ÑÌäº -->
                                <c:if test="${endNavi < maxPage}">
                                    <a href="/member/mypost?page=${endNavi+1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?ã§?ùå</a>
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
        // Í∏? ?ÉÅ?Ñ∏Î≥¥Í∏∞Î°? ?ù¥?èô
        function goToPost(postType, postNo) {
            if (postType === 'REQUEST') {
                window.location.href = '/member/request/detail?requestNo=' + postNo;
            } else if (postType === 'QUESTION') {
                window.location.href = '/teacher/question/detail?questionNo=' + postNo;
            }
        }

        // ?éò?ù¥Ïß? Î°úÎìú ?ãú ?ã§?ñâ
        document.addEventListener('DOMContentLoaded', function() {
            console.log('?Çò?ùò Í∏? ?éò?ù¥Ïß?Í∞? Î°úÎìú?êò?óà?äµ?ãà?ã§.');
            
            // Í≤??Éâ?ñ¥Í∞? ?ûà?ùÑ ?ïå ?ûÖ?†•Ï∞ΩÏóê ?è¨Ïª§Ïä§
            const searchInput = document.querySelector('input[name="searchKeyword"]');
            if (searchInput && searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>