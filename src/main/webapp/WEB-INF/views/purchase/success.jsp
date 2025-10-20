<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제 완료 - EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/purchase/success.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />

        <div class="main-content">
            <div class="success-container">
                <div class="success-icon">✅</div>
                <h1 class="success-title">결제가 완료되었습니다!</h1>
                <p class="success-subtitle">
                    강의 구매가 성공적으로 완료되었습니다.<br>
                    이제 강의를 수강하실 수 있습니다.
                </p>

                <div class="lecture-info">
                    <div class="lecture-title">${lectureName}</div>
                    
                    <div class="purchase-details">
                        <span class="detail-label">주문번호:</span>
                        <span class="detail-value">${orderId}</span>
                    </div>
                    
                    <div class="purchase-details">
                        <span class="detail-label">결제방법:</span>
                        <span class="detail-value">
                            <c:choose>
                                <c:when test="${paymentMethod == 'balance'}">보유 포인트</c:when>
                                <c:otherwise>외부 결제</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    
                    <div class="purchase-details">
                        <span class="detail-label">결제금액:</span>
                        <span class="detail-value amount-value">₩<fmt:formatNumber value="${amount}" pattern="#,###"/></span>
                    </div>
                </div>

                <div class="action-buttons">
                    <a href="/lecture/details?lectureNo=${lectureNo}" class="btn btn-primary">강의 시작하기</a>
                    <a href="/lecture/list" class="btn btn-secondary">강의 목록</a>
                </div>
            </div>
        </div>

        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />
    </div>

</body>
</html>