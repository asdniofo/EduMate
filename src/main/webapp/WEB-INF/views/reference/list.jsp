<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - ?��료실</title>
<link rel="stylesheet" href="/resources/css/reference/list.css">
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
	<!-- 메인 배너 -->
	<link rel="stylesheet" href="/resources/css/common/main_banner.css">
	<section class="main-banner">
    <div class="banner-text">
        ?��료실
    </div>
        <div class="object">
            <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/reference/reference-icon.png" alt="?��료실 ?��?���?">
        </div>
	</section>
<div class="container">
    <!-- Content -->
    <div class="content">

        <!-- ?�� �??�� + 카테고리 ?��?�� -->
        <div class="category-search-wrapper">
            <!-- �??�� -->
            <form class="search-form" action="/reference/search" method="get">
                <input type="hidden" name="searchCondition" value="all" />
                <input type="text" name="searchKeyword" class="search-input" 
                       placeholder="�??��?���? ?��?��?��주세?��" value="${searchKeyword}" />
            </form>

            <!-- 카테고리 -->
            <div class="category-filter">
                <a href="/reference/list"
                   class="category-link ${empty category || category eq 'all' ? 'active' : ''}">?���?</a>
                <a href="/reference/category?category=강의 ?���?"
                   class="category-link ${category eq '강의 ?���?' ? 'active' : ''}">강의 ?���?</a>
                <a href="/reference/category?category=기�? ?���?"
                   class="category-link ${category eq '기�? ?���?' ? 'active' : ''}">기�? ?���?</a>
            </div>
        </div>

        <!-- ?�� �??�� 결과 ?��?�� -->
        <c:if test="${not empty searchKeyword}">
            <div style="padding: 10px 0; color: #666;">
                ??${searchKeyword}?? �??�� 결과
                <c:if test="${not empty searchList}">
                    (${fn:length(searchList)}�?)
                </c:if>
            </div>
        </c:if>

        <!-- ?�� ?���? 목록 -->
        <c:choose>
            <c:when test="${empty rList and empty searchList}">
                <div style="text-align: center; padding: 50px; color: #999;">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            �??�� 결과�? ?��?��?��?��.
                        </c:when>
                        <c:otherwise>
                            ?��록된 ?��료�? ?��?��?��?��.
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:when>
            <c:otherwise>
                <div class="reference-list">
                    <c:set var="displayList" value="${not empty searchList ? searchList : rList}" />
                    <c:forEach var="ref" items="${displayList}">
                        <div class="reference-item" onclick="location.href='/reference/detail?archiveNo=${ref.archiveNo}'">
                            <div class="reference-info">
                                <div class="reference-category">${ref.archiveType}</div>
                                <div class="reference-title">${ref.archiveTitle}</div>
                            </div>
                            <div class="reference-date">
                                <fmt:formatDate value="${ref.writeDate}" pattern="yyyy.MM.dd" />
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- ?�� ?��?���??��?��?�� + �??���? 버튼 -->
        <div class="pagination-wrapper">
            <div class="pagination">
                <!-- ?�� ?��?�� 버튼 (showPrev�? �?�?) -->
                <c:if test="${showPrev}">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${startNavi-1}'">?��?��</button>
                        </c:when>
                        <c:when test="${not empty category}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/category?category=${category}&page=${startNavi-1}'">?��?��</button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='/reference/list?page=${startNavi-1}'">?��?��</button>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <!-- ?��?���? 번호 -->
                <c:forEach var="page" begin="${startNavi}" end="${endNavi}">
                    <c:choose>
                        <c:when test="${page == currentPage}">
                            <button class="page-btn active">${page}</button>
                        </c:when>
                        <c:otherwise>
                            <c:choose>
                                <c:when test="${not empty searchKeyword}">
                                    <button class="page-btn"
                                            onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${page}'">${page}</button>
                                </c:when>
                                <c:when test="${not empty category}">
                                    <button class="page-btn"
                                            onclick="location.href='/reference/category?category=${category}&page=${page}'">${page}</button>
                                </c:when>
                                <c:otherwise>
                                    <button class="page-btn"
                                            onclick="location.href='/reference/list?page=${page}'">${page}</button>
                                </c:otherwise>
                            </c:choose>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- ?�� ?��?�� 버튼 (showNext�? �?�?) -->
                <c:if test="${showNext}">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${endNavi+1}'">?��?��</button>
                        </c:when>
                        <c:when test="${not empty category}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/category?category=${category}&page=${endNavi+1}'">?��?��</button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='/reference/list?page=${endNavi+1}'">?��?��</button>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>

            <!-- �??���? 버튼 -->
            <c:if test="${canWrite}">
                <a href="/reference/insert" class="write-button">�??���?</a>
            </c:if>
        </div>

    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
