<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료실</title>
<link rel="stylesheet" href="../../../resources/css/reference/list.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">
</head>
<body>
	<div class="container">
		<!-- Header -->
		<jsp:include page="/WEB-INF/views/common/header.jsp" />

			
		<div class="page-title-section">
		  <div class="page-title-text">자료실</div>
		  <img class="page-title-image" src="/resources/img/reference-icon.png" alt="이미지" />
		</div>
		
		<!-- Content Area -->
		<div class="content">

			<div class="category-search-wrapper">
			  <form class="search-form" action="/reference/list" method="get">
			    <input type="text" name="keyword" class="search-input" placeholder="검색어를 입력해주세요" value="${param.keyword}" />
			  </form>
			  <div class="category-filter">
			    <button class="category-btn active">전체</button>
			    <button class="category-btn">강의자료</button>
			    <button class="category-btn">기타 자료</button>
			  </div>
			
			</div>
			

			<!-- Reference List -->
			<c:choose>
				<c:when test="${empty rList}">
					<div style="text-align: center; padding: 50px; color: #999;">
						등록된 자료가 없습니다.
					</div>
				</c:when>
				<c:otherwise>
					<div class="reference-list">
						<c:forEach var="ref" items="${rList}">
							<div class="reference-item" onclick="location.href='/reference/detail?archiveNo=${ref.archiveNo}'">
								<div class="reference-info">
									<div class="reference-category">${ref.archiveType}</div>
									<div class="reference-title">${ref.archiveTitle}</div>
								</div>
								<div class="reference-date">
									<fmt:formatDate value="${ref.writeDate}" pattern="yyyy.MM.dd"/>
								</div>
							</div>
						</c:forEach>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
					</div>
				</c:otherwise>
			</c:choose>

			<!-- Pagination + Write Button Wrapper -->
			<div class="pagination-wrapper">
				<div class="pagination">
					<c:if test="${currentPage > 1}">
						<button class="page-btn" onclick="location.href='/reference/list?page=${currentPage-1}'">이전</button>
					</c:if>
					<c:if test="${currentPage == 1}">
						<button class="page-btn" disabled>이전</button>
					</c:if>
			
					<c:forEach var="page" begin="${startNavi}" end="${endNavi}">
						<c:choose>
							<c:when test="${page == currentPage}">
								<button class="page-btn active">${page}</button>
							</c:when>
							<c:otherwise>
								<button class="page-btn" onclick="location.href='/reference/list?page=${page}'">${page}</button>
							</c:otherwise>
						</c:choose>
					</c:forEach>
			
					<c:if test="${currentPage < maxPage}">
						<button class="page-btn" onclick="location.href='/reference/list?page=${currentPage+1}'">다음</button>
					</c:if>
					<c:if test="${currentPage == maxPage}">
						<button class="page-btn" disabled>다음</button>
					</c:if>
				</div>

				<!-- 글쓰기 버튼 -->
				<a href="/reference/insert" class="write-button">글쓰기</a>
			</div>

			
		
		</div>

	</div>
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>