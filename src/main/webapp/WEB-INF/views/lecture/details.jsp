<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>강의 상세 - EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/lecture/details.css">
    </head>
    <body>
        <div class="main-container">
            <!-- Header Include -->
            <jsp:include page="../common/header.jsp" />

            <!-- Course Hero Section -->
            <div class="course-hero">
                <img class="course-image" src="/images/lecture/${lList[0].lecturePath}"
                     onerror="this.src='https://placehold.co/391x235'"
                     alt="Course"/>
                <div class="course-details">
                    <h1 class="course-title">${lList[0].lectureName}</h1>
                    <p class="course-description" id="course-description">
                        ${lList[0].lectureContent}
                    </p>
                    <span class="description-toggle" id="description-toggle" onclick="toggleDescription()">
            더보기
            <div class="toggle-arrow"></div>
          </span>
                    <div class="course-instructor">${lList[0].memberName} 강사</div>
                    <div class="course-meta">
                        <div class="course-meta-left">
                            <div class="course-rating">
                                <span class="rating-stars" id="rating-stars"></span>
                                (${lList[0].lectureRating}) 수강평 ${lList[0].countReview}개
                            </div>
                            <div class="course-students">수강생 ${lList[0].countStudent}명</div>
                        </div>
                        <div class="course-purchase">
                            <div class="course-price">₩ <fmt:formatNumber value="${lList[0].lecturePrice}"
                                                                          pattern="#,###"/></div>
                            <button class="purchase-button" onclick="location.href='/lecture/payment?lectureNo=${lList[0].lectureNo}'">수강 신청</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Navigation Tabs -->
            <div class="nav-tabs">
                <div class="nav-tab active" onclick="switchTab(this, 'curriculum')">커리큘럼</div>
                <div class="nav-tab" onclick="switchTab(this, 'reviews')">수강평</div>
            </div>

            <!-- Curriculum Section -->
            <div class="curriculum-section" id="curriculum-section">
                <div class="curriculum-header">
                    <h2 class="curriculum-title">커리큘럼</h2>
                    <div class="curriculum-summary">전체 ${videoCount}개 · (${totalTimeFormatted})</div>
                </div>
                <div class="curriculum-list">
                    <c:forEach var="video" items="${vList}">
                        <div class="curriculum-item" onclick="location.href='/lecture/player?videoNo=${video.videoNo}'">
                            <div class="curriculum-icon"></div>
                            <div class="curriculum-content">
                                <div class="curriculum-lesson">${video.videoOrder}. ${video.videoTitle}</div>
                            </div>
                            <div class="curriculum-duration">${video.time}</div>
                        </div>
                    </c:forEach>
                </div>
            </div>

            <!-- Reviews Section -->
            <div class="reviews-section" id="reviews-section">
                <div class="reviews-header">
                    <h2 class="reviews-title">수강평</h2>
                    <div class="reviews-summary">
                        <div class="reviews-rating">
                            <span class="rating-stars" id="reviews-rating-stars"></span>
                            ${lList[0].lectureRating}(${lList[0].countReview})
                        </div>
                        <div class="reviews-sort">
                            <span class="reviews-count">전체 ${lList[0].countReview}개</span>
                            <div class="sort-dropdown-container">
                                <div class="sort-dropdown" onclick="toggleSortDropdown()">
                                    <span class="sort-selected">최신순</span>
                                    <div class="sort-arrow"></div>
                                    <div class="sort-options">
                                        <div class="sort-option <c:if test='${sort eq "최신순"}'>selected</c:if>"
                                             onclick="selectSortOption(this, '최신순')">최신순
                                        </div>
                                        <div class="sort-option <c:if test='${sort eq "별점높은순"}'>selected</c:if>"
                                             onclick="selectSortOption(this, '별점높은순')">별점높은순
                                        </div>
                                        <div class="sort-option <c:if test='${sort eq "별점낮은순"}'>selected</c:if>"
                                             onclick="selectSortOption(this, '별점낮은순')">별점낮은순
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="reviews-list" id="reviews-list">
                    <c:forEach var="review" items="${rList}" varStatus="status">
                        <div class="review-item" data-index="${status.index}" data-rating="${review.reviewRating}"
                             data-date="${review.reviewDate}">
                            <div class="review-header">
                                <div class="review-user">
                                    <div class="review-username">${review.memberName}</div>
                                    <div class="review-date">
                                        <fmt:formatDate value="${review.reviewDate}" pattern="yyyy.MM.dd"/>
                                    </div>
                                </div>
                                <div class="review-rating">
                                    <span class="rating-stars review-stars-${status.index + 1}"></span>
                                    <span>${review.reviewRating}</span>
                                </div>
                            </div>
                            <div class="review-content">${review.reviewContent}</div>
                        </div>
                    </c:forEach>
                </div>
                <button class="show-more-button" id="show-more-button" onclick="showMoreReviews()">
                    더보기
                    <div class="show-more-arrow"></div>
                </button>
            </div>

        </div>
        
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />

        <script>
            function switchTab(element, section) {
                // 모든 탭에서 active 클래스 제거
                document.querySelectorAll(".nav-tab").forEach((tab) => {
                    tab.classList.remove("active");
                });

                // 클릭된 탭에 active 클래스 추가
                element.classList.add("active");

                // 모든 섹션 숨기기
                document.getElementById("curriculum-section").style.display = "none";
                document.getElementById("reviews-section").style.display = "none";

                // 선택된 섹션만 보이기
                if (section === "curriculum") {
                    document.getElementById("curriculum-section").style.display = "block";
                } else if (section === "reviews") {
                    document.getElementById("reviews-section").style.display = "block";
                }
            }

            function toggleSortDropdown() {
                const dropdown = document.querySelector(".sort-dropdown");
                dropdown.classList.toggle("open");
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

                // 리뷰 정렬 실행
                sortReviews(value);
            }

            // 외부 클릭 시 드롭다운 닫기
            document.addEventListener("click", function (event) {
                const dropdown = document.querySelector(".sort-dropdown");
                if (!dropdown.contains(event.target)) {
                    dropdown.classList.remove("open");
                }
            });

            function toggleDescription() {
                const description = document.getElementById("course-description");
                const toggle = document.getElementById("description-toggle");

                if (description.classList.contains("expanded")) {
                    description.classList.remove("expanded");
                    toggle.classList.remove("expanded");
                    toggle.innerHTML = '더보기<div class="toggle-arrow"></div>';
                } else {
                    description.classList.add("expanded");
                    toggle.classList.add("expanded");
                    toggle.innerHTML = '접기<div class="toggle-arrow"></div>';
                }
            }

            function generateStars(rating, containerId = "rating-stars") {
                const starsContainer = document.getElementById(containerId.replace("#", ""));
                if (!starsContainer) return;

                const fullStars = Math.floor(rating); // 정수 부분
                const partialStar = rating - fullStars; // 소수 부분
                const totalStars = 5;

                let starsHTML = "";

                // 완전한 별들 (정수 부분)
                for (let i = 0; i < fullStars; i++) {
                    starsHTML += '<span class="star">★</span>';
                }

                // 부분적인 별 (소수 부분이 있을 때)
                if (partialStar > 0 && fullStars < totalStars) {
                    const percentage = Math.round(partialStar * 100);
                    starsHTML += `<span class="star partial" style="background: linear-gradient(90deg, #f39c12 ${percentage}%, #ddd ${percentage}%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">★</span>`;
                }

                // 빈 별들 (나머지)
                const remainingStars = totalStars - fullStars - (partialStar > 0 ? 1 : 0);
                for (let i = 0; i < remainingStars; i++) {
                    starsHTML += '<span class="star empty">★</span>';
                }

                starsContainer.innerHTML = starsHTML;
            }

            function generateReviewStars(rating, containerId) {
                const starsContainer = document.querySelector(containerId);
                if (!starsContainer) return;

                const fullStars = Math.floor(rating); // 정수 부분
                const partialStar = rating - fullStars; // 소수 부분
                const totalStars = 5;

                let starsHTML = "";

                // 완전한 별들 (정수 부분)
                for (let i = 0; i < fullStars; i++) {
                    starsHTML += '<span class="star">★</span>';
                }

                // 부분적인 별 (소수 부분이 있을 때)
                if (partialStar > 0 && fullStars < totalStars) {
                    const percentage = Math.round(partialStar * 100);
                    starsHTML += `<span class="star partial" style="background: linear-gradient(90deg, #f39c12 ${percentage}%, #ddd ${percentage}%); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">★</span>`;
                }

                // 빈 별들 (나머지)
                const remainingStars = totalStars - fullStars - (partialStar > 0 ? 1 : 0);
                for (let i = 0; i < remainingStars; i++) {
                    starsHTML += '<span class="star empty">★</span>';
                }

                starsContainer.innerHTML = starsHTML;
            }

            // 리뷰 페이지네이션 관련 변수
            let currentVisibleReviews = 4;
            const reviewsPerPage = 4;
            let totalReviews = 0;
            let reviewsData = [];
            let currentSortType = '최신순';

            function showMoreReviews() {
                const reviewItems = document.querySelectorAll('.review-item');
                const showMoreButton = document.getElementById('show-more-button');

                // 현재 보이는 리뷰 수를 4개씩 증가
                currentVisibleReviews += reviewsPerPage;

                // 리뷰 아이템들을 순차적으로 표시
                reviewItems.forEach((item, index) => {
                    if (index < currentVisibleReviews) {
                        item.classList.remove('hidden');
                    }
                });

                // 모든 리뷰가 표시되면 더보기 버튼 숨기기
                if (currentVisibleReviews >= totalReviews) {
                    showMoreButton.style.display = 'none';
                }
            }

            function sortReviews(sortType) {
                currentSortType = sortType;
                const reviewsList = document.getElementById('reviews-list');
                const reviewItems = Array.from(reviewsList.querySelectorAll('.review-item'));

                reviewItems.sort((a, b) => {
                    switch (sortType) {
                        case '최신순':
                            const dateA = new Date(a.getAttribute('data-date'));
                            const dateB = new Date(b.getAttribute('data-date'));
                            return dateB - dateA;
                        case '별점높은순':
                            const ratingA = parseFloat(a.getAttribute('data-rating'));
                            const ratingB = parseFloat(b.getAttribute('data-rating'));
                            return ratingB - ratingA;
                        case '별점낮은순':
                            const ratingA2 = parseFloat(a.getAttribute('data-rating'));
                            const ratingB2 = parseFloat(b.getAttribute('data-rating'));
                            return ratingA2 - ratingB2;
                        default:
                            return 0;
                    }
                });

                // 정렬된 순서로 다시 배치
                reviewItems.forEach((item, index) => {
                    item.setAttribute('data-index', index);
                    reviewsList.appendChild(item);
                });

                resetPagination();
            }

            function resetPagination() {
                currentVisibleReviews = 4;
                const reviewItems = document.querySelectorAll('.review-item');
                totalReviews = reviewItems.length;

                reviewItems.forEach((item, index) => {
                    if (index >= 4) {
                        item.classList.add('hidden');
                    } else {
                        item.classList.remove('hidden');
                    }
                });

                // 더보기 버튼 표시/숨김
                const showMoreButton = document.getElementById('show-more-button');
                if (totalReviews <= 4) {
                    showMoreButton.style.display = 'none';
                } else {
                    showMoreButton.style.display = 'flex';
                }
            }

            function initializeReviews() {
                const reviewItems = document.querySelectorAll('.review-item');
                totalReviews = reviewItems.length;

                // 처음에는 4개만 보이고 나머지는 숨기기
                reviewItems.forEach((item, index) => {
                    if (index >= 4) {
                        item.classList.add('hidden');
                    }
                });

                // 리뷰가 4개 이하이면 더보기 버튼 숨기기
                const showMoreButton = document.getElementById('show-more-button');
                if (totalReviews <= 4) {
                    showMoreButton.style.display = 'none';
                } else {
                    showMoreButton.style.display = 'flex';
                }
            }

            // 페이지 로드 시 별점 생성 및 리뷰 초기화
            document.addEventListener("DOMContentLoaded", function () {
                generateStars(${lList[0].lectureRating}); // 메인 별점 생성

                // 수강평 별점들 동적 생성
                <c:forEach var="review" items="${rList}" varStatus="status">
                generateReviewStars(${review.reviewRating}, ".review-stars-${status.index + 1}");
                </c:forEach>

                // 수강평 헤더 별점 생성
                generateStars(${lList[0].lectureRating}, "#reviews-rating-stars");

                // 리뷰 페이지네이션 초기화
                initializeReviews();
            });
        </script>
    </body>
</html>
