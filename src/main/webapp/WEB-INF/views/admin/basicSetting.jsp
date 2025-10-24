<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/admin/basicSetting.css">

    <h2>결제 관리</h2>
    
    <!-- 상태별 필터 -->
    <div class="sort-section">
        <label><input type="radio" name="status" value="요청" onchange="filterByStatus(this.value)" ${currentSort == '요청' || empty currentSort ? 'checked' : ''}> 요청</label>
        <label><input type="radio" name="status" value="승인" onchange="filterByStatus(this.value)" ${currentSort == '승인' ? 'checked' : ''}> 승인</label>
        <label><input type="radio" name="status" value="거절" onchange="filterByStatus(this.value)" ${currentSort == '거절' ? 'checked' : ''}> 거절</label>
        <c:if test="${currentSort == '요청' || empty currentSort}">
            <span class="count-info">요청건수: ${totalCount}개</span>
        </c:if>
    </div>
        
        <!-- 요청 처리 테이블 -->
        <c:if test="${currentSort == '요청' || empty currentSort}">
            <table class="withdraw-table">
                <thead>
                    <tr>
                        <th>요청자</th>
                        <th>은행</th>
                        <th>계좌번호</th>
                        <th>금액</th>
                        <th>요청일</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="withdraw" items="${wList}">
                        <tr>
                            <td>${withdraw.memberName}</td>
                            <td>${withdraw.bank}</td>
                            <td>${withdraw.accountNo}</td>
                            <td><fmt:formatNumber value="${withdraw.amount}" type="currency" currencySymbol="₩"/></td>
                            <td><fmt:formatDate value="${withdraw.createDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <button class="btn approve" onclick="updateStatus(${withdraw.withDrawNo}, '승인')">승인</button>
                                <button class="btn reject" onclick="updateStatus(${withdraw.withDrawNo}, '거절')">거절</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <!-- 처리 완료 내역 테이블 -->
        <c:if test="${currentSort == '승인' || currentSort == '거절'}">
            <table class="withdraw-table">
                <thead>
                    <tr>
                        <th>요청자</th>
                        <th>은행</th>
                        <th>계좌번호</th>
                        <th>금액</th>
                        <th>요청일</th>
                        <th>처리일</th>
                        <th>상태</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="withdraw" items="${wList}">
                        <tr>
                            <td>${withdraw.memberName}</td>
                            <td>${withdraw.bank}</td>
                            <td>${withdraw.accountNo}</td>
                            <td><fmt:formatNumber value="${withdraw.amount}" type="currency" currencySymbol="₩"/></td>
                            <td><fmt:formatDate value="${withdraw.createDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td><fmt:formatDate value="${withdraw.processedDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                            <td>
                                <span class="status-badge status-${withdraw.status}">
                                    ${withdraw.status}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <!-- 페이지네이션 -->
        <div class="pagination">
            <c:if test="${startNavi ne 1}">
                <button onclick="loadWithdrawPage(${startNavi - 1}, '${currentSort}')">이전</button>
            </c:if>
            
            <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
                <c:choose>
                    <c:when test="${currentPage eq n}">
                        <button class="active">${n}</button>
                    </c:when>
                    <c:otherwise>
                        <button onclick="loadWithdrawPage(${n}, '${currentSort}')">${n}</button>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            
            <c:if test="${endNavi ne maxPage}">
                <button onclick="loadWithdrawPage(${endNavi + 1}, '${currentSort}')">다음</button>
            </c:if>
        </div>

<script>
    function loadPage(url) {
        // 사이드바 active 상태 변경
        $(".sidebar-menu li").removeClass("active");
        
        // URL에 따라 해당 메뉴에 active 클래스 추가
        if (url === '/admin/user') {
            $(".sidebar-menu a[href='/admin/user']").parent().addClass("active");
        } else if (url === '/admin/lecture') {
            $(".sidebar-menu a[href='/admin/lecture']").parent().addClass("active");
        } else if (url === '/admin/list') {
            $(".sidebar-menu a[href='/admin/list']").parent().addClass("active");
        }
        
        $("#mainContent").load(url, function(response, status, xhr) {
            if (status == "error") {
                console.log("Error loading page:", xhr.status, xhr.statusText);
                $("#mainContent").html("<h2>페이지를 불러올 수 없습니다.</h2>");
            }
        });
    }
    
    function loadWithdrawPage(pageNum, status) {
        $("#mainContent").load("/admin/setting?page=" + pageNum + "&status=" + status, function(response, status, xhr) {
            if (status == "error") {
                console.log("Error loading page:", xhr.status, xhr.statusText);
                $("#mainContent").html("<h2>페이지를 불러올 수 없습니다.</h2>");
            }
        });
    }
    
    function filterByStatus(status) {
        loadWithdrawPage(1, status);
    }
    
    function updateStatus(withDrawNo, status) {
        if (confirm(status + ' 처리하시겠습니까?')) {
            var url = status === '승인' ? '/admin/withdraw/approve' : '/admin/withdraw/reject';
            
            $.ajax({
                url: url,
                type: 'POST',
                data: { withdrawNo: withDrawNo },
                success: function(response) {
                    alert(response);
                    // 현재 상태 필터 유지하면서 페이지 새로고침
                    var currentStatus = document.querySelector('input[name="status"]:checked').value;
                    loadWithdrawPage(1, currentStatus);
                },
                error: function() {
                    alert('처리 중 오류가 발생했습니다.');
                }
            });
        }
    }

</script>
