<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>details</title>
        <link rel="stylesheet" href="../resources/css/lecture/details.css">
    </head>
    <body>
        <div class="main-container">
            <!-- Header -->
            <div class="header-bar">
                <div class="header-text">헤더</div>
            </div>

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
                            <button class="purchase-button">수강 신청</button>
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
                    <div class="curriculum-summary">전체 13개 · (2시간 20분)</div>
                </div>
                <div class="curriculum-list">
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">1. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">2. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">3. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">4. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">5. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">6. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">7. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">8. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">9. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">10. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">11. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">12. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                    <div class="curriculum-item">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">13. [개념] 빠르게 이해하는 딥러닝 개요</div>
                        </div>
                        <div class="curriculum-duration">15:35</div>
                    </div>
                </div>
            </div>

            <!-- Reviews Section -->
            <div class="reviews-section" id="reviews-section" style="display: none">
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
                                        <div class="sort-option selected" onclick="selectSortOption(this, '최신순')">최신순
                                        </div>
                                        <div class="sort-option" onclick="selectSortOption(this, '인기순')">인기순</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="reviews-list">
                    <div class="review-item">
                        <div class="review-header">
                            <div class="review-user">
                                <div class="review-username">olauser1</div>
                                <div class="review-date">2025.10.22</div>
                            </div>
                            <div class="review-rating">
                                <span class="rating-stars review-stars-1"></span>
                                <span>5</span>
                            </div>
                        </div>
                        <div class="review-content">강의가 이해하기 쉽고 도움이 많이됩니다.</div>
                    </div>
                    <div class="review-item">
                        <div class="review-header">
                            <div class="review-user">
                                <div class="review-username">olauser1</div>
                                <div class="review-date">2025.10.22</div>
                            </div>
                            <div class="review-rating">
                                <span class="rating-stars review-stars-2"></span>
                                <span>5</span>
                            </div>
                        </div>
                        <div class="review-content">강의가 이해하기 쉽고 도움이 많이됩니다.</div>
                    </div>
                    <div class="review-item">
                        <div class="review-header">
                            <div class="review-user">
                                <div class="review-username">olauser1</div>
                                <div class="review-date">2025.10.22</div>
                            </div>
                            <div class="review-rating">
                                <span class="rating-stars review-stars-3"></span>
                                <span>5</span>
                            </div>
                        </div>
                        <div class="review-content">강의가 이해하기 쉽고 도움이 많이됩니다.</div>
                    </div>
                    <div class="review-item">
                        <div class="review-header">
                            <div class="review-user">
                                <div class="review-username">olauser1</div>
                                <div class="review-date">2025.10.22</div>
                            </div>
                            <div class="review-rating">
                                <span class="rating-stars review-stars-4"></span>
                                <span>5</span>
                            </div>
                        </div>
                        <div class="review-content">강의가 이해하기 쉽고 도움이 많이됩니다.</div>
                    </div>
                </div>
                <button class="show-more-button">
                    더보기
                    <div class="show-more-arrow"></div>
                </button>
            </div>

            <!-- Footer -->
            <div class="footer-bar">
                <div class="footer-text">푸터</div>
            </div>
        </div>

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

                // 여기서 실제 정렬 로직을 구현할 수 있습니다
                console.log("선택된 정렬:", value);
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
                    starsHTML += `<span class="star" style="opacity: ${partialStar}">★</span>`;
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
                    starsHTML += `<span class="star" style="opacity: ${partialStar}">★</span>`;
                }

                // 빈 별들 (나머지)
                const remainingStars = totalStars - fullStars - (partialStar > 0 ? 1 : 0);
                for (let i = 0; i < remainingStars; i++) {
                    starsHTML += '<span class="star empty">★</span>';
                }

                starsContainer.innerHTML = starsHTML;
            }

            // 페이지 로드 시 별점 생성
            document.addEventListener("DOMContentLoaded", function () {
                generateStars(${lList[0].lectureRating}); // 메인 별점 생성

                // 수강평 별점들 생성 (모두 5점으로 설정)
                generateReviewStars(5.0, ".review-stars-1");
                generateReviewStars(5.0, ".review-stars-2");
                generateReviewStars(5.0, ".review-stars-3");
                generateReviewStars(5.0, ".review-stars-4");

                // 수강평 헤더 별점 생성
                generateStars(${lList[0].lectureRating}, "#reviews-rating-stars");
            });
        </script>
    </body>
</html>
