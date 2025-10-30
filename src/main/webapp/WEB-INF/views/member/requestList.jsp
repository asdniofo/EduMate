<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>건의?��?��</title>
        <link rel="stylesheet" href="/resources/css/teacher/list.css">
        <link rel="stylesheet" href="/resources/css/common/header.css"/>
        <link rel="stylesheet" href="/resources/css/common/footer.css"/>
        <link rel="stylesheet" href="/resources/css/common/main_banner.css">
    </head>
    <body>
        <jsp:include page="../common/header.jsp"/>
        <section class="main-banner">
            <div class="banner-text">
                건의?��?��
            </div>
            <div class="object">
                <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/request/requestIcon.png" alt="건의?��?�� ?��?���?">
            </div>
        </section>

        <main class="main-content">
            <div class="content-top-area">
                <div class="main-search-bar">
                    <form action="/member/request" method="get" class="search-form">
                        <input type="text" name="searchKeyword" placeholder="�??��?���? ?��?��?��주세?��" value="${searchKeyword }">
                        <input type="hidden" name="filter" value="${filter}">
                        <button type="submit" class="search-btn"></button>
                    </form>
                </div>
                <a href="/member/request?filter=ALL&searchKeyword=${searchKeyword}&page=1"
                   class="sort-by-text <c:if test="${empty filter || filter eq 'ALL'}">sort-current</c:if>">
                    ?���?
                </a>
                <a href="/member/request?filter=Y&searchKeyword=${searchKeyword}&page=1"
                   class="sort-by-text <c:if test="${filter eq 'Y'}">sort-current</c:if>">
                    ?���?
                </a>
                <a href="/member/request?filter=N&searchKeyword=${searchKeyword}&page=1"
                   class="sort-by-text <c:if test="${filter eq 'N'}">sort-current</c:if>">
                    미해�?
                </a>
            </div>
            <section class="question-list">
                <c:forEach items="${searchList }" var="request" varStatus="i">
                    <a href="/member/request/detail?requestNo=${request.requestNo }" class="atag">
                        <article class="question-item">
                            <div class="question-status-and-title">
                                <c:if test="${request.requestStatus eq 'N' }">
                                    <div class="status-tag status-unresolved">미해�?</div>
                                </c:if>
                                <c:if test="${request.requestStatus eq 'Y' }">
                                    <div class="status-tag status-resolved">?���?</div>
                                </c:if>
                                <h2 class="question-title">${request.requestTitle }</h2>
                            </div>
                            <p class="question-content">${request.requestContent }</p>
                            <div class="question-meta">
                                <span>${request.memberId }</span>
                                <span><fmt:formatDate value="${request.writeDate}" pattern="yyyy-MM-dd HH:mm"/></span>
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
                            <a href="/member/request?page=${startNavi - 1 }&searchKeyword=${searchKeyword}&filter=${filter}"
                               class="page-button">?��?��</a>
                        </c:if>
                        <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                            <a href="/member/request?page=${n }&searchKeyword=${searchKeyword}&filter=${filter}"
                               class='page-button <c:if test="${currentPage eq n }">page-current</c:if>'>${n }</a>
                        </c:forEach>
                        <c:if test="${endNavi ne maxPage }">
                            <a href="/member/request?page=${endNavi + 1 }&searchKeyword=${searchKeyword}&filter=${filter}"
                               class="page-button">?��?��</a>
                        </c:if>
                    </div>
                </div>

                <c:if test="${not empty sessionScope.loginId}">
                    <a href="/member/request/insert" class="write-button">�??���?</a>
                </c:if>
            </div>
        </main>
        <jsp:include page="../common/footer.jsp"/>
    </body>
</html>