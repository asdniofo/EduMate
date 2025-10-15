<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료실</title>
<link rel="stylesheet" href="../../../resource/css/reference/list.css">
</head>
<body>
	<div class="container">
		<!-- Header -->
		

		<!-- Navigation -->
		<div style="display: flex; gap: 50px; padding: 30px 100px; font-size: 18px;">
			<a href="#" style="text-decoration: none; color: #FAFAFA; font-weight: 700;">카테고리</a>
			<a href="#" style="text-decoration: none; color: black;">강의/강좌</a>
			<a href="#" style="text-decoration: none; color: black;">내 강의실</a>
			<a href="#" style="text-decoration: none; color: black;">자료실</a>
			<a href="#" style="text-decoration: none; color: black;">공지사항</a>
			<a href="#" style="text-decoration: none; color: black;">특가</a>
		</div>

		<!-- Content Area -->
		<div class="content">
			<div class="title">자료실</div>

			<!-- Category Filter -->
			<div class="category-filter">
				<button class="category-btn active">전체</button>
				<button class="category-btn">강의자료</button>
				<button class="category-btn">기타 자료</button>
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
							<div class="reference-item" onclick="location.href='/reference/detail?referenceNo=${ref.referenceNo}'">
								<div class="reference-info">
									<div class="reference-category">${ref.referenceCategory}</div>
									<div class="reference-title">${ref.referenceTitle}</div>
								</div>
								<div class="reference-date">
									<fmt:formatDate value="${ref.referenceDate}" pattern="yyyy.MM.dd"/>
								</div>
							</div>
						</c:forEach>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
					</div>
				</c:otherwise>
			</c:choose>

			<!-- Pagination -->
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

			<!-- Write Button -->
			<button class="write-btn" onclick="location.href='/reference/insert'">글쓰기</button>
		</div>

		<!-- Footer -->
		
	</div>
</body>
</html>