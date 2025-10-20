<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>결제하기 - EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/lecture/payment.css">
        <script src="https://js.tosspayments.com/v1/payment"></script>
    </head>
    <body>
        <div class="main-container">
            <!-- Header Include -->
            <jsp:include page="../common/header.jsp"/>

            <!-- Main Content -->
            <div class="main-content">

                <div class="payment-container">
                    <!-- Payment Form -->
                    <div class="payment-form">
                        <!-- 주문자 정보 -->
                        <div class="form-section">
                            <h2 class="section-title">👤 주문자 정보</h2>
                            <div class="user-info-display">
                                <div class="info-item">
                                    <span class="info-label">이름</span>
                                    <span class="info-value">${member.memberName}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">이메일</span>
                                    <span class="info-value">${member.memberEmail}</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label">잔액 <a href="javascript:void(0);"
                                                                   onclick="openChargePopup();">충전하기</a></span>
                                    <span class="info-value"><fmt:formatNumber value="${member.memberMoney}"
                                                                               pattern="#,###"/>원</span>
                                </div>

                            </div>
                        </div>

                        <!-- 결제 방법 선택 -->
                        <div class="form-section">
                            <h2 class="section-title">💳 결제 방법 선택</h2>
                            <div class="payment-options">
                                <div class="payment-option" data-method="balance">
                                    <div class="payment-icon">💰</div>
                                    <div class="payment-info">
                                        <h3>보유 포인트</h3>
                                        <p class="payment-desc">간편하고 빠른 결제</p>
                                    </div>
                                </div>

                                <div class="payment-option" data-method="external">
                                    <div class="payment-icon">💳</div>
                                    <div class="payment-info">
                                        <h3>외부 결제</h3>
                                        <p class="payment-desc">카드, 카카오페이, 토스페이 등</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 약관 동의 -->
                        <div class="form-section">
                            <h2 class="section-title">📋 약관 동의</h2>
                            <div class="checkbox-group">
                                <input type="checkbox" id="agree1" required>
                                <label for="agree1">결제 서비스 이용약관에 동의합니다 (필수)</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="agree2" required>
                                <label for="agree2">개인정보 수집·이용에 동의합니다 (필수)</label>
                            </div>
                            <div class="checkbox-group">
                                <input type="checkbox" id="agree3">
                                <label for="agree3">마케팅 정보 수신에 동의합니다 (선택)</label>
                            </div>
                        </div>
                    </div>

                    <!-- Order Summary -->
                    <div class="order-summary">
                        <h2 class="section-title">📦 주문 정보</h2>

                        <div class="course-info">
                            <div class="course-image">
                                <img src="/resources/images/lecture/${lList[0].lecturePath}"
                                     alt="${lList[0].lectureName}"/>
                            </div>
                            <div class="course-details">
                                <h3>${lList[0].lectureName}</h3>
                                <p class="course-instructor">👨‍💻 ${lList[0].memberName}</p>
                                <div class="course-rating">
                                    <span class="stars">⭐</span>
                                    <span>${lList[0].lectureRating}</span>
                                </div>
                            </div>
                        </div>

                        <div class="price-breakdown">
                            <div class="price-row total">
                                <span>총 결제금액</span>
                                <span class="price" id="total-amount">₩ <fmt:formatNumber
                                        value="${lList[0].lecturePrice}"
                                        pattern="#,###"/></span>
                            </div>
                        </div>

                        <button class="payment-button" onclick="handlePayment()">
                            ₩ <fmt:formatNumber value="${lList[0].lecturePrice}"
                                                pattern="#,###"/> 결제하기
                        </button>
                    </div>
                </div>

                <div class="back-link">
                    <a href="/lecture/details?lectureNo=${lList[0].lectureNo}">← 강의 상세페이지로 돌아가기</a>
                </div>
            </div>

            <!-- Footer Include -->
            <jsp:include page="../common/footer.jsp"/>
        </div>

        <!-- 충전 팝업 -->
        <div class="charge-popup-overlay" id="chargePopupOverlay">
            <div class="charge-popup">
                <h3 class="charge-popup-title">💰 잔액 충전</h3>

                <div class="charge-amount-section">
                    <input type="text" class="charge-amount-input" id="chargeAmountInput" placeholder="충전할 금액을 입력하세요">
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
            let selectedPaymentMethod = null;
            let chargeAmount = 0;

            // 결제 방법 선택
            function selectPaymentMethod(method) {
                // 모든 결제 옵션 비활성화
                const allOptions = document.querySelectorAll('.payment-option');

                allOptions.forEach(option => {
                    option.classList.remove('selected');
                });

                // 선택된 옵션 활성화
                let selectedOption = null;
                allOptions.forEach(option => {
                    if (option.getAttribute('data-method') === method) {
                        selectedOption = option;
                    }
                });

                if (selectedOption) {
                    selectedOption.classList.add('selected');
                    selectedPaymentMethod = method;
                }
            }


            // 강의 결제 처리
            function handlePayment() {
                // 동의 체크
                if (!document.getElementById('agree1').checked || !document.getElementById('agree2').checked) {
                    alert('필수 약관에 동의해주세요.');
                    return;
                }

                // 잔액 결제 시 잔액 부족 체크 (결제 전에 미리 체크)
                if (selectedPaymentMethod === 'balance' && ${lList[0].lecturePrice} > ${member.memberMoney}) {
                    alert('잔액이 부족합니다.\n현재 잔액: ₩<fmt:formatNumber value="${member.memberMoney}" pattern="#,###"/>원\n필요 금액: ₩<fmt:formatNumber value="${lList[0].lecturePrice}" pattern="#,###"/>원');
                    return;
                }

                // 값들 수집
                const paymentData = {
                    lectureNo: ${lList[0].lectureNo},
                    paymentMethod: selectedPaymentMethod,
                    amount: ${lList[0].lecturePrice},
                    lectureName: '${lList[0].lectureName}'
                };

                // POST 요청으로 결제 처리
                fetch('/purchase/lecture', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(paymentData)
                })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            if (data.paymentType === 'external') {
                                // 외부 결제 - 토스페이먼츠 호출
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
                                            console.log('결제가 취소되었습니다.');
                                        } else {
                                            alert('결제 요청 실패: ' + error.message);
                                        }
                                    });
                            } else {
                                // 잔액 결제 완료 - 성공 페이지로 이동
                                window.location.href = '/purchase/balance/success?lectureNo=' + paymentData.lectureNo + '&amount=' + paymentData.amount + '&lectureName=' + encodeURIComponent(paymentData.lectureName);
                            }
                        } else {
                            // 로그인이 필요한 경우 로그인 페이지로 이동
                            if (data.redirectUrl) {
                                window.location.href = data.redirectUrl;
                            } else {
                                alert(data.message || '결제에 실패했습니다.');
                            }
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('결제 요청 중 오류가 발생했습니다.');
                    });
            }

            // 충전 관련 함수들 (전역 스코프에 정의)
            function openChargePopup() {
                const popup = document.getElementById('chargePopupOverlay');
                if (popup) {
                    popup.style.display = 'flex';
                }
                chargeAmount = 0;

                const input = document.getElementById('chargeAmountInput');
                if (input) {
                    input.value = '';
                }
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
                            // 토스페이먼츠 SDK 호출
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
                                        console.log('결제가 취소되었습니다.');
                                    } else {
                                        alert('결제 요청 실패: ' + error.message);
                                    }
                                });

                            closeChargePopup();
                        } else {
                            alert(data.message || '결제 요청에 실패했습니다.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('결제 요청 중 오류가 발생했습니다.');
                    });
            }


            // URL 파라미터에서 충전/결제 결과 확인
            function checkPaymentResult() {
                const urlParams = new URLSearchParams(window.location.search);
                const chargeSuccess = urlParams.get('chargeSuccess');
                const chargeAmount = urlParams.get('chargeAmount');
                const chargeFail = urlParams.get('chargeFail');
                const paymentFail = urlParams.get('paymentFail');
                const message = urlParams.get('message');

                if (chargeSuccess === 'true' && chargeAmount) {
                    // 충전 성공 팝업
                    setTimeout(() => {
                        alert('💰 충전이 완료되었습니다!\n충전 금액: ₩' + parseInt(chargeAmount).toLocaleString() + '원');
                    }, 500);

                    // URL에서 파라미터 제거
                    const newUrl = window.location.pathname + '?lectureNo=' + urlParams.get('lectureNo');
                    window.history.replaceState({}, '', newUrl);
                } else if (chargeFail === 'true') {
                    // 충전 실패 팝업
                    setTimeout(() => {
                        alert('❌ 충전에 실패했습니다.\n다시 시도해주세요.');
                    }, 500);

                    // URL에서 파라미터 제거
                    const newUrl = window.location.pathname + '?lectureNo=' + urlParams.get('lectureNo');
                    window.history.replaceState({}, '', newUrl);
                } else if (paymentFail === 'true') {
                    // 외부 결제 실패 팝업
                    setTimeout(() => {
                        alert('❌ 결제에 실패했습니다.\n' + (message || '다시 시도해주세요.'));
                    }, 500);

                    // URL에서 파라미터 제거
                    const newUrl = window.location.pathname + '?lectureNo=' + urlParams.get('lectureNo');
                    window.history.replaceState({}, '', newUrl);
                }
            }

            // 페이지 로드 시 초기화
            document.addEventListener('DOMContentLoaded', function () {
                // 충전/결제 결과 확인
                checkPaymentResult();

                // 결제 방법 선택 이벤트 리스너 추가
                document.querySelectorAll('.payment-option').forEach(option => {
                    option.addEventListener('click', function () {
                        const method = this.getAttribute('data-method');
                        selectPaymentMethod(method);
                    });
                });

                // 기본 결제 방법 선택 (보유 포인트)
                selectPaymentMethod('balance');

                // 충전 금액 입력 시 포맷팅
                const chargeInput = document.getElementById('chargeAmountInput');
                if (chargeInput) {
                    chargeInput.addEventListener('input', function (e) {
                        let value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 허용
                        if (value && parseInt(value) > 0) {
                            chargeAmount = parseInt(value);
                            e.target.value = parseInt(value).toLocaleString();
                        } else if (value === '') {
                            chargeAmount = 0;
                            e.target.value = '';
                        }
                    });
                }

                // 팝업 외부 클릭 시 닫기
                const overlay = document.getElementById('chargePopupOverlay');
                if (overlay) {
                    overlay.addEventListener('click', function (e) {
                        if (e.target === this) {
                            closeChargePopup();
                        }
                    });
                }

            });
        </script>
    </body>
</html>