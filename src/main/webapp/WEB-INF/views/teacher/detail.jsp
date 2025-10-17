<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>질문 상세</title>
		<link rel="stylesheet" href="/resources/css/teacher/detail.css">
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
	</head>
	<body>
	<jsp:include page="../common/header.jsp" />
		<div class="page-wrapper">
        <div class="content-area">

            <header class="hero-section-wrapper">
                <div class="hero-section">
                    <div class="hero-title-group">
                        <h1 class="hero-title">질문과 답변</h1>
                        <div class="hero-image"></div>
                    </div>
                </div>
            </header>

            <main class="main-content">
                <div class="content-card">
                    
                    <section class="question-header">
                        <div class="title-group">
                        	<c:if test="${question.questionStatus eq 'N' }">
                            	<div class="status-tag-unresolved">미해결</div>
                            </c:if>
                            <c:if test="${question.questionStatus eq 'Y' }">
                            	<div class="status-tag-resolved">해결</div>
                            </c:if>
                            <h2 class="question-title">${question.questionTitle }</h2>
                        </div>
                        <p class="question-meta"><fmt:formatDate value="${question.writeDate}" pattern="yyyy-MM-dd HH:mm" /> &nbsp;|&nbsp; 작성자 : ${question.memberId }</p>
                    </section>
                    
                    <section class="question-body">
                        <p>${question.questionContent }</p>
                    </section>


                    <section class="answer-input-section">
                        <h2>답변을 입력해주세요.</h2>
                        <div class="input-area-wrapper">
                            <textarea class="answer-textarea" placeholder="답변 내용을 입력하세요."></textarea>
                            <button class="answer-submit-button">답변</button>
                        </div>
                    </section>
                    
                    <section class="answer-display-section">
                        
                        <div class="answer-item">
                            <div class="answer-header">
                                <span class="answer-author">강사</span>
                                <span class="answer-date">2025. 10. 02. 14:30 작성</span>
                            </div>
                            <div class="answer-content">
                                <p>현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다.현재 답변드리기 어렵습니다.현재 답변드리기 어렵습니다.현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다. 현재 답변드리기 어렵습니다.현재 답변드리기 어렵습니다.현재 답변드리기 어렵습니다.</p>
                            </div>
                        </div>
                        
                    </section>
                    
                    <section class="bottom-actions">
                        <div class="left-actions">
                            <button class="action-button">수정</button>
                            <button class="action-button">삭제</button>
                            <button class="action-button">상태변경</button>
                        </div>
                        <div class="right-actions">
                            <button class="action-button">이전</button>
                            <button class="action-button">다음</button>
                        </div>
                    </section>

                </div>
            </main>
        </div>
    </div>
    
	<jsp:include page="../common/footer.jsp" />
	</body>
</html>