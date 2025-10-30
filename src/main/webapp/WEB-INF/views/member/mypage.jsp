<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>마이?��?���? | EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/member/mypage.css">
        <link rel="stylesheet" href="/resources/css/common/main_banner.css">
        <script src="https://js.tosspayments.com/v1/payment"></script>
    </head>
    <body>
        <div class="main-container">
            <!-- Header Include -->
            <jsp:include page="../common/header.jsp"/>


            <section class="main-banner">
                <div class="banner-text">
                    마이?��?���?
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/mypage.png" alt="마이?��?���? ?��?���?">
                </div>
            </section>

            <!-- 메인 콘텐�? -->
            <div class="main-content">
                <div class="mypage-content">

                    <!-- ?��로필 ?��?�� -->
                    <div class="profile-section">
                        <img class="profile-image" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/mypage1.png" alt="">
                        <div class="profile-info">
                            <div class="user-grade">${memberType}</div>
                            <div class="user-name">
                                <c:choose>
                                    <c:when test="${not empty memberInfo.memberName}">
                                        ${memberInfo.memberName}?��
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.loginId}?��
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stats-container">
                                <div class="stat-item">
                                    <div class="stat-number"><fmt:formatNumber value="${memberInfo.memberMoney}"
                                                                               pattern="#,###"/></div>
                                    <div class="stat-label">?���?</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCount + questionCount}</div>
                                    <div class="stat-label">?��?���? ?��</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCommentCount + questionCommentCount}</div>
                                    <div class="stat-label">?���? ?��</div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <c:choose>
                        <c:when test="${sessionScope.teacherYn eq 'N' && sessionScope.adminYn eq 'N'}">
                            <!-- ?��?�� ?��강중?�� 강의 -->
                            <div class="section">
                                <div class="section-header">
                                    <h2 class="section-title">?��?�� ?��강중?�� 강의</h2>
                                    <!-- �??�� 박스�? header ?��?���? ?��?�� -->
                                    <div class="course-search-box">
                                        <input type="text" id="courseSearchInput" placeholder="강의�?, 강사명을 ?��?��?��?��?��"
                                               onkeypress="handleCourseSearchEnter(event)">
                                        <button onclick="searchCourses()">?��?</button>
                                    </div>
                                </div>

                                <div class="course-content" id="courseContent">
                                    <c:choose>
                                        <c:when test="${not empty lectureList}">
                                            <c:forEach items="${lectureList}" var="lecture" varStatus="status">
                                                <a href="/lecture/player?videoNo=${recentVideoMap[lecture.lectureNo]}"
                                                   class="course-item ${status.index >= 3 ? 'hidden-course' : ''}"
                                                   style="${status.index >= 3 ? 'display: none;' : ''}">
                                                    <div class="course-title">${lecture.lectureName}</div>
                                                    <div class="course-instructor">${lecture.memberName}</div>
                                                    <div class="course-category">${lecture.lectureCategory}</div>
                                                </a>
                                            </c:forEach>
                                            <c:if test="${fn:length(lectureList) > 3}">
                                                <div class="toggle-courses-btn" onclick="toggleCourses()">
                                                    <span id="toggleText">?��보기 (${fn:length(lectureList) - 3}�?)</span>
                                                    <span id="toggleIcon">?��</span>
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="text-align: center; color: #999; padding: 40px;">
                                                ?��강중?�� 강의�? ?��?��?��?��.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.teacherYn eq 'Y'}">
                            <!-- ?��?�� ?��강중?�� 강의 -->
                            <div class="section">
                                <div class="section-header">
                                    <h2 class="section-title">?���? ?��록한 강의</h2>
                                    <!-- �??�� 박스�? header ?��?���? ?��?�� -->
                                    <div class="course-search-box">
                                        <input type="text" id="courseSearchInput" placeholder="강의명을 ?��?��?��?��?��"
                                               onkeypress="handleCourseSearchEnter(event)">
                                        <button onclick="searchCourses()">?��?</button>
                                    </div>
                                </div>

                                <div class="course-content" id="courseContent">
                                    <c:choose>
                                        <c:when test="${not empty lList}">
                                            <c:forEach items="${lList}" var="lecture" varStatus="status">
                                                <a href="/lecture/details?lectureNo=${lecture.lectureNo}"
                                                   class="course-item ${status.index >= 3 ? 'hidden-course' : ''}"
                                                   style="${status.index >= 3 ? 'display: none;' : ''}">
                                                    <div class="course-title">${lecture.lectureName}</div>
                                                    <div class="course-instructor">${memberInfo.memberName}</div>
                                                    <div class="course-category">${lecture.lectureCategory}</div>
                                                </a>
                                            </c:forEach>
                                            <c:if test="${fn:length(lList) > 3}">
                                                <div class="toggle-courses-btn" onclick="toggleCourses()">
                                                    <span id="toggleText">?��보기 (${fn:length(lList) - 3}�?)</span>
                                                    <span id="toggleIcon">?��</span>
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="text-align: center; color: #999; padding: 40px;">
                                                ?��록한 강의�? ?��?��?��?��.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:when>

                    </c:choose>
                    <c:choose>
                        <c:when test="${sessionScope.teacherYn eq 'Y'}">
                            <div class="section">
                                <a href="/lecture/add" class="menu-item">
                                    <div class="menu-icon">?��?</div>
                                    <div class="menu-text">강의 추�?</div>
                                </a>
                            </div>
                            <div class="section">
                                <a href="javascript:void(0);" onclick="openWithdrawPopup();" class="menu-item">
                                    <div class="menu-icon">?��?</div>
                                    <div class="menu-text">?��?�� 출금?���?</div>
                                </a>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.teacherYn eq 'N' && sessionScope.adminYn eq 'N'}">
                            <!-- ?���? 충전?���? -->
                            <div class="section">
                                <a href="javascript:void(0);" onclick="openChargePopup();" class="menu-item">
                                    <div class="menu-icon">?��?</div>
                                    <div class="menu-text">?���? 충전?���?</div>
                                </a>
                            </div>
                        </c:when>
                    </c:choose>
                    <!-- ?���? ?��?��?�� 게시�? -->
                    <div class="section">
                        <a href="/member/mypost" class="menu-item">
                            <div class="menu-icon">?��?</div>
                            <div class="menu-text">?���? ?��?��?�� 게시�?</div>
                        </a>
                    </div>

                    <!-- ?���? ?��?��?�� ?���? -->
                    <div class="section">
                        <a href="/member/mycomment" class="menu-item">
                            <div class="menu-icon">?��?</div>
                            <div class="menu-text">?���? ?��?��?�� ?���?</div>
                        </a>
                    </div>

                    <!-- ?�� ?���? ?��?�� -->
                    <div class="section">
                        <a href="/member/edit" class="menu-item">
                            <div class="menu-icon">?���?</div>
                            <div class="menu-text">?�� ?���? ?��?��</div>
                        </a>
                    </div>

                    <!-- 로그?��?�� -->
                    <div class="section">
                        <a href="/member/logout" class="menu-item">
                            <div class="menu-icon">?��?</div>
                            <div class="menu-text">로그?��?��</div>
                        </a>
                    </div>

                    <!-- ?��?�� ?��?�� -->
                    <div class="section">
                        <a href="javascript:void(0);" onclick="deleteMember();" class="menu-item">
                            <div class="menu-icon">?���?</div>
                            <div class="menu-text">?��?�� ?��?��</div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- 충전 ?��?�� -->
            <div class="charge-popup-overlay" id="chargePopupOverlay">
                <div class="charge-popup">
                    <h3 class="charge-popup-title">?��? ?��?�� 충전</h3>

                    <div class="charge-amount-section">
                        <input type="text" class="charge-amount-input" id="chargeAmountInput"
                               placeholder="충전?�� 금액?�� ?��?��?��?��?��">
                        <div class="charge-amount-buttons">
                            <button class="charge-amount-btn" onclick="setChargeAmount(10000)">10,000?��</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(30000)">30,000?��</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(50000)">50,000?��</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(100000)">100,000?��</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(300000)">300,000?��</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(500000)">500,000?��</button>
                        </div>
                    </div>

                    <div class="charge-popup-buttons">
                        <button class="charge-popup-btn cancel" onclick="closeChargePopup()">취소</button>
                        <button class="charge-popup-btn confirm" onclick="processCharge()">충전?���?</button>
                    </div>
                </div>
            </div>

            <!-- 출금 ?��?�� -->
            <div class="charge-popup-overlay" id="withdrawPopupOverlay" style="display: none;">
                <div class="charge-popup">
                    <h3 class="charge-popup-title">?��? ?��?�� 출금</h3>

                    <div class="withdraw-form">
                        <!-- ???�� ?��?�� -->
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="bankSelect" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">???�� ?��?��</label>
                            <select id="bankSelect" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; background: white;">
                                <option value="">???��?�� ?��?��?��?��?��</option>
                                <option value="KB�?민�??��">KB�?민�??��</option>
                                <option value="?��?��???��">?��?��???��</option>
                                <option value="?��리�??��">?��리�??��</option>
                                <option value="?��?��???��">?��?��???��</option>
                                <option value="NH?��?��???��">NH?��?��???��</option>
                                <option value="IBK기업???��">IBK기업???��</option>
                                <option value="카카?��뱅크">카카?��뱅크</option>
                                <option value="?��?��뱅크">?��?��뱅크</option>
                                <option value="�??��뱅크">�??��뱅크</option>
                            </select>
                        </div>

                        <!-- 계좌번호 ?��?�� -->
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="accountNumber" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">계좌번호</label>
                            <input type="text" id="accountNumber" placeholder="계좌번호�? ?��?��?��?��?�� (- ?��?��)" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </div>

                        <!-- 출금 금액 -->
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="withdrawAmountInput" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">출금 금액 (?��?�� ?��?��: <fmt:formatNumber value="${memberInfo.memberMoney}" pattern="#,###"/>?��)</label>
                            <div class="amount-input-group" style="display: flex; gap: 10px; align-items: center;">
                                <input type="text" class="charge-amount-input" id="withdrawAmountInput" placeholder="출금?�� 금액?�� ?��?��?��?��?��" style="flex: 1; height: 46px; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; margin: 0;">
                                <button class="full-amount-btn" onclick="setFullAmount()" style="height: 46px; padding: 0 15px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; white-space: nowrap;">?��?��</button>
                            </div>
                        </div>
                    </div>

                    <div class="charge-popup-buttons" style="margin-top: 15px;">
                        <button class="charge-popup-btn cancel" onclick="closeWithdrawPopup()">취소</button>
                        <button class="charge-popup-btn confirm" onclick="processWithdraw()">출금 ?���?</button>
                    </div>
                </div>
            </div>

            <script>
                let chargeAmount = 0;

                // 충전 �??�� ?��?��?��
                function openChargePopup() {
                    // 마이?��?���??��?�� 충전?��?�� 것임?�� ?��버에 ?���? (?��?�� ?��리용)
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
                        console.error('?��?�� ?���? �? ?���?:', error);
                        // ?��류�? ?��?��?�� ?��?��?? ?���?
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
                        alert('최소 1,000?�� ?��?�� 충전?��주세?��.');
                        return;
                    }

                    // ?��버에?�� 결제 ?��보�?? �??��???�� ?��?��?��?��먼츠 ?���?
                    requestChargePayment(chargeAmount);
                }

                // ?��버에?�� 결제 ?��보�?? �??��???�� ?��?��?��?��먼츠 ?���?
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
                                            console.log('충전?�� 취소?��?��?��?��?��.');
                                        } else {
                                            alert('충전 ?���? ?��?��: ' + error.message);
                                        }
                                    });
                            } else {
                                alert(data.message || '충전 ?���??�� ?��?��?��?��?��?��.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('충전 ?���? �? ?��류�? 발생?��?��?��?��.');
                        });
                }

                // 출금 �??�� ?��?��?��
                function openWithdrawPopup() {
                    const popup = document.getElementById('withdrawPopupOverlay');
                    if (popup) {
                        popup.style.display = 'flex';
                    }
                    
                    // ?�� 초기?��
                    document.getElementById('bankSelect').value = '';
                    document.getElementById('accountNumber').value = '';
                    document.getElementById('withdrawAmountInput').value = '';
                }

                function closeWithdrawPopup() {
                    document.getElementById('withdrawPopupOverlay').style.display = 'none';
                }

                function setFullAmount() {
                    const currentBalance = ${memberInfo.memberMoney};
                    const input = document.getElementById('withdrawAmountInput');
                    if (input) {
                        input.value = currentBalance.toLocaleString();
                    }
                }

                function processWithdraw() {
                    const bank = document.getElementById('bankSelect').value;
                    const accountNumber = document.getElementById('accountNumber').value;
                    const withdrawInput = document.getElementById('withdrawAmountInput');
                    const withdrawAmount = parseInt(withdrawInput.value.replace(/,/g, '')) || 0;
                    
                    // ?��?��?�� �??��
                    if (!bank || bank.trim() === '') {
                        alert('???��?�� ?��?��?��주세?��.');
                        return;
                    }
                    
                    if (!accountNumber || accountNumber.trim() === '') {
                        alert('계좌번호�? ?��?��?��주세?��.');
                        return;
                    }
                    
                    if (!withdrawAmount || withdrawAmount < 1000) {
                        alert('최소 1,000?�� ?��?�� 출금 �??��?��?��?��.');
                        return;
                    }
                    
                    const currentBalance = ${memberInfo.memberMoney};
                    if (withdrawAmount > currentBalance) {
                        alert('?��?��?�� �?족합?��?��.');
                        return;
                    }
                    
                    if (!confirm(bank + '\n계좌번호: ' + accountNumber + '\n출금금액: ' + withdrawAmount.toLocaleString() + '?��\n\n?�� ?��보로 출금?��?��겠습?���??')) {
                        return;
                    }
                    
                    // ?��버로 출금 ?���?
                    fetch('/member/withdraw', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify({
                            bank: bank,
                            accountNumber: accountNumber,
                            amount: withdrawAmount
                        })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            alert('출금 ?���??�� ?��료되?��?��?��?��.\n처리까�? 1-2?�� ?��?��?��?��?��.');
                            closeWithdrawPopup();
                            window.location.reload(); // ?��?�� ?��?��?��?���? ?��?�� ?��로고�?
                        } else {
                            alert(data.message || '출금 ?���??�� ?��?��?��?��?��?��.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('출금 ?���? �? ?��류�? 발생?��?��?��?��.');
                    });
                }

                // 충전/출금 금액 ?��?�� ?�� ?��맷팅
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
                    
                    const withdrawInput = document.getElementById('withdrawAmountInput');
                    if (withdrawInput) {
                        withdrawInput.addEventListener('input', function (e) {
                            let value = e.target.value.replace(/[^0-9]/g, '');
                            if (value) {
                                const numericValue = parseInt(value);
                                const currentBalance = ${memberInfo.memberMoney};
                                
                                // ?��?�� ?��?��보다 ?�� 금액?? ?��?�� 불�?
                                if (numericValue > currentBalance) {
                                    e.target.value = currentBalance.toLocaleString();
                                } else {
                                    e.target.value = numericValue.toLocaleString();
                                }
                            }
                        });
                    }
                    
                    const accountInput = document.getElementById('accountNumber');
                    if (accountInput) {
                        accountInput.addEventListener('input', function (e) {
                            e.target.value = e.target.value.replace(/[^0-9]/g, '');
                        });
                    }

                    // URL ?��?��미터?��?�� 충전 결과 ?��?��
                    const urlParams = new URLSearchParams(window.location.search);
                    const chargeSuccess = urlParams.get('chargeSuccess');
                    const chargeAmount = urlParams.get('chargeAmount');

                    if (chargeSuccess === 'true' && chargeAmount) {
                        // 충전 ?���? ?��?��
                        alert('?��? 충전?�� ?��료되?��?��?��?��!\n충전 금액: ?��' + parseInt(chargeAmount).toLocaleString() + '?��');
                        // URL?��?�� ?��?��미터 ?���?
                        window.history.replaceState({}, document.title, window.location.pathname);
                        // ?��?���? ?��로고침하?�� ?��?�� ?��?��?��?��
                        window.location.reload();
                    } else if (chargeSuccess === 'false') {
                        // 충전 ?��?�� ?��?��
                        alert('?��충전?�� ?��?��?��?��?��?��.\n?��?�� ?��?��?��주세?��.');
                        // URL?��?�� ?��?��미터 ?���?
                        window.history.replaceState({}, document.title, window.location.pathname);
                    }
                });

                // ?��?�� ?��?�� ?��?��
                function deleteMember() {
                    if (confirm('?��말로 ?��?�� ?��?���? ?��?��겠습?���??\n\n?��?�� ?�� 모든 ?��?��?���? ?��?��?���? 복구?�� ?�� ?��?��?��?��.')) {
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
                                    alert('?��?�� ?��?���? ?��료되?��?��?��?��.');
                                    // 로그?��?�� 처리 �? ?��?�� 초기?��
                                    window.location.href = '/member/logout';
                                } else {
                                    alert('?��?�� ?��?�� �? ?��류�? 발생?��?��?��?��.');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('?��?�� ?��?�� ?���? �? ?��류�? 발생?��?��?��?��.');
                            });
                    }
                }

                // 강의 목록 ?���? ?��?��
                function toggleCourses() {
                    const hiddenCourses = document.querySelectorAll('.hidden-course');
                    const toggleBtn = document.querySelector('.toggle-courses-btn');
                    const toggleText = document.getElementById('toggleText');
                    const toggleIcon = document.getElementById('toggleIcon');

                    let isExpanded = toggleBtn.classList.contains('expanded');

                    if (isExpanded) {
                        // ?���?
                        hiddenCourses.forEach(course => {
                            course.style.display = 'none';
                        });
                        toggleText.textContent = '?��보기 (' + hiddenCourses.length + '�?)';
                        toggleIcon.textContent = '?��';
                        toggleBtn.classList.remove('expanded');
                    } else {
                        // ?��치기
                        hiddenCourses.forEach(course => {
                            course.style.display = 'flex';
                        });
                        toggleText.textContent = '?���?';
                        toggleIcon.textContent = '?��';
                        toggleBtn.classList.add('expanded');
                    }
                }

                // 강의 �??�� �??�� ?��?��?��
                let allCourses = []; // ?���? 강의 ?��?��?�� ???��

                // ?��?���? 로드 ?�� ?���? 강의 ?��?��?�� ???��
                document.addEventListener('DOMContentLoaded', function () {
                    // 기존 강의 ?��?��?��?�� 배열�? ???��
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
                        // �??��?���? ?��?���? ?��?�� ?��?���? 복원
                        restoreOriginalCourses();
                        return;
                    }

                    // �??�� 결과 ?��?���?
                    const filteredCourses = allCourses.filter(course =>
                        course.title.includes(searchTerm) ||
                        course.instructor.includes(searchTerm) ||
                        course.category.includes(searchTerm)
                    );

                    // 기존 강의 목록 ?���?
                    const existingCourses = courseContent.querySelectorAll('.course-item');
                    existingCourses.forEach(course => course.remove());

                    // ?���? 버튼 ?���?
                    const toggleBtn = courseContent.querySelector('.toggle-courses-btn');
                    if (toggleBtn) toggleBtn.remove();

                    if (filteredCourses.length > 0) {
                        // ?��?��링된 강의?�� ?��?��
                        filteredCourses.forEach(course => {
                            const courseElement = course.element.cloneNode(true);
                            courseElement.style.display = 'flex';
                            courseElement.classList.remove('hidden-course');
                            courseContent.appendChild(courseElement);
                        });
                    } else {
                        // �??�� 결과�? ?��?�� ?��
                        const noResult = document.createElement('div');
                        noResult.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noResult.textContent = '�??�� 결과�? ?��?��?��?��.';
                        courseContent.appendChild(noResult);
                    }
                }

                function restoreOriginalCourses() {
                    const courseContent = document.getElementById('courseContent');

                    // 기존 ?��?�� ?���?
                    courseContent.innerHTML = '';

                    if (allCourses.length > 0) {
                        // ?��?�� 강의?�� 복원
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

                        // ?���? 버튼 복원 (4�? ?��?��?�� ?���?)
                        if (allCourses.length > 3) {
                            const toggleBtn = document.createElement('div');
                            toggleBtn.className = 'toggle-courses-btn';
                            toggleBtn.onclick = toggleCourses;
                            toggleBtn.innerHTML = '<span id="toggleText">?��보기 (' + (allCourses.length - 3) + '�?)</span><span id="toggleIcon">?��</span>';
                            courseContent.appendChild(toggleBtn);
                        }
                    } else {
                        const noLecture = document.createElement('div');
                        noLecture.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noLecture.textContent = '?��강중?�� 강의�? ?��?��?��?��.';
                        courseContent.appendChild(noLecture);
                    }
                }
            </script>

            <!-- Footer Include -->
            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>