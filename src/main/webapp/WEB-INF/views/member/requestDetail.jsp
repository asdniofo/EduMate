<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>건의?��?��</title>
		<link rel="stylesheet" href="/resources/css/teacher/detail.css">
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
        <link rel="stylesheet" href="/resources/css/common/main_banner.css">
	</head>
	<body>
	<jsp:include page="../common/header.jsp" />
		<div class="page-wrapper">
        <div class="content-area">
            <section class="main-banner">
                <div class="banner-text">
                    건의?��?��
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/request/requestIcon.png" alt="건의?��?�� ?��?���?">
                </div>
            </section>

            <main class="main-content">
                <div class="content-card">
                    
                    <section class="question-header">
                        <div class="title-group">
                        	<c:if test="${request.requestStatus eq 'N' }">
                            	<div class="status-tag-unresolved">미해�?</div>
                            </c:if>
                            <c:if test="${request.requestStatus eq 'Y' }">
                            	<div class="status-tag-resolved">?���?</div>
                            </c:if>
                            <h2 class="question-title">${request.requestTitle }</h2>
                        </div>
                        <p class="question-meta"><fmt:formatDate value="${request.writeDate}" pattern="yyyy-MM-dd HH:mm" /> &nbsp;|&nbsp; ?��?��?�� : ${request.memberId }</p>
                    </section>
                    
                    <section class="question-body">
                        <p>${request.requestContent }</p>
                    </section>

					<c:if test="${sessionScope.adminYn eq 'Y' }">
                    <section class="answer-input-section">
                        <div class="input-area-wrapper">
                            <textarea class="answer-textarea" id="answer-area" placeholder="?���? ?��?��?�� ?��?��?��?��?��."></textarea>
                            <button class="answer-submit-button" id="submit-button">?���?</button>
                        </div>
                    </section>
                    </c:if>
                    
                    <section class="answer-display-section" id="answer-list">
                        
                        <div class="answer-item">
                            
                        </div>
                        
                    </section>
                    
                    <section class="bottom-actions">
                        <div class="left-actions">
                        	<a href="/member/request"><button class="action-button">목록</button></a>
                        	<c:if test="${sessionScope.memberId eq request.memberId
                    			or sessionScope.adminYn eq 'Y'}">
	                            <a href="/member/request/modify?requestNo=${request.requestNo }"><button class="action-button">?��?��</button></a>
	                            <button class="action-button" id="delete-list-btn">?��?��</button>
                            	<button class="action-button" id="change-status-btn">?��?���?�?</button>
                            </c:if>
                        </div>
                        <div class="right-actions">
                        	<%-- ?��? ?��?�� 버튼: nextQuestionNo �??��?�� 값이 ?��?�� ?���? 버튼 ?��?�� --%>
					        <c:if test="${not empty nextRequestNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?requestNo=${nextRequestNo}';">
					                ?��?��
					            </button>
					        </c:if>
					        
                            <%-- ?��? ?��?�� 버튼: prevQuestionNo �??��?�� 값이 ?��?�� ?���? 버튼 ?��?�� --%>
					        <c:if test="${not empty prevRequestNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?requestNo=${prevRequestNo}';">
					                ?��?��
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
	const loginMemberId = "${sessionScope.loginId}";
    
    function deleteComment(requestCommentNo) {
        // ... (deleteComment ?��?�� 로직?? 그�?�? ?���?) ...
        //console.log("?��?��?�� ?���? 번호:", requestCommentNo);
        
        if(confirm("?��말로 ?��?��?��?��겠습?���??")){
            fetch("/request/comment/delete?requestCommentNo=" + requestCommentNo) 
            .then(response => response.text()) 
            .then(text => {
                const result = parseInt(text.trim());
                if(result > 0){
                    alert("?���? ?��?���? ?��료되?��?��?��?��.");
                    getCommentList();
                }else {
                    alert("?���? ?��?���? ?��료되�? ?��?��?��?��?��.");
                }
            })
            .catch(error => console.error("?���? ?��?�� �? ?��류�? 발생?��?��?��?��:", error));
        }
    }

    function getCommentList() {
        fetch("/request/comment/list?requestNo=${request.requestNo }")
        .then(response => response.json())
        .then(cmList => {
            const cmListUl = document.querySelector("#answer-list");
            cmListUl.innerHTML = "";
            
            cmList.forEach(comment => {
                
                let deleteButtonHtml = '';
                
                // ?��? 최종 ?��?��: ???��문자까�? ?��?��?��?�� 비교 (�??�� ?��?��?��)
                const isMyComment = (loginMemberId.trim().toLowerCase() === comment.memberId.trim().toLowerCase());
                
                // --- (콘솔 ?��버깅 코드 - ?��?��?��) ---
                //console.log(`-- ?���? No ${comment.questionCommentNo} --`);
                //console.log("로그?�� ID:", loginMemberId.trim().toLowerCase(), "/ ?���? ID:", comment.memberId.trim().toLowerCase(), "/ ?���?:", isMyComment);
                // ------------------------------------
                
                if (isMyComment) {
                	// ?��? FINAL FIX: commentNo�? ?��?��?���? 감싸?�� ?��?�� (문자?���? 강제)
                    const onclickCode = `deleteComment('${comment.requestCommentNo}');`; 
                    
                    // deleteButtonHtml?�� ?��?��?���? ?��?��?�� onclick 코드�? ?��?��
                    deleteButtonHtml = `<button class="delete-btn" onclick="${onclickCode}">?��?��</button>`;
			    }
                
                const itemDiv = document.createElement("div");
                itemDiv.classList.add("answer-item");
                
                itemDiv.innerHTML = `
                    <div class="answer-header">
                        <span class="answer-author">\${comment.memberId}</span> 
                        <span class="answer-date">\${comment.writeDate} ?��?��</span>
                    </div>
                    <div class="answer-content">
                        <p>\${comment.requestCommentContent}</p> 
                    </div>
                    <div class="comment-actions">
                    </div>
                `;
                cmListUl.appendChild(itemDiv);
                
				const commentActionsDiv = itemDiv.querySelector(".comment-actions");
                
                if (isMyComment) {
                    // 2. ?��? FINAL FIX: 버튼 ?��?���? 직접 ?��?��?���? ?��벤트 리스?�� ?���?
                    const deleteBtn = document.createElement("button");
                    deleteBtn.className = "delete-btn";
                    deleteBtn.textContent = "?��?��";
                    
                    // 3. ?��? addEventListener�? ?��?��?���? ?��벤트 ?���?
                    deleteBtn.addEventListener('click', () => {
                        // comment.questionCommentNo 값을 직접 참조?��?�� ?��?��
                        deleteComment(comment.requestCommentNo); 
                    });
                    
                    commentActionsDiv.appendChild(deleteBtn);
                }
                
            })
        })
        .catch(error => console.error("?���? 목록 조회 ?���? : " + error));
    }
    getCommentList();
		
    const submitButton = document.querySelector("#submit-button");
    if (submitButton){
    	submitButton.addEventListener("click", function(){
    		// ?���? ?���? 버튼 ?���? ?�� ?��?��?��?�� 코드
    		// ?��?��?�� 값을 �??��???�� ?��버로 ?��?��?��?�� 로직?�� 구현?��?�� ?��?��?��.
    		// Ajax�? ?��?��?��?�� 비동기적?���? ?���??�� 추�?
    		const requestCommentContent = document.querySelector("#answer-area").value;
    		if(requestCommentContent.trim() === "") {
    			alert("?���? ?��?��?�� ?��?��?��?��?��.");
    			return;
    		}
    		// 게시�? 번호
    		const requestNo = ${request.requestNo};
    		const memberId = "${request.memberId }";
    		const data = {
    		    "requestNo": requestNo, 
    		    "memberId": loginMemberId,
    		    "requestCommentContent": requestCommentContent
    		};
    		// ?��?��?�� fetch API ?��?��?��?�� 보내�?
    		fetch("/request/comment/add", {
    			method: "POST",
    			headers: {
    				"Content-Type": "application/json"
    			},
    			body: JSON.stringify(data)
    		}).then(response => response.text())
    		.then(text => {
    			const result = parseInt(text.trim());
    			if(result > 0){
    				alert("?���? ?��록이 ?��료되?��?��?��?��.");
    				getCommentList();
    			}else {
    				alert("?���? ?��록이 ?��료되�? ?��?��?��?��?��.");
    			}
    			document.querySelector("#answer-area").value = "";
    		})
    		.catch(error => alert("?���? ?���? �? ?��류�? 발생?��?��?��?��."));
    	})
    }
		
	const currentRequestNo = ${request.requestNo};

	document.querySelector("#delete-list-btn").addEventListener("click", function() {
	    if (confirm("?���? ?�� 질문?�� ?��?��?��?��겠습?���??")) {
	        
	    	fetch(`/member/request/delete?requestNo=${request.requestNo}`)
	        
	        // ?��? 1. ?��?��?�� ?��?��?���? 받고 (Controller�? ?��?���? 반환)
	        .then(response => response.text()) 
	        
	        // ?��? 2. ?��?�� ?��?�� ?�� ?���?/?��?�� 처리
	        .then(text => {
	            const result = parseInt(text.trim());
	            
	            if (result > 0) {
	                alert("?��?��?��?��?��?��?��.");
	                
	                // ?��?�� ?���? ?�� 목록 ?��?���?�? ?��?�� (Controller�? 리다?��?��?���? ?��?���?�? ?��기서 처리)
	                window.location.href = "/member/request"; 
	            } else {
	                alert("질문 ?��?��?�� ?��?��?��?��?��?��. (결과: 0)");
	            }
	        })
	        
	        // 3. ?���? 처리
	        .catch(error => {
	            alert("질문 ?��?�� 처리 �? ?��류�? 발생?��?��?��?��. (?��?��?��?��/?��?�� ?���?)");
	            console.error("?��?�� ?���?:", error);
	        });
	    }
	});
	
	document.querySelector("#change-status-btn").addEventListener("click", function() {
	    
	    if (confirm("질문 ?��?���? �?경하?��겠습?���??")) {
	        
	        fetch(`/member/request/change/status?requestNo=${request.requestNo}`)
	        
	        .then(response => response.text()) 
	        .then(text => {
	            const result = parseInt(text.trim());
	            
	            if (result > 0) {
	                alert("질문 ?��?���? ?��공적?���? �?경되?��?��?��?��."); 
	                
	                window.location.reload(); 
	            } else {
	                alert("?��?�� �?경에 ?��?��?��?��?��?��. (DB ?���?)");
	            }
	        })
	        
	        .catch(error => {
	            alert("?��?�� �?�? ?���? �? ?��류�? 발생?��?��?��?��. (?��?��?��?��/?��?�� ?���?)");
	            console.error("?��?�� �?�? ?���?:", error);
	        });
	    }
	});
	</script>
	</body>
</html>










