<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>질문 게시판</title>
		<link rel="stylesheet" href="/resources/css/teacher/list.css">
	</head>
	<body>
		<div class="hero-section-wrapper">
        <div class="hero-section">
            <h1 class="hero-title">질문과 답변</h1>
            <div class="hero-image"></div>
        </div>
    </div>

    <main class="main-content">
        <div class="content-top-area">
            <div class="main-search-bar">
                <form action="/teacher/question/search" method="get" class="search-form">
                    <input type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" value="${searchKeyword }">
                    <input type="hidden" name="filter" value="${filter}"> 
                    <button type="submit" class="search-btn"></button>
                </form>
                </div>
                <a href="/teacher/question/search?filter=ALL&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${empty filter || filter eq 'ALL'}">sort-current</c:if>">
	               전체
	            </a>
	            <a href="/teacher/question/search?filter=Y&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${filter eq 'Y'}">sort-current</c:if>">
	               해결
	            </a>
	            <a href="/teacher/question/search?filter=N&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${filter eq 'N'}">sort-current</c:if>">
	               미해결
	            </a>
            </div>
        <section class="question-list">
            <c:forEach items="${searchList }" var="question" varStatus="i">
	            <a href="/teacher/question/detail?questionNo=${question.questionNo }" class = "atag">
		            <article class="question-item">
		                <div class="question-status-and-title">
		                	<c:if test="${question.questionStatus eq 'N' }">
			                    <div class="status-tag status-unresolved">미해결</div>
		                	</c:if>
		                	<c:if test="${question.questionStatus eq 'Y' }">
			                    <div class="status-tag status-resolved">해결</div>
		                	</c:if>
		                    <h2 class="question-title">${question.questionTitle }</h2>
		                </div>
		                <p class="question-content">${question.questionContent }</p>
		                <div class="question-meta">
		                    <span>${question.memberId }</span>
		                    <span>${question.writeDate }</span>
		                </div>
		            </article>
		        </a>
            </c:forEach>

        </section>
        
        <div class="bottom-actions">
            <div class="pagination-placeholder"></div> 
            
            <div class="pagination-wrapper">
                <div class="pagination">
                    <c:if test="${startNavi ne 1 }">
                        <a href="/teacher/question/search?page=${startNavi - 1 }&searchKeyword=${searchKeyword}&filter=${filter}" class="page-button">이전</a>
                	</c:if>
                	<c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                        <a href="/teacher/question/search?page=${n }&searchKeyword=${searchKeyword}&filter=${filter}" class='page-button <c:if test="${currentPage eq n }">page-current</c:if>'>${n }</a>
                    </c:forEach>
                    <c:if test="${endNavi ne maxPage }">
                        <a href="/teacher/question/search?page=${endNavi + 1 }&searchKeyword=${searchKeyword}&filter=${filter}" class="page-button">다음</a>
                    </c:if>
                </div>
            </div>
            
            <!-- <a href="#" class="write-button">글쓰기</a> -->
        </div>
    </main>
	</body>
</html>