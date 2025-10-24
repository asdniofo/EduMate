<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>마이페이지 | EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/member/mypage.css">
        <script src="https://js.tosspayments.com/v1/payment"></script>
    </head>
    <body>
        <div class="main-container">
            <!-- Header Include -->
            <jsp:include page="../common/header.jsp"/>

            <!-- 히어로 섹션 -->
            <section class="hero-section-wrapper">
                <div class="hero-section">
                    <h1 class="hero-title">마이페이지</h1>
                    <img src="/resources/images/member/mypage.png" alt="마이페이지 아이콘" class="hero-image"/>
                </div>
            </section>

            <!-- 메인 콘텐츠 -->
            <div class="main-content">
                <div class="mypage-content">

                    <!-- 프로필 섹션 -->
                    <div class="profile-section">
                        <img class="profile-image" src="/resources/images/common/mypage1.png" alt="">
                        <div class="profile-info">
                            <div class="user-grade">${memberType}</div>
                            <div class="user-name">
                                <c:choose>
                                    <c:when test="${not empty memberInfo.memberName}">
                                        ${memberInfo.memberName}님
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.loginId}님
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stats-container">
                                <div class="stat-item">
                                    <div class="stat-number"><fmt:formatNumber value="${memberInfo.memberMoney}"
                                                                               pattern="#,###"/></div>
                                    <div class="stat-label">잔고</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCount + questionCount}</div>
                                    <div class="stat-label">작성글 수</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCommentCount + questionCommentCount}</div>
                                    <div class="stat-label">댓글 수</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 현재 수강중인 강의 -->
                    <div class="section">
                        <div class="section-header">
                            <h2 class="section-title">현재 수강중인 강의</h2>
                            <!-- 검색 박스를 header 안으로 이동 -->
                            <div class="course-search-box">
                                <input type="text" id="courseSearchInput" placeholder="강의명, 강사명을 입력하세요"
                                       onkeypress="handleCourseSearchEnter(event)">
                                <button onclick="searchCourses()">🔍</button>
                            </div>
                        </div>

                        <div class="course-content" id="courseContent">
                            <c:choose>
                                <c:when test="${not empty lectureList}">
                                    <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                                        <a href="/lecture/details?lectureNo=${lecture.lectureNo}"
                                           class="course-item ${status.index >= 3 ? 'hidden-course' : ''}"
                                           style="${status.index >= 3 ? 'display: none;' : ''}">
                                            <div class="course-title">${lecture.lectureName}</div>
                                            <div class="course-instructor">${lecture.memberName}</div>
                                            <div class="course-category">${lecture.lectureCategory}</div>
                                        </a>
                                    </c:forEach>
                                    <c:if test="${fn:length(lectureList) > 3}">
                                        <div class="toggle-courses-btn" onclick="toggleCourses()">
                                            <span id="toggleText">더보기 (${fn:length(lectureList) - 3}개)</span>
                                            <span id="toggleIcon">▼</span>
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <div style="text-align: center; color: #999; padding: 40px;">
                                        수강중인 강의가 없습니다.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <c:choose>
                        <c:when test="${sessionScope.teacherYn eq 'Y'}">
                            <div class="section">
                                <a href="/lecture/add" class="menu-item">
                                    <div class="menu-icon">📚</div>
                                    <div class="menu-text">강의 추가</div>
                                </a>
                            </div>
                        </c:when>
                    </c:choose>
                    <!-- 잔고 충전하기 -->
                    <div class="section">
                        <a href="javascript:void(0);" onclick="openChargePopup();" class="menu-item">
                            <div class="menu-icon">💰</div>
                            <div class="menu-text">잔고 충전하기</div>
                        </a>
                    </div>

                    <!-- 내가 작성한 게시물 -->
                    <div class="section">
                        <a href="/member/mypost" class="menu-item">
                            <div class="menu-icon">📝</div>
                            <div class="menu-text">내가 작성한 게시물</div>
                        </a>
                    </div>

                    <!-- 내가 작성한 댓글 -->
                    <div class="section">
                        <a href="/member/mycomment" class="menu-item">
                            <div class="menu-icon">💬</div>
                            <div class="menu-text">내가 작성한 댓글</div>
                        </a>
                    </div>

                    <!-- 내 정보 수정 -->
                    <div class="section">
                        <a href="/member/edit" class="menu-item">
                            <div class="menu-icon">⚙️</div>
                            <div class="menu-text">내 정보 수정</div>
                        </a>
                    </div>

                    <!-- 로그아웃 -->
                    <div class="section">
                        <a href="/member/logout" class="menu-item">
                            <div class="menu-icon">🚪</div>
                            <div class="menu-text">로그아웃</div>
                        </a>
                    </div>

                    <!-- 회원 탈퇴 -->
                    <div class="section">
                        <a href="javascript:void(0);" onclick="deleteMember();" class="menu-item">
                            <div class="menu-icon">⚠️</div>
                            <div class="menu-text">회원 탈퇴</div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 충전 팝업 -->
            <div class="charge-popup-overlay" id="chargePopupOverlay">
                <div class="charge-popup">
                    <h3 class="charge-popup-title">💰 잔액 충전</h3>

                    <div class="charge-amount-section">
                        <input type="text" class="charge-amount-input" id="chargeAmountInput"
                               placeholder="충전할 금액을 입력하세요">
                        <div class="charge-amount-buttons">
                            <button class="charge-amount-btn" onclick="setChargeAmount(10000)">10,000원</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(30000)">30,000원</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(50000)">50,000원</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(100000)">100,000원</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(300000)">300,000원</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(500000)">500,000원</button>
                        </div>
                    </div>

                    <div class="charge-popup-buttons">
                        <button class="charge-popup-btn cancel" onclick="closeChargePopup()">취소</button>
                        <button class="charge-popup-btn confirm" onclick="processCharge()">충전하기</button>
                    </div>
                </div>
            </div>

            <script>
                let chargeAmount = 0;

                // 충전 관련 함수들
                function openChargePopup() {
                    // 마이페이지에서 충전하는 것임을 서버에 알림 (세션 정리용)
                    fetch('/member/clearLectureSession', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        }
                    }).then(() => {
                        const popup = document.getElementById('chargePopupOverlay');
                        if (popup) {
                            popup.style.display = 'flex';
                        }
                        chargeAmount = 0;

                        const input = document.getElementById('chargeAmountInput');
                        if (input) {
                            input.value = '';
                        }
                    }).catch(error => {
                        console.error('세션 정리 중 오류:', error);
                        // 오류가 있어도 팝업은 열기
                        const popup = document.getElementById('chargePopupOverlay');
                        if (popup) {
                            popup.style.display = 'flex';
                        }
                    });
                }

                function closeChargePopup() {
                    document.getElementById('chargePopupOverlay').style.display = 'none';
                }

                function setChargeAmount(amount) {
                    chargeAmount = amount;
                    const input = document.getElementById('chargeAmountInput');
                    if (input) {
                        input.value = amount.toLocaleString();
                    }
                }

                function processCharge() {
                    const input = document.getElementById('chargeAmountInput');
                    const inputValue = input ? input.value : '';
                    const inputAmount = inputValue.replace(/,/g, '');
                    chargeAmount = parseInt(inputAmount) || chargeAmount;

                    if (!chargeAmount || chargeAmount < 1000) {
                        alert('최소 1,000원 이상 충전해주세요.');
                        return;
                    }

                    // 서버에서 결제 정보를 가져와서 토스페이먼츠 호출
                    requestChargePayment(chargeAmount);
                }

                // 서버에서 결제 정보를 가져와서 토스페이먼츠 호출
                function requestChargePayment(amount) {
                    fetch('/purchase/toss/charge', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            amount: amount
                        })
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const tossPayments = TossPayments(data.clientKey);

                                tossPayments.requestPayment('NORMAL', {
                                    amount: data.amount,
                                    orderId: data.orderId,
                                    orderName: data.orderName,
                                    successUrl: data.successUrl,
                                    failUrl: data.failUrl,
                                })
                                    .catch(function (error) {
                                        if (error.code === 'USER_CANCEL') {
                                            console.log('충전이 취소되었습니다.');
                                        } else {
                                            alert('충전 요청 실패: ' + error.message);
                                        }
                                    });
                            } else {
                                alert(data.message || '충전 요청에 실패했습니다.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('충전 요청 중 오류가 발생했습니다.');
                        });
                }

                // 충전 금액 입력 시 포맷팅
                document.addEventListener('DOMContentLoaded', function () {
                    const chargeInput = document.getElementById('chargeAmountInput');
                    if (chargeInput) {
                        chargeInput.addEventListener('input', function (e) {
                            let value = e.target.value.replace(/[^0-9]/g, '');
                            if (value) {
                                e.target.value = parseInt(value).toLocaleString();
                            }
                        });
                    }

                    // URL 파라미터에서 충전 결과 확인
                    const urlParams = new URLSearchParams(window.location.search);
                    const chargeSuccess = urlParams.get('chargeSuccess');
                    const chargeAmount = urlParams.get('chargeAmount');

                    if (chargeSuccess === 'true' && chargeAmount) {
                        // 충전 성공 팝업
                        alert('💰 충전이 완료되었습니다!\n충전 금액: ₩' + parseInt(chargeAmount).toLocaleString() + '원');
                        // URL에서 파라미터 제거
                        window.history.replaceState({}, document.title, window.location.pathname);
                        // 페이지 새로고침하여 잔액 업데이트
                        window.location.reload();
                    } else if (chargeSuccess === 'false') {
                        // 충전 실패 팝업
                        alert('❌충전에 실패했습니다.\n다시 시도해주세요.');
                        // URL에서 파라미터 제거
                        window.history.replaceState({}, document.title, window.location.pathname);
                    }
                });

                // 회원 탈퇴 함수
                function deleteMember() {
                    if (confirm('정말로 회원 탈퇴를 하시겠습니까?\n\n탈퇴 시 모든 데이터가 삭제되며 복구할 수 없습니다.')) {
                        const memberId = '${sessionScope.loginId}';

                        fetch('/member/delete', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'memberId=' + encodeURIComponent(memberId)
                        })
                            .then(response => {
                                if (response.ok) {
                                    alert('회원 탈퇴가 완료되었습니다.');
                                    // 로그아웃 처리 및 세션 초기화
                                    window.location.href = '/member/logout';
                                } else {
                                    alert('회원 탈퇴 중 오류가 발생했습니다.');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('회원 탈퇴 요청 중 오류가 발생했습니다.');
                            });
                    }
                }

                // 강의 목록 토글 함수
                function toggleCourses() {
                    const hiddenCourses = document.querySelectorAll('.hidden-course');
                    const toggleBtn = document.querySelector('.toggle-courses-btn');
                    const toggleText = document.getElementById('toggleText');
                    const toggleIcon = document.getElementById('toggleIcon');

                    let isExpanded = toggleBtn.classList.contains('expanded');

                    if (isExpanded) {
                        // 접기
                        hiddenCourses.forEach(course => {
                            course.style.display = 'none';
                        });
                        toggleText.textContent = '더보기 (' + hiddenCourses.length + '개)';
                        toggleIcon.textContent = '▼';
                        toggleBtn.classList.remove('expanded');
                    } else {
                        // 펼치기
                        hiddenCourses.forEach(course => {
                            course.style.display = 'flex';
                        });
                        toggleText.textContent = '접기';
                        toggleIcon.textContent = '▲';
                        toggleBtn.classList.add('expanded');
                    }
                }

                // 강의 검색 관련 함수들
                let allCourses = []; // 전체 강의 데이터 저장

                // 페이지 로드 시 전체 강의 데이터 저장
                document.addEventListener('DOMContentLoaded', function () {
                    // 기존 강의 요소들을 배열로 저장
                    const courseElements = document.querySelectorAll('.course-item');
                    courseElements.forEach(course => {
                        allCourses.push({
                            element: course.cloneNode(true),
                            title: course.querySelector('.course-title').textContent.toLowerCase(),
                            instructor: course.querySelector('.course-instructor').textContent.toLowerCase(),
                            category: course.querySelector('.course-category').textContent.toLowerCase()
                        });
                    });
                });

                function searchCourses() {
                    const searchTerm = document.getElementById('courseSearchInput').value.toLowerCase().trim();
                    filterCourses(searchTerm);
                }

                function handleCourseSearchEnter(event) {
                    if (event.key === 'Enter') {
                        searchCourses();
                    }
                }

                function filterCourses(searchTerm) {
                    const courseContent = document.getElementById('courseContent');

                    if (!searchTerm) {
                        // 검색어가 없으면 원래 상태로 복원
                        restoreOriginalCourses();
                        return;
                    }

                    // 검색 결과 필터링
                    const filteredCourses = allCourses.filter(course =>
                        course.title.includes(searchTerm) ||
                        course.instructor.includes(searchTerm) ||
                        course.category.includes(searchTerm)
                    );

                    // 기존 강의 목록 제거
                    const existingCourses = courseContent.querySelectorAll('.course-item');
                    existingCourses.forEach(course => course.remove());

                    // 토글 버튼 제거
                    const toggleBtn = courseContent.querySelector('.toggle-courses-btn');
                    if (toggleBtn) toggleBtn.remove();

                    if (filteredCourses.length > 0) {
                        // 필터링된 강의들 표시
                        filteredCourses.forEach(course => {
                            const courseElement = course.element.cloneNode(true);
                            courseElement.style.display = 'flex';
                            courseElement.classList.remove('hidden-course');
                            courseContent.appendChild(courseElement);
                        });
                    } else {
                        // 검색 결과가 없을 때
                        const noResult = document.createElement('div');
                        noResult.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noResult.textContent = '검색 결과가 없습니다.';
                        courseContent.appendChild(noResult);
                    }
                }

                function restoreOriginalCourses() {
                    const courseContent = document.getElementById('courseContent');

                    // 기존 내용 제거
                    courseContent.innerHTML = '';

                    if (allCourses.length > 0) {
                        // 원래 강의들 복원
                        allCourses.forEach((course, index) => {
                            const courseElement = course.element.cloneNode(true);
                            if (index >= 3) {
                                courseElement.classList.add('hidden-course');
                                courseElement.style.display = 'none';
                            } else {
                                courseElement.style.display = 'flex';
                            }
                            courseContent.appendChild(courseElement);
                        });

                        // 토글 버튼 복원 (4개 이상일 때만)
                        if (allCourses.length > 3) {
                            const toggleBtn = document.createElement('div');
                            toggleBtn.className = 'toggle-courses-btn';
                            toggleBtn.onclick = toggleCourses;
                            toggleBtn.innerHTML = '<span id="toggleText">더보기 (' + (allCourses.length - 3) + '개)</span><span id="toggleIcon">▼</span>';
                            courseContent.appendChild(toggleBtn);
                        }
                    } else {
                        const noLecture = document.createElement('div');
                        noLecture.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noLecture.textContent = '수강중인 강의가 없습니다.';
                        courseContent.appendChild(noLecture);
                    }
                }
            </script>

            <!-- Footer Include -->
            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>