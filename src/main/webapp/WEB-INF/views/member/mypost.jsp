<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>?��?�� �? | EduMate</title>
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
                ?��?�� �?
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/postcomment.png" alt="?��?�� �? ?��?���?">
            </div>
        </section>

        <!-- 메인 콘텐�? -->
        <div class="main-content">
            <div class="mypost-content">
                <a href="/member/mypage" class="back-btn">?�� 마이?��?���?�? ?��?���?�?</a>
                
                <!-- ?��?�� �? ?��?�� -->
                <div class="mypost-section">
                    <div class="section-header">
                        <h2 class="section-title">?��?�� ?��?���?</h2>
                        <div class="stats-info">
                            �? <strong>${totalPosts}</strong>개의 �?
                        </div>
                    </div>
                    
                    <!-- �??�� 박스 -->
                    <form action="/member/mypost" method="get">
                        <div class="search-box">
                            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="?��목으�? �??��...">
                            <button type="submit">?��?</button>
                        </div>
                    </form>
                    
                    <!-- �? 목록 -->
                    <div class="post-list" id="postList">
                        <c:choose>
                            <c:when test="${not empty myPosts}">
                                <c:forEach items="${myPosts}" var="post">
                                    <div class="post-item" onclick="goToPost('${post.postType}', ${post.postNo})">
                                        <div class="post-header">
                                            <c:choose>
                                                <c:when test="${post.postType == 'REQUEST'}">
                                                    <span class="post-type-badge post-type-request">건의?��?��</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge post-type-question">질문</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:choose>
                                                <c:when test="${post.status == 'Y'}">
                                                    <span class="post-status status-y">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">처리?���?</c:when>
                                                            <c:otherwise>?���?</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-status status-n">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">�??���?</c:when>
                                                            <c:otherwise>미해�?</c:otherwise>
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
                                            '${searchKeyword}' �??�� 결과�? ?��?��?��?��.
                                        </c:when>
                                        <c:otherwise>
                                            ?��?��?�� �??�� ?��?��?��?��.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- ?��?���??��?��?�� -->
                    <c:if test="${maxPage > 1}">
                        <div class="pagination-wrapper">
                            <div class="pagination">
                                <!-- ?��?�� 버튼 -->
                                <c:if test="${startNavi > 1}">
                                    <a href="/member/mypost?page=${startNavi-1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?��?��</a>
                                </c:if>
                                
                                <!-- ?��?���? 번호 -->
                                <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                                    <a href="/member/mypost?page=${n}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" 
                                       class="page-btn <c:if test='${currentPage eq n}'>active</c:if>">
                                        ${n}
                                    </a>
                                </c:forEach>
                                
                                <!-- ?��?�� 버튼 -->
                                <c:if test="${endNavi < maxPage}">
                                    <a href="/member/mypost?page=${endNavi+1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">?��?��</a>
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
        // �? ?��?��보기�? ?��?��
        function goToPost(postType, postNo) {
            if (postType === 'REQUEST') {
                window.location.href = '/member/request/detail?requestNo=' + postNo;
            } else if (postType === 'QUESTION') {
                window.location.href = '/teacher/question/detail?questionNo=' + postNo;
            }
        }

        // ?��?���? 로드 ?�� ?��?��
        document.addEventListener('DOMContentLoaded', function() {
            console.log('?��?�� �? ?��?���?�? 로드?��?��?��?��?��.');
            
            // �??��?���? ?��?�� ?�� ?��?��창에 ?��커스
            const searchInput = document.querySelector('input[name="searchKeyword"]');
            if (searchInput && searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>