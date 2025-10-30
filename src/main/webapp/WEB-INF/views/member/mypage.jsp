<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>ÎßàÏù¥?éò?ù¥Ïß? | EduMate</title>
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
                    ÎßàÏù¥?éò?ù¥Ïß?
                </div>
                <div class="object">
                    <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/member/mypage.png" alt="ÎßàÏù¥?éò?ù¥Ïß? ?ïÑ?ù¥ÏΩ?">
                </div>
            </section>

            <!-- Î©îÏù∏ ÏΩòÌÖêÏ∏? -->
            <div class="main-content">
                <div class="mypage-content">

                    <!-- ?îÑÎ°úÌïÑ ?Ñπ?Öò -->
                    <div class="profile-section">
                        <img class="profile-image" src="/resources/images/common/mypage1.png" alt="">
                        <div class="profile-info">
                            <div class="user-grade">${memberType}</div>
                            <div class="user-name">
                                <c:choose>
                                    <c:when test="${not empty memberInfo.memberName}">
                                        ${memberInfo.memberName}?ãò
                                    </c:when>
                                    <c:otherwise>
                                        ${sessionScope.loginId}?ãò
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stats-container">
                                <div class="stat-item">
                                    <div class="stat-number"><fmt:formatNumber value="${memberInfo.memberMoney}"
                                                                               pattern="#,###"/></div>
                                    <div class="stat-label">?ûîÍ≥?</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCount + questionCount}</div>
                                    <div class="stat-label">?ûë?Ñ±Í∏? ?àò</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">${requestCommentCount + questionCommentCount}</div>
                                    <div class="stat-label">?åìÍ∏? ?àò</div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <c:choose>
                        <c:when test="${sessionScope.teacherYn eq 'N' && sessionScope.adminYn eq 'N'}">
                            <!-- ?òÑ?û¨ ?àòÍ∞ïÏ§ë?ù∏ Í∞ïÏùò -->
                            <div class="section">
                                <div class="section-header">
                                    <h2 class="section-title">?òÑ?û¨ ?àòÍ∞ïÏ§ë?ù∏ Í∞ïÏùò</h2>
                                    <!-- Í≤??Éâ Î∞ïÏä§Î•? header ?ïà?úºÎ°? ?ù¥?èô -->
                                    <div class="course-search-box">
                                        <input type="text" id="courseSearchInput" placeholder="Í∞ïÏùòÎ™?, Í∞ïÏÇ¨Î™ÖÏùÑ ?ûÖ?†•?ïò?Ñ∏?öî"
                                               onkeypress="handleCourseSearchEnter(event)">
                                        <button onclick="searchCourses()">?üî?</button>
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
                                                    <span id="toggleText">?çîÎ≥¥Í∏∞ (${fn:length(lectureList) - 3}Í∞?)</span>
                                                    <span id="toggleIcon">?ñº</span>
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="text-align: center; color: #999; padding: 40px;">
                                                ?àòÍ∞ïÏ§ë?ù∏ Í∞ïÏùòÍ∞? ?óÜ?äµ?ãà?ã§.
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.teacherYn eq 'Y'}">
                            <!-- ?òÑ?û¨ ?àòÍ∞ïÏ§ë?ù∏ Í∞ïÏùò -->
                            <div class="section">
                                <div class="section-header">
                                    <h2 class="section-title">?Ç¥Í∞? ?ì±Î°ùÌïú Í∞ïÏùò</h2>
                                    <!-- Í≤??Éâ Î∞ïÏä§Î•? header ?ïà?úºÎ°? ?ù¥?èô -->
                                    <div class="course-search-box">
                                        <input type="text" id="courseSearchInput" placeholder="Í∞ïÏùòÎ™ÖÏùÑ ?ûÖ?†•?ïò?Ñ∏?öî"
                                               onkeypress="handleCourseSearchEnter(event)">
                                        <button onclick="searchCourses()">?üî?</button>
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
                                                    <span id="toggleText">?çîÎ≥¥Í∏∞ (${fn:length(lList) - 3}Í∞?)</span>
                                                    <span id="toggleIcon">?ñº</span>
                                                </div>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="text-align: center; color: #999; padding: 40px;">
                                                ?ì±Î°ùÌïú Í∞ïÏùòÍ∞? ?óÜ?äµ?ãà?ã§.
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
                                    <div class="menu-icon">?üì?</div>
                                    <div class="menu-text">Í∞ïÏùò Ï∂îÍ?</div>
                                </a>
                            </div>
                            <div class="section">
                                <a href="javascript:void(0);" onclick="openWithdrawPopup();" class="menu-item">
                                    <div class="menu-icon">?üí?</div>
                                    <div class="menu-text">?ûî?ï° Ï∂úÍ∏à?ïòÍ∏?</div>
                                </a>
                            </div>
                        </c:when>
                        <c:when test="${sessionScope.teacherYn eq 'N' && sessionScope.adminYn eq 'N'}">
                            <!-- ?ûîÍ≥? Ï∂©Ï†Ñ?ïòÍ∏? -->
                            <div class="section">
                                <a href="javascript:void(0);" onclick="openChargePopup();" class="menu-item">
                                    <div class="menu-icon">?üí?</div>
                                    <div class="menu-text">?ûîÍ≥? Ï∂©Ï†Ñ?ïòÍ∏?</div>
                                </a>
                            </div>
                        </c:when>
                    </c:choose>
                    <!-- ?Ç¥Í∞? ?ûë?Ñ±?ïú Í≤åÏãúÎ¨? -->
                    <div class="section">
                        <a href="/member/mypost" class="menu-item">
                            <div class="menu-icon">?üì?</div>
                            <div class="menu-text">?Ç¥Í∞? ?ûë?Ñ±?ïú Í≤åÏãúÎ¨?</div>
                        </a>
                    </div>

                    <!-- ?Ç¥Í∞? ?ûë?Ñ±?ïú ?åìÍ∏? -->
                    <div class="section">
                        <a href="/member/mycomment" class="menu-item">
                            <div class="menu-icon">?üí?</div>
                            <div class="menu-text">?Ç¥Í∞? ?ûë?Ñ±?ïú ?åìÍ∏?</div>
                        </a>
                    </div>

                    <!-- ?Ç¥ ?†ïÎ≥? ?àò?†ï -->
                    <div class="section">
                        <a href="/member/edit" class="menu-item">
                            <div class="menu-icon">?öôÔ∏?</div>
                            <div class="menu-text">?Ç¥ ?†ïÎ≥? ?àò?†ï</div>
                        </a>
                    </div>

                    <!-- Î°úÍ∑∏?ïÑ?õÉ -->
                    <div class="section">
                        <a href="/member/logout" class="menu-item">
                            <div class="menu-icon">?üö?</div>
                            <div class="menu-text">Î°úÍ∑∏?ïÑ?õÉ</div>
                        </a>
                    </div>

                    <!-- ?öå?õê ?Éà?á¥ -->
                    <div class="section">
                        <a href="javascript:void(0);" onclick="deleteMember();" class="menu-item">
                            <div class="menu-icon">?ö†Ô∏?</div>
                            <div class="menu-text">?öå?õê ?Éà?á¥</div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Ï∂©Ï†Ñ ?åù?óÖ -->
            <div class="charge-popup-overlay" id="chargePopupOverlay">
                <div class="charge-popup">
                    <h3 class="charge-popup-title">?üí? ?ûî?ï° Ï∂©Ï†Ñ</h3>

                    <div class="charge-amount-section">
                        <input type="text" class="charge-amount-input" id="chargeAmountInput"
                               placeholder="Ï∂©Ï†Ñ?ï† Í∏àÏï°?ùÑ ?ûÖ?†•?ïò?Ñ∏?öî">
                        <div class="charge-amount-buttons">
                            <button class="charge-amount-btn" onclick="setChargeAmount(10000)">10,000?õê</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(30000)">30,000?õê</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(50000)">50,000?õê</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(100000)">100,000?õê</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(300000)">300,000?õê</button>
                            <button class="charge-amount-btn" onclick="setChargeAmount(500000)">500,000?õê</button>
                        </div>
                    </div>

                    <div class="charge-popup-buttons">
                        <button class="charge-popup-btn cancel" onclick="closeChargePopup()">Ï∑®ÏÜå</button>
                        <button class="charge-popup-btn confirm" onclick="processCharge()">Ï∂©Ï†Ñ?ïòÍ∏?</button>
                    </div>
                </div>
            </div>

            <!-- Ï∂úÍ∏à ?åù?óÖ -->
            <div class="charge-popup-overlay" id="withdrawPopupOverlay" style="display: none;">
                <div class="charge-popup">
                    <h3 class="charge-popup-title">?üí? ?ûî?ï° Ï∂úÍ∏à</h3>

                    <div class="withdraw-form">
                        <!-- ???ñâ ?Ñ†?Éù -->
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="bankSelect" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">???ñâ ?Ñ†?Éù</label>
                            <select id="bankSelect" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; background: white;">
                                <option value="">???ñâ?ùÑ ?Ñ†?Éù?ïò?Ñ∏?öî</option>
                                <option value="KBÍµ?ÎØºÏ??ñâ">KBÍµ?ÎØºÏ??ñâ</option>
                                <option value="?ã†?ïú???ñâ">?ã†?ïú???ñâ</option>
                                <option value="?ö∞Î¶¨Ï??ñâ">?ö∞Î¶¨Ï??ñâ</option>
                                <option value="?ïò?Çò???ñâ">?ïò?Çò???ñâ</option>
                                <option value="NH?Üç?òë???ñâ">NH?Üç?òë???ñâ</option>
                                <option value="IBKÍ∏∞ÏóÖ???ñâ">IBKÍ∏∞ÏóÖ???ñâ</option>
                                <option value="Ïπ¥Ïπ¥?ò§Î±ÖÌÅ¨">Ïπ¥Ïπ¥?ò§Î±ÖÌÅ¨</option>
                                <option value="?Ü†?ä§Î±ÖÌÅ¨">?Ü†?ä§Î±ÖÌÅ¨</option>
                                <option value="Ïº??ù¥Î±ÖÌÅ¨">Ïº??ù¥Î±ÖÌÅ¨</option>
                            </select>
                        </div>

                        <!-- Í≥ÑÏ¢åÎ≤àÌò∏ ?ûÖ?†• -->
                        <div class="form-group" style="margin-bottom: 15px;">
                            <label for="accountNumber" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">Í≥ÑÏ¢åÎ≤àÌò∏</label>
                            <input type="text" id="accountNumber" placeholder="Í≥ÑÏ¢åÎ≤àÌò∏Î•? ?ûÖ?†•?ïò?Ñ∏?öî (- ?óÜ?ù¥)" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px;">
                        </div>

                        <!-- Ï∂úÍ∏à Í∏àÏï° -->
                        <div class="form-group" style="margin-bottom: 0;">
                            <label for="withdrawAmountInput" style="display: block; margin-bottom: 5px; font-weight: bold; color: #333;">Ï∂úÍ∏à Í∏àÏï° (?òÑ?û¨ ?ûî?ï°: <fmt:formatNumber value="${memberInfo.memberMoney}" pattern="#,###"/>?õê)</label>
                            <div class="amount-input-group" style="display: flex; gap: 10px; align-items: center;">
                                <input type="text" class="charge-amount-input" id="withdrawAmountInput" placeholder="Ï∂úÍ∏à?ï† Í∏àÏï°?ùÑ ?ûÖ?†•?ïò?Ñ∏?öî" style="flex: 1; height: 46px; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; margin: 0;">
                                <button class="full-amount-btn" onclick="setFullAmount()" style="height: 46px; padding: 0 15px; background: #28a745; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 14px; white-space: nowrap;">?†Ñ?ï°</button>
                            </div>
                        </div>
                    </div>

                    <div class="charge-popup-buttons" style="margin-top: 15px;">
                        <button class="charge-popup-btn cancel" onclick="closeWithdrawPopup()">Ï∑®ÏÜå</button>
                        <button class="charge-popup-btn confirm" onclick="processWithdraw()">Ï∂úÍ∏à ?ã†Ï≤?</button>
                    </div>
                </div>
            </div>

            <script>
                let chargeAmount = 0;

                // Ï∂©Ï†Ñ Í¥??†® ?ï®?àò?ì§
                function openChargePopup() {
                    // ÎßàÏù¥?éò?ù¥Ïß??óê?Ñú Ï∂©Ï†Ñ?ïò?äî Í≤ÉÏûÑ?ùÑ ?ÑúÎ≤ÑÏóê ?ïåÎ¶? (?Ñ∏?Öò ?†ïÎ¶¨Ïö©)
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
                        console.error('?Ñ∏?Öò ?†ïÎ¶? Ï§? ?ò§Î•?:', error);
                        // ?ò§Î•òÍ? ?ûà?ñ¥?èÑ ?åù?óÖ?? ?ó¥Í∏?
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
                        alert('ÏµúÏÜå 1,000?õê ?ù¥?ÉÅ Ï∂©Ï†Ñ?ï¥Ï£ºÏÑ∏?öî.');
                        return;
                    }

                    // ?ÑúÎ≤ÑÏóê?Ñú Í≤∞Ï†ú ?†ïÎ≥¥Î?? Í∞??†∏???Ñú ?Ü†?ä§?éò?ù¥Î®ºÏ∏† ?ò∏Ï∂?
                    requestChargePayment(chargeAmount);
                }

                // ?ÑúÎ≤ÑÏóê?Ñú Í≤∞Ï†ú ?†ïÎ≥¥Î?? Í∞??†∏???Ñú ?Ü†?ä§?éò?ù¥Î®ºÏ∏† ?ò∏Ï∂?
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
                                            console.log('Ï∂©Ï†Ñ?ù¥ Ï∑®ÏÜå?êò?óà?äµ?ãà?ã§.');
                                        } else {
                                            alert('Ï∂©Ï†Ñ ?öîÏ≤? ?ã§?å®: ' + error.message);
                                        }
                                    });
                            } else {
                                alert(data.message || 'Ï∂©Ï†Ñ ?öîÏ≤??óê ?ã§?å®?ñà?äµ?ãà?ã§.');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Ï∂©Ï†Ñ ?öîÏ≤? Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§.');
                        });
                }

                // Ï∂úÍ∏à Í¥??†® ?ï®?àò?ì§
                function openWithdrawPopup() {
                    const popup = document.getElementById('withdrawPopupOverlay');
                    if (popup) {
                        popup.style.display = 'flex';
                    }
                    
                    // ?èº Ï¥àÍ∏∞?ôî
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
                    
                    // ?ú†?ö®?Ñ± Í≤??Ç¨
                    if (!bank || bank.trim() === '') {
                        alert('???ñâ?ùÑ ?Ñ†?Éù?ï¥Ï£ºÏÑ∏?öî.');
                        return;
                    }
                    
                    if (!accountNumber || accountNumber.trim() === '') {
                        alert('Í≥ÑÏ¢åÎ≤àÌò∏Î•? ?ûÖ?†•?ï¥Ï£ºÏÑ∏?öî.');
                        return;
                    }
                    
                    if (!withdrawAmount || withdrawAmount < 1000) {
                        alert('ÏµúÏÜå 1,000?õê ?ù¥?ÉÅ Ï∂úÍ∏à Í∞??ä•?ï©?ãà?ã§.');
                        return;
                    }
                    
                    const currentBalance = ${memberInfo.memberMoney};
                    if (withdrawAmount > currentBalance) {
                        alert('?ûî?ï°?ù¥ Î∂?Ï°±Ìï©?ãà?ã§.');
                        return;
                    }
                    
                    if (!confirm(bank + '\nÍ≥ÑÏ¢åÎ≤àÌò∏: ' + accountNumber + '\nÏ∂úÍ∏àÍ∏àÏï°: ' + withdrawAmount.toLocaleString() + '?õê\n\n?úÑ ?†ïÎ≥¥Î°ú Ï∂úÍ∏à?ïò?ãúÍ≤†Ïäµ?ãàÍπ??')) {
                        return;
                    }
                    
                    // ?ÑúÎ≤ÑÎ°ú Ï∂úÍ∏à ?öîÏ≤?
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
                            alert('Ï∂úÍ∏à ?ã†Ï≤??ù¥ ?ôÑÎ£åÎêò?óà?äµ?ãà?ã§.\nÏ≤òÎ¶¨ÍπåÏ? 1-2?ùº ?Üå?öî?ê©?ãà?ã§.');
                            closeWithdrawPopup();
                            window.location.reload(); // ?ûî?ï° ?óÖ?ç∞?ù¥?ä∏Î•? ?úÑ?ï¥ ?ÉàÎ°úÍ≥†Ïπ?
                        } else {
                            alert(data.message || 'Ï∂úÍ∏à ?ã†Ï≤??óê ?ã§?å®?ñà?äµ?ãà?ã§.');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Ï∂úÍ∏à ?ã†Ï≤? Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§.');
                    });
                }

                // Ï∂©Ï†Ñ/Ï∂úÍ∏à Í∏àÏï° ?ûÖ?†• ?ãú ?è¨Îß∑ÌåÖ
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
                                
                                // ?òÑ?û¨ ?ûî?ï°Î≥¥Îã§ ?Å∞ Í∏àÏï°?? ?ûÖ?†• Î∂àÍ?
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

                    // URL ?åå?ùºÎØ∏ÌÑ∞?óê?Ñú Ï∂©Ï†Ñ Í≤∞Í≥º ?ôï?ù∏
                    const urlParams = new URLSearchParams(window.location.search);
                    const chargeSuccess = urlParams.get('chargeSuccess');
                    const chargeAmount = urlParams.get('chargeAmount');

                    if (chargeSuccess === 'true' && chargeAmount) {
                        // Ï∂©Ï†Ñ ?Ñ±Í≥? ?åù?óÖ
                        alert('?üí? Ï∂©Ï†Ñ?ù¥ ?ôÑÎ£åÎêò?óà?äµ?ãà?ã§!\nÏ∂©Ï†Ñ Í∏àÏï°: ?Ç©' + parseInt(chargeAmount).toLocaleString() + '?õê');
                        // URL?óê?Ñú ?åå?ùºÎØ∏ÌÑ∞ ?†úÍ±?
                        window.history.replaceState({}, document.title, window.location.pathname);
                        // ?éò?ù¥Ïß? ?ÉàÎ°úÍ≥†Ïπ®Ìïò?ó¨ ?ûî?ï° ?óÖ?ç∞?ù¥?ä∏
                        window.location.reload();
                    } else if (chargeSuccess === 'false') {
                        // Ï∂©Ï†Ñ ?ã§?å® ?åù?óÖ
                        alert('?ùåÏ∂©Ï†Ñ?óê ?ã§?å®?ñà?äµ?ãà?ã§.\n?ã§?ãú ?ãú?èÑ?ï¥Ï£ºÏÑ∏?öî.');
                        // URL?óê?Ñú ?åå?ùºÎØ∏ÌÑ∞ ?†úÍ±?
                        window.history.replaceState({}, document.title, window.location.pathname);
                    }
                });

                // ?öå?õê ?Éà?á¥ ?ï®?àò
                function deleteMember() {
                    if (confirm('?†ïÎßêÎ°ú ?öå?õê ?Éà?á¥Î•? ?ïò?ãúÍ≤†Ïäµ?ãàÍπ??\n\n?Éà?á¥ ?ãú Î™®Îì† ?ç∞?ù¥?Ñ∞Í∞? ?Ç≠?†ú?êòÎ©? Î≥µÍµ¨?ï† ?àò ?óÜ?äµ?ãà?ã§.')) {
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
                                    alert('?öå?õê ?Éà?á¥Í∞? ?ôÑÎ£åÎêò?óà?äµ?ãà?ã§.');
                                    // Î°úÍ∑∏?ïÑ?õÉ Ï≤òÎ¶¨ Î∞? ?Ñ∏?Öò Ï¥àÍ∏∞?ôî
                                    window.location.href = '/member/logout';
                                } else {
                                    alert('?öå?õê ?Éà?á¥ Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§.');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                alert('?öå?õê ?Éà?á¥ ?öîÏ≤? Ï§? ?ò§Î•òÍ? Î∞úÏÉù?ñà?äµ?ãà?ã§.');
                            });
                    }
                }

                // Í∞ïÏùò Î™©Î°ù ?Ü†Í∏? ?ï®?àò
                function toggleCourses() {
                    const hiddenCourses = document.querySelectorAll('.hidden-course');
                    const toggleBtn = document.querySelector('.toggle-courses-btn');
                    const toggleText = document.getElementById('toggleText');
                    const toggleIcon = document.getElementById('toggleIcon');

                    let isExpanded = toggleBtn.classList.contains('expanded');

                    if (isExpanded) {
                        // ?†ëÍ∏?
                        hiddenCourses.forEach(course => {
                            course.style.display = 'none';
                        });
                        toggleText.textContent = '?çîÎ≥¥Í∏∞ (' + hiddenCourses.length + 'Í∞?)';
                        toggleIcon.textContent = '?ñº';
                        toggleBtn.classList.remove('expanded');
                    } else {
                        // ?éºÏπòÍ∏∞
                        hiddenCourses.forEach(course => {
                            course.style.display = 'flex';
                        });
                        toggleText.textContent = '?†ëÍ∏?';
                        toggleIcon.textContent = '?ñ≤';
                        toggleBtn.classList.add('expanded');
                    }
                }

                // Í∞ïÏùò Í≤??Éâ Í¥??†® ?ï®?àò?ì§
                let allCourses = []; // ?†ÑÏ≤? Í∞ïÏùò ?ç∞?ù¥?Ñ∞ ???û•

                // ?éò?ù¥Ïß? Î°úÎìú ?ãú ?†ÑÏ≤? Í∞ïÏùò ?ç∞?ù¥?Ñ∞ ???û•
                document.addEventListener('DOMContentLoaded', function () {
                    // Í∏∞Ï°¥ Í∞ïÏùò ?öî?Üå?ì§?ùÑ Î∞∞Ïó¥Î°? ???û•
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
                        // Í≤??Éâ?ñ¥Í∞? ?óÜ?úºÎ©? ?õê?ûò ?ÉÅ?ÉúÎ°? Î≥µÏõê
                        restoreOriginalCourses();
                        return;
                    }

                    // Í≤??Éâ Í≤∞Í≥º ?ïÑ?Ñ∞Îß?
                    const filteredCourses = allCourses.filter(course =>
                        course.title.includes(searchTerm) ||
                        course.instructor.includes(searchTerm) ||
                        course.category.includes(searchTerm)
                    );

                    // Í∏∞Ï°¥ Í∞ïÏùò Î™©Î°ù ?†úÍ±?
                    const existingCourses = courseContent.querySelectorAll('.course-item');
                    existingCourses.forEach(course => course.remove());

                    // ?Ü†Í∏? Î≤ÑÌäº ?†úÍ±?
                    const toggleBtn = courseContent.querySelector('.toggle-courses-btn');
                    if (toggleBtn) toggleBtn.remove();

                    if (filteredCourses.length > 0) {
                        // ?ïÑ?Ñ∞ÎßÅÎêú Í∞ïÏùò?ì§ ?ëú?ãú
                        filteredCourses.forEach(course => {
                            const courseElement = course.element.cloneNode(true);
                            courseElement.style.display = 'flex';
                            courseElement.classList.remove('hidden-course');
                            courseContent.appendChild(courseElement);
                        });
                    } else {
                        // Í≤??Éâ Í≤∞Í≥ºÍ∞? ?óÜ?ùÑ ?ïå
                        const noResult = document.createElement('div');
                        noResult.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noResult.textContent = 'Í≤??Éâ Í≤∞Í≥ºÍ∞? ?óÜ?äµ?ãà?ã§.';
                        courseContent.appendChild(noResult);
                    }
                }

                function restoreOriginalCourses() {
                    const courseContent = document.getElementById('courseContent');

                    // Í∏∞Ï°¥ ?Ç¥?ö© ?†úÍ±?
                    courseContent.innerHTML = '';

                    if (allCourses.length > 0) {
                        // ?õê?ûò Í∞ïÏùò?ì§ Î≥µÏõê
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

                        // ?Ü†Í∏? Î≤ÑÌäº Î≥µÏõê (4Í∞? ?ù¥?ÉÅ?ùº ?ïåÎß?)
                        if (allCourses.length > 3) {
                            const toggleBtn = document.createElement('div');
                            toggleBtn.className = 'toggle-courses-btn';
                            toggleBtn.onclick = toggleCourses;
                            toggleBtn.innerHTML = '<span id="toggleText">?çîÎ≥¥Í∏∞ (' + (allCourses.length - 3) + 'Í∞?)</span><span id="toggleIcon">?ñº</span>';
                            courseContent.appendChild(toggleBtn);
                        }
                    } else {
                        const noLecture = document.createElement('div');
                        noLecture.style.cssText = 'text-align: center; color: #999; padding: 40px;';
                        noLecture.textContent = '?àòÍ∞ïÏ§ë?ù∏ Í∞ïÏùòÍ∞? ?óÜ?äµ?ãà?ã§.';
                        courseContent.appendChild(noLecture);
                    }
                }
            </script>

            <!-- Footer Include -->
            <jsp:include page="../common/footer.jsp"/>
        </div>
    </body>
</html>