<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EduMate - 자료실</title>
<link rel="stylesheet" href="../resources/css/reference/list.css">
<link rel="stylesheet" href="/resources/css/common/header.css">
<link rel="stylesheet" href="/resources/css/common/footer.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">


</head>
<body>
	<div class="container">
		<!-- Header -->
        <jsp:include page="../common/header.jsp" />

		<div class="page-title-section">
		  <div class="page-title-text">자료실</div>
		  <img class="page-title-image" src="/resources/img/reference-icon.png" alt="이미지" />
		</div>
		
		<!-- Content Area -->
		<div class="content">

			<div class="category-search-wrapper">
			  <form class="search-form" action="/reference/search" method="get">
			    <input type="hidden" name="searchCondition" value="all" />
			    <input type="text" name="searchKeyword" class="search-input" 
			           placeholder="검색어를 입력해주세요" value="${searchKeyword}" />
			  </form>

			  <!-- ✅ 버튼 → 텍스트 링크형 카테고리 -->
			  <div class="category-filter">
			    <a href="#" class="category-link active" data-category="all">전체</a>
			    <a href="#" class="category-link" data-category="강의 자료">강의 자료</a>
			    <a href="#" class="category-link" data-category="기타 자료">기타 자료</a>
			  </div>
			</div>
			
			<!-- 검색 결과 표시 -->
			<c:if test="${not empty searchKeyword}">
				<div style="padding: 10px 0; color: #666;">
					'${searchKeyword}' 검색 결과 
					<c:if test="${not empty searchList}">
						(${fn:length(searchList)}건)
					</c:if>
				</div>
			</c:if>

			<!-- Reference List -->
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
							<div class="reference-item" data-category="${ref.archiveType}" onclick="location.href='/reference/detail?archiveNo=${ref.archiveNo}'">
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
					
					<!-- ✅ 1~5페이지에서는 이전 버튼 숨김 -->
					<c:if test="${currentPage > 5}">
						<c:choose>
							<c:when test="${not empty searchKeyword}">
								<button class="page-btn" onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${currentPage-1}'">이전</button>
							</c:when>
							<c:otherwise>
								<button class="page-btn" onclick="location.href='/reference/list?page=${currentPage-1}'">이전</button>
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
										<button class="page-btn" onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${page}'">${page}</button>
									</c:when>
									<c:otherwise>
										<button class="page-btn" onclick="location.href='/reference/list?page=${page}'">${page}</button>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</c:forEach>

					<!-- ✅ 마지막 5페이지 구간에서는 다음 버튼 숨김 -->
					<c:if test="${currentPage < maxPage - 4}">
						<c:choose>
							<c:when test="${not empty searchKeyword}">
								<button class="page-btn" onclick="location.href='/reference/search?searchCondition=${searchCondition}&searchKeyword=${searchKeyword}&page=${currentPage+1}'">다음</button>
							</c:when>
							<c:otherwise>
								<button class="page-btn" onclick="location.href='/reference/list?page=${currentPage+1}'">다음</button>
							</c:otherwise>
						</c:choose>
					</c:if>

				</div>

				<!-- 글쓰기 버튼 -->
				<a href="/reference/insert" class="write-button">글쓰기</a>
			</div>
		
		</div>

	</div>
    <jsp:include page="../common/footer.jsp" />
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const categoryLinks = document.querySelectorAll('.category-link');
        const referenceItems = document.querySelectorAll('.reference-item');
        
        categoryLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();

                // 모든 링크의 active 클래스 제거
                categoryLinks.forEach(l => l.classList.remove('active'));
                
                // 클릭한 링크에 active 추가
                this.classList.add('active');
                
                const selectedCategory = this.getAttribute('data-category');
                
                // 항목 필터링
                referenceItems.forEach(item => {
                    const itemCategory = item.getAttribute('data-category');
                    if (selectedCategory === 'all' || selectedCategory === itemCategory) {
                        item.classList.remove('hidden');
                    } else {
                        item.classList.add('hidden');
                    }
                });
            });
        });
    });
    </script>
</body>
</html>
