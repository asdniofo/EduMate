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
                        <div class="input-area-wrapper">
                            <textarea class="answer-textarea" id="answer-area" placeholder="답변 내용을 입력하세요."></textarea>
                            <button class="answer-submit-button" id="submit-button">답변</button>
                        </div>
                    </section>
                    
                    <section class="answer-display-section" id="answer-list">
                        
                        <div class="answer-item">
                            
                        </div>
                        
                    </section>
                    
                    <section class="bottom-actions">
                        <div class="left-actions">
                        	<a href="/teacher/question/list"><button class="action-button">목록</button></a>
                        	<c:if test="${sessionScope.loginMember.memberId eq question.memberId 
                    			or sessionScope.loginMember.adminYN eq 'Y'}">
	                            <button class="action-button">수정</button>
	                            <button class="action-button">삭제</button>
                            </c:if>
                            <c:if test="${sessionScope.loginMember.memberId eq question.memberId 
                    			or sessionScope.loginMember.adminYN eq 'Y' or sessionScope.loginMember.teacherYN eq 'Y'}">
                            	<button class="action-button">상태변경</button>
                            </c:if>
                        </div>
                        <div class="right-actions">
                            <%-- 💡 이전 버튼: prevQuestionNo 변수에 값이 있을 때만 버튼 표시 --%>
					        <c:if test="${not empty prevQuestionNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?questionNo=${prevQuestionNo}';">
					                이전
					            </button>
					        </c:if>
					        
					        <%-- 💡 다음 버튼: nextQuestionNo 변수에 값이 있을 때만 버튼 표시 --%>
					        <c:if test="${not empty nextQuestionNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?questionNo=${nextQuestionNo}';">
					                다음
					            </button>
					        </c:if>
                        </div>
                    </section>

                </div>
            </main>
        </div>
    </div>
    
	<jsp:include page="../common/footer.jsp" />
	
	<script>
	const loginMemberId = "${sessionScope.loginId}"; // 이 값은 'aaaaaaa'입니다.
    
    function deleteComment(questionCommentNo) {
        // ... (deleteComment 함수 로직은 그대로 유지) ...
        //console.log("전달된 댓글 번호:", questionCommentNo);
        
        if(confirm("정말로 삭제하시겠습니까?")){
            fetch("/question/comment/delete?questionCommentNo=" + questionCommentNo) 
            .then(response => response.text()) 
            .then(text => {
                const result = parseInt(text.trim());
                if(result > 0){
                    alert("댓글 삭제가 완료되었습니다.");
                    getCommentList();
                }else {
                    alert("댓글 삭제가 완료되지 않았습니다.");
                }
            })
            .catch(error => console.error("댓글 삭제 중 오류가 발생했습니다:", error));
        }
    }

    function getCommentList() {
        fetch("/question/comment/list?questionNo=${question.questionNo }")
        .then(response => response.json())
        .then(cmList => {
            const cmListUl = document.querySelector("#answer-list");
            cmListUl.innerHTML = "";
            
            cmList.forEach(comment => {
                
                let deleteButtonHtml = '';
                
                // 💡 최종 수정: 대소문자까지 통일하여 비교 (가장 안전함)
                const isMyComment = (loginMemberId.trim().toLowerCase() === comment.memberId.trim().toLowerCase());
                
                // --- (콘솔 디버깅 코드 - 안정화) ---
                //console.log(`-- 댓글 No ${comment.questionCommentNo} --`);
                //console.log("로그인 ID:", loginMemberId.trim().toLowerCase(), "/ 댓글 ID:", comment.memberId.trim().toLowerCase(), "/ 일치:", isMyComment);
                // ------------------------------------
                
                if (isMyComment) {
                	// 💡 FINAL FIX: commentNo를 따옴표로 감싸서 전달 (문자열로 강제)
                    const onclickCode = `deleteComment('${comment.questionCommentNo}');`; 
                    
                    // deleteButtonHtml에 따옴표가 삽입된 onclick 코드를 사용
                    deleteButtonHtml = `<button class="delete-btn" onclick="${onclickCode}">삭제</button>`;
			    }
                
                const itemDiv = document.createElement("div");
                itemDiv.classList.add("answer-item");
                
                itemDiv.innerHTML = `
                    <div class="answer-header">
                        <span class="answer-author">\${comment.memberId}</span> 
                        <span class="answer-date">\${comment.writeDate} 작성</span>
                    </div>
                    <div class="answer-content">
                        <p>\${comment.questionCommentContent}</p> 
                    </div>
                    <div class="comment-actions">
                    </div>
                `;
                cmListUl.appendChild(itemDiv);
                
				const commentActionsDiv = itemDiv.querySelector(".comment-actions");
                
                if (isMyComment) {
                    // 2. 💡 FINAL FIX: 버튼 요소를 직접 생성하고 이벤트 리스너 연결
                    const deleteBtn = document.createElement("button");
                    deleteBtn.className = "delete-btn";
                    deleteBtn.textContent = "삭제";
                    
                    // 3. 💡 addEventListener로 안전하게 이벤트 연결
                    deleteBtn.addEventListener('click', () => {
                        // comment.questionCommentNo 값을 직접 참조하여 전달
                        deleteComment(comment.questionCommentNo); 
                    });
                    
                    commentActionsDiv.appendChild(deleteBtn);
                }
                
            })
        })
        .catch(error => console.error("댓글 목록 조회 오류 : " + error));
    }
    getCommentList();
		
		document.querySelector("#submit-button").addEventListener("click", function(){
			// 댓글 등록 버튼 클릭 시 실행되는 코드
			// 입력된 값을 가져와서 서버로 전송하는 로직을 구현해야 합니다.
			// Ajax를 사용하여 비동기적으로 댓글을 추가
			const QuestionCommentContent = document.querySelector("#answer-area").value;
			if(QuestionCommentContent.trim() === "") {
				alert("댓글 내용을 입력하세요.");
				return;
			}
			// 게시글 번호
			const questionNo = ${question.questionNo };
			const memberId = "${question.memberId }";
			const data = {
			    "questionNo": questionNo, 
			    "memberId": loginMemberId,
			    "questionCommentContent": QuestionCommentContent
			};
			// 데이터 fetch API 이용하여 보내기
			fetch("/question/comment/add", {
				method: "POST",
				headers: {
					"Content-Type": "application/json"
				},
				body: JSON.stringify(data)
			}).then(response => response.text())
			.then(text => {
				const result = parseInt(text.trim());
				if(result > 0){
					alert("댓글 등록이 완료되었습니다.");
					getCommentList();
				}else {
					alert("댓글 등록이 완료되지 않았습니다.");
				}
				document.querySelector("#answer-area").value = "";
			})
			.catch(error => alert("댓글 등록 중 오류가 발생했습니다."));
		})
	</script>
	</body>
</html>










