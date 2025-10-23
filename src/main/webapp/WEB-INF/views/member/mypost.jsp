<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 글 | EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/member/mypost.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />
        
        <!-- 히어로 섹션 -->
        <section class="hero-section-wrapper">
            <div class="hero-section">
                <h1 class="hero-title">나의 글</h1>
                <img src="/resources/images/member/postcomment.png" alt="나의 글 아이콘" class="hero-image" />
            </div>
        </section>

        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="mypost-content">
                <a href="/member/mypage" class="back-btn">← 마이페이지로 돌아가기</a>
                
                <!-- 나의 글 섹션 -->
                <div class="mypost-section">
                    <div class="section-header">
                        <h2 class="section-title">나의 작성글</h2>
                        <div class="stats-info">
                            총 <strong>${totalPosts}</strong>개의 글
                        </div>
                    </div>
                    
                    <!-- 검색 박스 -->
                    <form action="/member/mypost" method="get">
                        <div class="search-box">
                            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="제목으로 검색...">
                            <button type="submit">🔍</button>
                        </div>
                    </form>
                    
                    <!-- 글 목록 -->
                    <div class="post-list" id="postList">
                        <c:choose>
                            <c:when test="${not empty myPosts}">
                                <c:forEach items="${myPosts}" var="post">
                                    <div class="post-item" onclick="goToPost('${post.postType}', ${post.postNo})">
                                        <div class="post-header">
                                            <c:choose>
                                                <c:when test="${post.postType == 'REQUEST'}">
                                                    <span class="post-type-badge post-type-request">건의사항</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-type-badge post-type-question">질문</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:choose>
                                                <c:when test="${post.status == 'Y'}">
                                                    <span class="post-status status-y">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">처리완료</c:when>
                                                            <c:otherwise>해결</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="post-status status-n">
                                                        <c:choose>
                                                            <c:when test="${post.postType == 'REQUEST'}">검토중</c:when>
                                                            <c:otherwise>미해결</c:otherwise>
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
                                            '${searchKeyword}' 검색 결과가 없습니다.
                                        </c:when>
                                        <c:otherwise>
                                            작성한 글이 없습니다.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- 페이지네이션 -->
                    <c:if test="${maxPage > 1}">
                        <div class="pagination-wrapper">
                            <div class="pagination">
                                <!-- 이전 버튼 -->
                                <c:if test="${startNavi > 1}">
                                    <a href="/member/mypost?page=${startNavi-1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">이전</a>
                                </c:if>
                                
                                <!-- 페이지 번호 -->
                                <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                                    <a href="/member/mypost?page=${n}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" 
                                       class="page-btn <c:if test='${currentPage eq n}'>active</c:if>">
                                        ${n}
                                    </a>
                                </c:forEach>
                                
                                <!-- 다음 버튼 -->
                                <c:if test="${endNavi < maxPage}">
                                    <a href="/member/mypost?page=${endNavi+1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">다음</a>
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
        // 글 상세보기로 이동
        function goToPost(postType, postNo) {
            if (postType === 'REQUEST') {
                window.location.href = '/member/request/detail?requestNo=' + postNo;
            } else if (postType === 'QUESTION') {
                window.location.href = '/teacher/question/detail?questionNo=' + postNo;
            }
        }

        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', function() {
            console.log('나의 글 페이지가 로드되었습니다.');
            
            // 검색어가 있을 때 입력창에 포커스
            const searchInput = document.querySelector('input[name="searchKeyword"]');
            if (searchInput && searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>