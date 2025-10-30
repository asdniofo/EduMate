<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>ÏßàÎ¨∏ ?ÉÅ?Ñ∏</title>
		<link rel="stylesheet" href="/resources/css/teacher/detail.css">
        <link rel="stylesheet" href="/resources/css/common/header.css" />
        <link rel="stylesheet" href="/resources/css/common/footer.css" />
	</head>
	<body>
	<jsp:include page="../common/header.jsp" />
	<!-- Î©îÏù∏ Î∞∞ÎÑà -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ÏßàÎ¨∏ ?ÉÅ?Ñ∏?†ïÎ≥?
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/teacher/QnAIcon.png" alt="ÏßàÎ¨∏ Í≤åÏãú?åê ?ïÑ?ù¥ÏΩ?">
        </div>
	</section>
		<div class="page-wrapper">
        <div class="content-area">

            <main class="main-content">
                <div class="content-card">
                    
                    <section class="question-header">
                        <div class="title-group">
                        	<c:if test="${question.questionStatus eq 'N' }">
                            	<div class="status-tag-unresolved">ÎØ∏Ìï¥Í≤?</div>
                            </c:if>
                            <c:if test="${question.questionStatus eq 'Y' }">
                            	<div class="status-tag-resolved">?ï¥Í≤?</div>
                            </c:if>
                            <h2 class="question-title">${question.questionTitle }</h2>
                        </div>
                        <p class="question-meta"><fmt:formatDate value="${question.writeDate}" pattern="yyyy-MM-dd HH:mm" /> &nbsp;|&nbsp; ?ûë?Ñ±?ûê : ${question.memberId }</p>
                    </section>
                    
                    <section class="question-body">
                        <p>${question.questionContent }</p>
                    </section>


                    <section class="answer-input-section">
                        <div class="input-area-wrapper">
                            <textarea class="answer-textarea" id="answer-area" placeholder="?ãµÎ≥? ?Ç¥?ö©?ùÑ ?ûÖ?†•?ïò?Ñ∏?öî."></textarea>
                            <button class="answer-submit-button" id="submit-button">?ãµÎ≥?</button>
                        </div>
                    </section>
                    
                    <section class="answer-display-section" id="answer-list">
                        
                        <div class="answer-item">
                            
                        </div>
                        
                    </section>
                    
                    <section class="bottom-actions">
                        <div class="left-actions">
                        	<a href="/teacher/question/list"><button class="action-button">Î™©Î°ù</button></a>
                        	<c:if test="${sessionScope.loginMember.memberId eq question.memberId 
                    			or sessionScope.loginMember.adminYN eq 'Y'}">
	                            <a href="/teacher/question/modify?questionNo=${question.questionNo }"><button class="action-button">?àò?†ï</button></a>
	                            <button class="action-button" id="delete-list-btn">?Ç≠?†ú</button>
                            </c:if>
                            <c:if test="${sessionScope.loginMember.memberId eq question.memberId }">
                            	<button class="action-button" id="change-status-btn">?ÉÅ?ÉúÎ≥?Í≤?</button>
                            </c:if>
                        </div>
                        <div class="right-actions">
                            <%-- ?üí? ?ù¥?†Ñ Î≤ÑÌäº: prevQuestionNo Î≥??àò?óê Í∞íÏù¥ ?ûà?ùÑ ?ïåÎß? Î≤ÑÌäº ?ëú?ãú --%>
					        <c:if test="${not empty prevQuestionNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?questionNo=${prevQuestionNo}';">
					                ?ù¥?†Ñ
					            </button>
					        </c:if>
					        
					        <%-- ?üí? ?ã§?ùå Î≤ÑÌäº: nextQuestionNo Î≥??àò?óê Í∞íÏù¥ ?ûà?ùÑ ?ïåÎß? Î≤ÑÌäº ?ëú?ãú --%>
					        <c:if test="${not empty nextQuestionNo}">
					            <button class="action-button" 
					                    onclick="location.href='detail?questionNo=${nextQuestionNo}';">
					                ?ã§?ùå
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
	const loginMemberId = "${sessionScope.loginId}"; // ?ù¥ Í∞íÏ? 'aaaaaaa'?ûÖ?ãà?ã§.
    
    function deleteComment(questionCommentNo) {
        // ... (deleteComment ?ï®?àò Î°úÏßÅ?? Í∑∏Î?Î°? ?ú†Ïß?) ...
        //console.log("?†Ñ?ã¨?êú ?åìÍ∏? Î≤àÌò∏:", questionCommentNo);
        
        if(confirm("?†ïÎßêÎ°ú ?Ç≠?†ú?ïò?ãúÍ≤†Ïäµ?ãàÍπ??")){
            fetch("/question/comment/delete?questionCommentNo=" + questionCommentNo) 
            .then(response => response.text()) 
            .then(text => {
                const result = parseInt(text.trim());
                if(result > 0){
                    alert("?åìÍ∏? ?Ç≠?†úÍ∞? ?ôÑÎ£åÎêò?óà?äµ?ãà?ã§.");
                    getCommentList();
                }else {
                    alert("?åìÍ∏? ?Ç≠?†úÍ∞? ?ôÑÎ£åÎêòÏß? ?ïä?ïò?äµ?ãà?ã§.");
                }
            })
            .catch(error => console.error("?åìÍ∏? ?Ç≠?†ú Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§:", error));
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
                
                // ?üí? ÏµúÏ¢Ö ?àò?†ï: ???ÜåÎ¨∏ÏûêÍπåÏ? ?Üµ?ùº?ïò?ó¨ ÎπÑÍµê (Í∞??û• ?ïà?†Ñ?ï®)
                const isMyComment = (loginMemberId.trim().toLowerCase() === comment.memberId.trim().toLowerCase());
                
                // --- (ÏΩòÏÜî ?îîÎ≤ÑÍπÖ ÏΩîÎìú - ?ïà?†ï?ôî) ---
                //console.log(`-- ?åìÍ∏? No ${comment.questionCommentNo} --`);
                //console.log("Î°úÍ∑∏?ù∏ ID:", loginMemberId.trim().toLowerCase(), "/ ?åìÍ∏? ID:", comment.memberId.trim().toLowerCase(), "/ ?ùºÏπ?:", isMyComment);
                // ------------------------------------
                
                if (isMyComment) {
                	// ?üí? FINAL FIX: commentNoÎ•? ?î∞?ò¥?ëúÎ°? Í∞êÏã∏?Ñú ?†Ñ?ã¨ (Î¨∏Ïûê?ó¥Î°? Í∞ïÏ†ú)
                    const onclickCode = `deleteComment('${comment.questionCommentNo}');`; 
                    
                    // deleteButtonHtml?óê ?î∞?ò¥?ëúÍ∞? ?ÇΩ?ûÖ?êú onclick ÏΩîÎìúÎ•? ?Ç¨?ö©
                    deleteButtonHtml = `<button class="delete-btn" onclick="${onclickCode}">?Ç≠?†ú</button>`;
			    }
                
                const itemDiv = document.createElement("div");
                itemDiv.classList.add("answer-item");
                
                itemDiv.innerHTML = `
                    <div class="answer-header">
                        <span class="answer-author">\${comment.memberId}</span> 
                        <span class="answer-date">\${comment.writeDate} ?ûë?Ñ±</span>
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
                    // 2. ?üí? FINAL FIX: Î≤ÑÌäº ?öî?ÜåÎ•? ÏßÅÏ†ë ?Éù?Ñ±?ïòÍ≥? ?ù¥Î≤§Ìä∏ Î¶¨Ïä§?Ñà ?ó∞Í≤?
                    const deleteBtn = document.createElement("button");
                    deleteBtn.className = "delete-btn";
                    deleteBtn.textContent = "?Ç≠?†ú";
                    
                    // 3. ?üí? addEventListenerÎ°? ?ïà?†Ñ?ïòÍ≤? ?ù¥Î≤§Ìä∏ ?ó∞Í≤?
                    deleteBtn.addEventListener('click', () => {
                        // comment.questionCommentNo Í∞íÏùÑ ÏßÅÏ†ë Ï∞∏Ï°∞?ïò?ó¨ ?†Ñ?ã¨
                        deleteComment(comment.questionCommentNo); 
                    });
                    
                    commentActionsDiv.appendChild(deleteBtn);
                }
                
            })
        })
        .catch(error => console.error("?åìÍ∏? Î™©Î°ù Ï°∞Ìöå ?ò§Î•? : " + error));
    }
    getCommentList();
		
		document.querySelector("#submit-button").addEventListener("click", function(){
			// ?åìÍ∏? ?ì±Î°? Î≤ÑÌäº ?Å¥Î¶? ?ãú ?ã§?ñâ?êò?äî ÏΩîÎìú
			// ?ûÖ?†•?êú Í∞íÏùÑ Í∞??†∏???Ñú ?ÑúÎ≤ÑÎ°ú ?†Ñ?Ü°?ïò?äî Î°úÏßÅ?ùÑ Íµ¨ÌòÑ?ï¥?ïº ?ï©?ãà?ã§.
			// AjaxÎ•? ?Ç¨?ö©?ïò?ó¨ ÎπÑÎèôÍ∏∞Ï†Å?úºÎ°? ?åìÍ∏??ùÑ Ï∂îÍ?
			const QuestionCommentContent = document.querySelector("#answer-area").value;
			if(QuestionCommentContent.trim() === "") {
				alert("?åìÍ∏? ?Ç¥?ö©?ùÑ ?ûÖ?†•?ïò?Ñ∏?öî.");
				return;
			}
			// Í≤åÏãúÍ∏? Î≤àÌò∏
			const questionNo = ${question.questionNo };
			const memberId = "${question.memberId }";
			const data = {
			    "questionNo": questionNo, 
			    "memberId": loginMemberId,
			    "questionCommentContent": QuestionCommentContent
			};
			// ?ç∞?ù¥?Ñ∞ fetch API ?ù¥?ö©?ïò?ó¨ Î≥¥ÎÇ¥Í∏?
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
					alert("?åìÍ∏? ?ì±Î°ùÏù¥ ?ôÑÎ£åÎêò?óà?äµ?ãà?ã§.");
					getCommentList();
				}else {
					alert("?åìÍ∏? ?ì±Î°ùÏù¥ ?ôÑÎ£åÎêòÏß? ?ïä?ïò?äµ?ãà?ã§.");
				}
				document.querySelector("#answer-area").value = "";
			})
			.catch(error => alert("?åìÍ∏? ?ì±Î°? Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§."));
		})
		
	const currentQuestionNo = ${question.questionNo};

	document.querySelector("#delete-list-btn").addEventListener("click", function() {
	    if (confirm("?†ïÎß? ?ù¥ ÏßàÎ¨∏?ùÑ ?Ç≠?†ú?ïò?ãúÍ≤†Ïäµ?ãàÍπ??")) {
	        
	    	fetch(`/teacher/question/delete?questionNo=${question.questionNo}`)
	        
	        // ?üí? 1. ?ùë?ãµ?ùÑ ?Öç?ä§?ä∏Î°? Î∞õÍ≥† (ControllerÍ∞? ?à´?ûêÎß? Î∞òÌôò)
	        .then(response => response.text()) 
	        
	        // ?üí? 2. ?à´?ûê ?åå?ã± ?õÑ ?Ñ±Í≥?/?ã§?å® Ï≤òÎ¶¨
	        .then(text => {
	            const result = parseInt(text.trim());
	            
	            if (result > 0) {
	                alert("?Ç≠?†ú?êò?óà?äµ?ãà?ã§.");
	                
	                // ?Ç≠?†ú ?Ñ±Í≥? ?õÑ Î™©Î°ù ?éò?ù¥Ïß?Î°? ?ù¥?èô (ControllerÍ∞? Î¶¨Îã§?ù¥?†â?ä∏Î•? ?ïà?ïòÎØ?Î°? ?ó¨Í∏∞ÏÑú Ï≤òÎ¶¨)
	                window.location.href = "/teacher/question/list"; 
	            } else {
	                alert("ÏßàÎ¨∏ ?Ç≠?†ú?óê ?ã§?å®?ñà?äµ?ãà?ã§. (Í≤∞Í≥º: 0)");
	            }
	        })
	        
	        // 3. ?ò§Î•? Ï≤òÎ¶¨
	        .catch(error => {
	            alert("ÏßàÎ¨∏ ?Ç≠?†ú Ï≤òÎ¶¨ Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§. (?Ñ§?ä∏?õå?Å¨/?åå?ã± ?ò§Î•?)");
	            console.error("?Ç≠?†ú ?ò§Î•?:", error);
	        });
	    }
	});
	
	document.querySelector("#change-status-btn").addEventListener("click", function() {
	    
	    // 1. ?ôï?ù∏ Î©îÏãúÏß?Î•? ?ùºÎ∞òÏ†Å?ù∏ ?ÉÅ?Éú Î≥?Í≤? Î©îÏãúÏß?Î°? Î≥?Í≤?
	    if (confirm("ÏßàÎ¨∏ ?ÉÅ?ÉúÎ•? Î≥?Í≤ΩÌïò?ãúÍ≤†Ïäµ?ãàÍπ??")) {
	        
	        // 2. fetch ?öîÏ≤? (Í≤ΩÎ°ú?óê '/teacher' ?è¨?ï®)
	        fetch(`/teacher/question/change/status?questionNo=${question.questionNo}`)
	        
	        // 3. ?ÑúÎ≤? ?ùë?ãµ Ï≤òÎ¶¨
	        .then(response => response.text()) 
	        .then(text => {
	            const result = parseInt(text.trim());
	            
	            if (result > 0) {
	                // ?üí? Î©îÏãúÏß? ?àò?†ï: ?Ü†Í∏??êò?óà?ùå?ùÑ ?ïåÎ¶?
	                alert("ÏßàÎ¨∏ ?ÉÅ?ÉúÍ∞? ?Ñ±Í≥µÏ†Å?úºÎ°? Î≥?Í≤ΩÎêò?óà?äµ?ãà?ã§."); 
	                
	                // Î≥?Í≤? ?õÑ ?ÉÅ?Ñ∏ ?éò?ù¥Ïß?Î•? ?ÉàÎ°úÍ≥†Ïπ®Ìïò?ó¨ Î∞îÎ?? ?ÉÅ?ÉúÎ•? Ï¶âÏãú Î∞òÏòÅ
	                window.location.reload(); 
	            } else {
	                alert("?ÉÅ?Éú Î≥?Í≤ΩÏóê ?ã§?å®?ñà?äµ?ãà?ã§. (DB ?ò§Î•?)");
	            }
	        })
	        
	        // 4. ?ò§Î•? Ï≤òÎ¶¨
	        .catch(error => {
	            alert("?ÉÅ?Éú Î≥?Í≤? ?öîÏ≤? Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§. (?Ñ§?ä∏?õå?Å¨/?åå?ã± ?ò§Î•?)");
	            console.error("?ÉÅ?Éú Î≥?Í≤? ?ò§Î•?:", error);
	        });
	    }
	});
	</script>
	</body>
</html>










