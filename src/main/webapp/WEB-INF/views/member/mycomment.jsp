<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>나의 댓글 | EduMate</title>
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
                나의 댓글
            </div>
            <div class="object">
                <img src="/resources/images/member/postcomment.png" alt="나의 댓글 아이콘">
            </div>
        </section>

        <!-- 메인 콘텐츠 -->
        <div class="main-content">
            <div class="mycomment-content">
                <a href="/member/mypage" class="back-btn">← 마이페이지로 돌아가기</a>
                
                <!-- 나의 댓글 섹션 -->
                <div class="mycomment-section">
                    <div class="section-header">
                        <h2 class="section-title">나의 작성댓글</h2>
                        <div class="stats-info">
                            총 <strong>${totalComments}</strong>개의 댓글
                        </div>
                    </div>
                    
                    <!-- 검색 박스 -->
                    <form action="/member/mycomment" method="get">
                        <div class="search-box">
                            <input type="text" name="searchKeyword" value="${searchKeyword}" placeholder="댓글 내용이나 원글 제목으로 검색...">
                            <button type="submit">🔍</button>
                        </div>
                    </form>
                    
                    <!-- 댓글 목록 -->
                    <div class="comment-list" id="commentList">
                        <c:choose>
                            <c:when test="${not empty myComments}">
                                <c:forEach items="${myComments}" var="comment">
                                    <div class="comment-item" onclick="goToParentPost('${comment.parentPostType}', ${comment.parentPostNo})">
                                        <div class="comment-header">
                                            <c:choose>
                                                <c:when test="${comment.commentType == 'REQUEST'}">
                                                    <span class="comment-type-badge comment-type-request">건의사항 댓글</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="comment-type-badge comment-type-question">질문 댓글</span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <span class="comment-date">
                                                <fmt:formatDate value="${comment.writeDate}" pattern="yyyy-MM-dd HH:mm" />
                                            </span>
                                        </div>
                                        
                                        <!-- 원글 정보 -->
                                        <div class="parent-post">
                                            <div class="parent-post-label">
                                                <c:choose>
                                                    <c:when test="${comment.parentPostType == 'REQUEST'}">댓글을 작성한 건의사항:</c:when>
                                                    <c:otherwise>댓글을 작성한 질문:</c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="parent-post-title">${comment.parentPostTitle}</div>
                                        </div>
                                        
                                        <!-- 구분선 -->
                                        <div class="divider"></div>
                                        
                                        <!-- 댓글 내용 -->
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
                                            '${searchKeyword}' 검색 결과가 없습니다.
                                        </c:when>
                                        <c:otherwise>
                                            작성한 댓글이 없습니다.
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
                                    <a href="/member/mycomment?page=${startNavi-1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">이전</a>
                                </c:if>
                                
                                <!-- 페이지 번호 -->
                                <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                                    <a href="/member/mycomment?page=${n}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" 
                                       class="page-btn <c:if test='${currentPage eq n}'>active</c:if>">
                                        ${n}
                                    </a>
                                </c:forEach>
                                
                                <!-- 다음 버튼 -->
                                <c:if test="${endNavi < maxPage}">
                                    <a href="/member/mycomment?page=${endNavi+1}<c:if test='${not empty searchKeyword}'>&searchKeyword=${searchKeyword}</c:if>" class="page-btn">다음</a>
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
        // 원글로 이동
        function goToParentPost(postType, postNo) {
            if (postType === 'REQUEST') {
                window.location.href = '/member/request/detail?requestNo=' + postNo;
            } else if (postType === 'QUESTION') {
                window.location.href = '/teacher/question/detail?questionNo=' + postNo;
            }
        }

        // 페이지 로드 시 실행
        document.addEventListener('DOMContentLoaded', function() {
            console.log('나의 댓글 페이지가 로드되었습니다.');
            
            // 검색어가 있을 때 입력창에 포커스
            const searchInput = document.querySelector('input[name="searchKeyword"]');
            if (searchInput && searchInput.value) {
                searchInput.focus();
            }
        });
    </script>
</body>
</html>