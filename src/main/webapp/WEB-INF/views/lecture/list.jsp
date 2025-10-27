<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>강의 목록 - EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/lecture/list.css">
    </head>
    <body>
        <jsp:include page="../common/header.jsp" />
        <link rel="stylesheet" href="/resources/css/common/main_banner.css">
<section class="main-banner">
        <div class="banner-text">
            전체 강의
        </div>
        <div class="object">
            <img src="/resources/images/event/icon/event_icon.png">
        </div>
</section>
        <div class="main-container">
            <!-- Header Include -->
            <!-- Search Section -->
            <div class="search-section">
                <div class="search-title">
                    <span>🔍</span>
                    <span>강의 찾기</span>
                </div>
                <div class="search-content">
                    <div class="search-left">
                        <div class="category-label">카테고리</div>
                        <div class="category-container">
                            <div class="category-button <c:choose><c:when test='${category eq "전체"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "전체"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">전체</div>
                            </div>
                            <div class="category-button <c:choose><c:when test='${category eq "프로그래밍"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "프로그래밍"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">프로그래밍</div>
                            </div>
                            <div class="category-button <c:choose><c:when test='${category eq "디자인"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "디자인"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">디자인</div>
                            </div>
                            <div class="category-button <c:choose><c:when test='${category eq "데이터분석"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "데이터분석"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">데이터분석</div>
                            </div>
                            <div class="category-button <c:choose><c:when test='${category eq "비즈니스"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "비즈니스"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">비즈니스</div>
                            </div>
                            <div class="category-button <c:choose><c:when test='${category eq "언어"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>" onclick="selectCategory(this)">
                                <div class="category-text <c:choose><c:when test='${category eq "언어"}'>active</c:when><c:otherwise>inactive</c:otherwise></c:choose>">언어</div>
                            </div>
                        </div>
                    </div>
                    <div class="search-right">
                        <div class="course-count">총 ${totalCount }개 강의</div>
                        <div class="sort-dropdown-container">
                            <div class="sort-dropdown" onclick="toggleSortDropdown()">
                                <span class="sort-selected">${sort}</span>
                                <div class="sort-arrow"></div>
                                <div class="sort-options">
                                    <div class="sort-option <c:if test='${sort eq "인기순"}'>selected</c:if>" onclick="selectSortOption(this, '인기순')">인기순</div>
                                    <div class="sort-option <c:if test='${sort eq "최신순"}'>selected</c:if>" onclick="selectSortOption(this, '최신순')">최신순</div>
                                    <div class="sort-option <c:if test='${sort eq "별점높은순"}'>selected</c:if>" onclick="selectSortOption(this, '별점높은순')">별점높은순</div>
                                    <div class="sort-option <c:if test='${sort eq "낮은가격순"}'>selected</c:if>" onclick="selectSortOption(this, '낮은가격순')">낮은가격순</div>
                                    <div class="sort-option <c:if test='${sort eq "높은가격순"}'>selected</c:if>" onclick="selectSortOption(this, '높은가격순')">높은가격순</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Course Cards -->
            <div class="courses-container">
                <div class="courses-grid">
                    <c:forEach items="${lList }" var="lecture" varStatus="i">
                        <div class="course-card" onclick="location.href='/lecture/details?lectureNo=${lecture.lectureNo}'">
                            <img class="course-image" 
                                 src="/images/lecture/${lecture.lecturePath}" 
                                 onerror="this.src='https://placehold.co/391x235'" 
                                 alt="Course"/>
                            <div class="course-info">
                                <h3 class="course-title">${lecture.lectureName }</h3>
                                <div class="course-meta">
                                    <div class="course-meta-left">
                                        <div class="instructor-name">${lecture.memberName } 강사</div>
                                    </div>
                                    <div class="course-meta-right">
                                        <span class="course-category">${lecture.lectureCategory }</span>
                                    </div>
                                </div>
                                <div class="course-bottom">
                                    <div class="course-rating">
                                        <span class="rating">★ ${lecture.lectureRating }</span>
                                        <span class="review-count">(${lecture.countReview })</span>
                                        <span class="student-count">👤 ${lecture.countStudent }명</span>
                                    </div>
                                    <div class="course-price">₩ <fmt:formatNumber value="${lecture.lecturePrice}"
                                                                                  pattern="#,###"/></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <!-- Pagination -->
            <div class="pagination-container">
                <c:if test="${startNavi ne 1 }">
                    <a href="/lecture/list?category=${category }&sort=${sort}&page=${startNavi - 1 }<c:if test='${not empty search}'>&search=${search}</c:if>" class="pagination-next-btn">
                        <div class="pagination-next">&laquo; 이전</div>
                    </a>
                </c:if>
                <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                    <c:choose>
                        <c:when test="${currentPage eq n }">
                            <div class="pagination-current-btn">
                                <div class="pagination-current">${n }</div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a href="/lecture/list?category=${category }&sort=${sort}&page=${n }<c:if test='${not empty search}'>&search=${search}</c:if>" class="pagination-number-btn">
                                <div class="pagination-number">${n }</div>
                            </a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${endNavi ne maxPage }">
                    <a href="/lecture/list?category=${category }&sort=${sort}&page=${endNavi + 1 }<c:if test='${not empty search}'>&search=${search}</c:if>" class="pagination-next-btn">
                        <div class="pagination-next">다음 &raquo;</div>
                    </a>
                </c:if>
            </div>

        </div>
        
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />

        <script>
            function toggleSortDropdown() {
                const dropdown = document.querySelector(".sort-dropdown");
                dropdown.classList.toggle("open");
            }

            function selectCategory(element) {
                // 모든 카테고리 버튼에서 active 클래스 제거
                document.querySelectorAll(".category-button").forEach((button) => {
                    button.classList.remove("active");
                    button.classList.add("inactive");
                });
                document.querySelectorAll(".category-text").forEach((text) => {
                    text.classList.remove("active");
                    text.classList.add("inactive");
                });

                // 클릭된 버튼을 active로 설정
                element.classList.remove("inactive");
                element.classList.add("active");
                const text = element.querySelector(".category-text");
                text.classList.remove("inactive");
                text.classList.add("active");
                const category = text.textContent;

                // 선택된 카테고리 로그
                const currentSort = "${sort}"
                const currentSearch = "${search}"
                let url = "/lecture/list?category=" + category + "&sort=" + currentSort;
                if (currentSearch) {
                    url += "&search=" + encodeURIComponent(currentSearch);
                }
                window.location.href = url;
            }

            function selectSortOption(element, value) {
                // 이전 선택 제거
                document.querySelectorAll(".sort-option").forEach((option) => {
                    option.classList.remove("selected");
                });

                // 새로운 선택 표시
                element.classList.add("selected");

                // 선택된 값 업데이트
                document.querySelector(".sort-selected").textContent = value;

                // 드롭다운 닫기
                document.querySelector(".sort-dropdown").classList.remove("open");

                // 여기서 실제 정렬 로직을 구현할 수 있습니다
                console.log("선택된 정렬:", value);
                // 선택된 카테고리 로그
                const currentCategory = "${category}"
                const currentSearch = "${search}"
                let url = "/lecture/list?category=" + currentCategory + "&sort=" + value;
                if (currentSearch) {
                    url += "&search=" + encodeURIComponent(currentSearch);
                }
                window.location.href = url;
            }

            // 외부 클릭 시 드롭다운 닫기
            document.addEventListener("click", function (event) {
                const dropdown = document.querySelector(".sort-dropdown");
                if (!dropdown.contains(event.target)) {
                    dropdown.classList.remove("open");
                }
            });
        </script>
    </body>
</html>