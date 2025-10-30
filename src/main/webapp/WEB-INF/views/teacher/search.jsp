<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>ÏßàÎ¨∏ Í≤åÏãú?åê</title>
		<link rel="stylesheet" href="/resources/css/teacher/list.css">
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
	</head>
	<body>
  	<jsp:include page="../common/header.jsp" />
	<!-- Î©îÏù∏ Î∞∞ÎÑà -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        Í≥µÏ??Ç¨?ï≠
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png" alt="ÏßàÎ¨∏ Í≤åÏãú?åê ?ïÑ?ù¥ÏΩ?">
        </div>
	</section>

    <main class="main-content">
        <div class="content-top-area">
            <div class="main-search-bar">
                <form action="/teacher/question/search" method="get" class="search-form">
                    <input type="text" name="searchKeyword" placeholder="Í≤??Éâ?ñ¥Î•? ?ûÖ?†•?ï¥Ï£ºÏÑ∏?öî" value="${searchKeyword }">
                    <input type="hidden" name="filter" value="${filter}"> 
                    <button type="submit" class="search-btn"></button>
                </form>
                </div>
                <a href="/teacher/question/search?filter=ALL&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${empty filter || filter eq 'ALL'}">sort-current</c:if>">
	               ?†ÑÏ≤?
	            </a>
	            <a href="/teacher/question/search?filter=Y&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${filter eq 'Y'}">sort-current</c:if>">
	               ?ï¥Í≤?
	            </a>
	            <a href="/teacher/question/search?filter=N&searchKeyword=${searchKeyword}&page=1" 
	               class="sort-by-text <c:if test="${filter eq 'N'}">sort-current</c:if>">
	               ÎØ∏Ìï¥Í≤?
	            </a>
            </div>
        <section class="question-list">
            <c:forEach items="${searchList }" var="question" varStatus="i">
	            <a href="/teacher/question/detail?questionNo=${question.questionNo }" class = "atag">
		            <article class="question-item">
		                <div class="question-status-and-title">
		                	<c:if test="${question.questionStatus eq 'N' }">
			                    <div class="status-tag status-unresolved">ÎØ∏Ìï¥Í≤?</div>
		                	</c:if>
		                	<c:if test="${question.questionStatus eq 'Y' }">
			                    <div class="status-tag status-resolved">?ï¥Í≤?</div>
		                	</c:if>
		                    <h2 class="question-title">${question.questionTitle }</h2>
		                </div>
		                <p class="question-content">${question.questionContent }</p>
		                <div class="question-meta">
		                    <span>${question.memberId }</span>
		                    <span><fmt:formatDate value="${question.writeDate}" pattern="yyyy-MM-dd HH:mm" /></span>
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
                        <a href="/teacher/question/search?page=${startNavi - 1 }&searchKeyword=${searchKeyword}&filter=${filter}" class="page-button">?ù¥?†Ñ</a>
                	</c:if>
                	<c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                        <a href="/teacher/question/search?page=${n }&searchKeyword=${searchKeyword}&filter=${filter}" class='page-button <c:if test="${currentPage eq n }">page-current</c:if>'>${n }</a>
                    </c:forEach>
                    <c:if test="${endNavi ne maxPage }">
                        <a href="/teacher/question/search?page=${endNavi + 1 }&searchKeyword=${searchKeyword}&filter=${filter}" class="page-button">?ã§?ùå</a>
                    </c:if>
                </div>
            </div>
            
            <c:if test="${not empty sessionScope.loginId}">
            <a href="/member/insertQuestion" class="write-button">Í∏??ì∞Í∏?</a>
            </c:if>
        </div>
    </main>
        <jsp:include page="../common/footer.jsp" />
	</body>
</html>