<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료실</title>
<link rel="stylesheet" href="/resources/css/reference/list.css">
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
<div class="container">
    <!-- Header -->
    <jsp:include page="../common/header.jsp" />

    <!-- <div class="page-title-section">
        <div class="page-title-text">자료실</div>
        <img class="page-title-image" src="/resources/img/reference-icon.png" alt="이미지" />
    </div> -->
    <section class="hero-section-wrapper">
		<div class="hero-section">
			<h1 class="hero-title">자료실</h1>
			<img src="/resources/img/reference-icon.png"
				alt="공지 아이콘" class="hero-image" />
		</div>
	</section>

    <!-- Content -->
    <div class="content">

        <!-- ✅ 검색 + 카테고리 필터 -->
        <div class="category-search-wrapper">
            <!-- 검색 -->
            <form class="search-form" action="/reference/search" method="get">
                <input type="hidden" name="searchCondition" value="all" />
                <input type="text" name="searchKeyword" class="search-input" 
                       placeholder="검색어를 입력해주세요" value="${searchKeyword}" />
            </form>

            <!-- 카테고리 -->
            <div class="category-filter">
                <a href="/reference/list"
                   class="category-link ${empty category || category eq 'all' ? 'active' : ''}">전체</a>
                <a href="/reference/category?category=강의 자료"
                   class="category-link ${category eq '강의 자료' ? 'active' : ''}">강의 자료</a>
                <a href="/reference/category?category=기타 자료"
                   class="category-link ${category eq '기타 자료' ? 'active' : ''}">기타 자료</a>
            </div>
        </div>

        <!-- ✅ 검색 결과 안내 -->
        <c:if test="${not empty searchKeyword}">
            <div style="padding: 10px 0; color: #666;">
                ‘${searchKeyword}’ 검색 결과
                <c:if test="${not empty searchList}">
                    (${fn:length(searchList)}건)
                </c:if>
            </div>
        </c:if>

        <!-- ✅ 자료 목록 -->
        <c:choose>
            <c:when test="${empty rList and empty searchList}">
                <div style="text-align: center; padding: 50px; color: #999;">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            검색 결과가 없습니다.
                        </c:when>
                        <c:otherwise>
                            등록된 자료가 없습니다.
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

        <!-- ✅ 페이지네이션 + 글쓰기 버튼 -->
        <div class="pagination-wrapper">
            <div class="pagination">
                <!-- ✅ 이전 버튼 (showPrev로 변경) -->
                <c:if test="${showPrev}">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${startNavi-1}'">이전</button>
                        </c:when>
                        <c:when test="${not empty category}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/category?category=${category}&page=${startNavi-1}'">이전</button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='/reference/list?page=${startNavi-1}'">이전</button>
                        </c:otherwise>
                    </c:choose>
                </c:if>

                <!-- 페이지 번호 -->
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

                <!-- ✅ 다음 버튼 (showNext로 변경) -->
                <c:if test="${showNext}">
                    <c:choose>
                        <c:when test="${not empty searchKeyword}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${endNavi+1}'">다음</button>
                        </c:when>
                        <c:when test="${not empty category}">
                            <button class="page-btn"
                                    onclick="location.href='/reference/category?category=${category}&page=${endNavi+1}'">다음</button>
                        </c:when>
                        <c:otherwise>
                            <button class="page-btn"
                                    onclick="location.href='/reference/list?page=${endNavi+1}'">다음</button>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>

            <!-- 글쓰기 버튼 -->
            <c:if test="${canWrite}">
                <a href="/reference/insert" class="write-button">글쓰기</a>
            </c:if>
        </div>

    </div>
</div>

<jsp:include page="../common/footer.jsp" />
</body>
</html>
