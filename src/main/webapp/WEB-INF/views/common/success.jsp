<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>완료 - EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <style>
        .success-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 60vh;
            text-align: center;
            padding: 2rem;
        }
        .success-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }
        .success-title {
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #333;
        }
        .success-message {
            font-size: 1.1rem;
            margin-bottom: 2rem;
            color: #666;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            padding: 12px 24px;
            margin: 0 10px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .auto-redirect {
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #999;
        }
    </style>
    <script>
        // 3초 후 자동 리다이렉트
        setTimeout(function() {
            <c:choose>
                <c:when test="${not empty url}">
                    window.location.href = '${url}';
                </c:when>
                <c:otherwise>
                    window.location.href = '/';
                </c:otherwise>
            </c:choose>
        }, 3000);
    </script>
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="header.jsp" />

        <div class="main-content">
            <div class="success-container">
                <div class="success-icon">✅</div>
                <h1 class="success-title">완료되었습니다!</h1>
                <div class="success-message">
                    <c:choose>
                        <c:when test="${not empty msg}">
                            ${msg}
                        </c:when>
                        <c:otherwise>
                            요청이 성공적으로 처리되었습니다.
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="action-buttons">
                    <c:choose>
                        <c:when test="${not empty url}">
                            <a href="${url}" class="btn btn-primary">확인</a>
                        </c:when>
                        <c:otherwise>
                            <a href="/" class="btn btn-primary">메인으로</a>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="auto-redirect">
                    3초 후 자동으로 이동됩니다...
                </div>
            </div>
        </div>

        <!-- Footer Include -->
        <jsp:include page="footer.jsp" />
    </div>
</body>
</html>