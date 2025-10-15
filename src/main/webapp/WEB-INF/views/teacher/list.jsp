<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link rel="stylesheet" href="../resources/css/teacher/list.css">
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
                <form action="/teacher/search" method="get" class="search-form">
                    <input type="text" name="searchKeyword" placeholder="검색어를 입력해주세요">
                    <button type="submit" class="search-btn"></button>
                </form>
                </div>
                <input type="button" class="sort-by-text" value="등록순">
            </div>
        
        <section class="question-list">
            <c:forEach items="${tList }" var="question" varStatus="i">
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
	                    <!-- <span>자바 프로그래밍</span> -->
	                </div>
	            </article>
            </c:forEach>

        </section>
        
        <div class="bottom-actions">
            <div class="pagination-placeholder"></div> 
            
            <div class="pagination-wrapper">
                <div class="pagination">
                	<c:if test="${startNavi ne 1 }">
                		<a href="/teacher/list?page=${startNavi - 1 }" class="page-button">이전</a>
                	</c:if>
                	<c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                    	<a href="/teacher/list?page=${n }" class='page-button <c:if test="${currentPage eq n }">page-current</c:if>'>${n }</a>
                    </c:forEach>
                    <c:if test="${endNavi ne maxPage }">
                    	<a href="/teacher/list?page=${endNavi + 1 }" class="page-button">다음</a>
                    </c:if>
                </div>
            </div>
            
            <a href="#" class="write-button">글쓰기</a>
        </div>
    </main>
	</body>
</html>