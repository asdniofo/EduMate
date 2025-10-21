<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="member-manage">
    <h2>회원 관리</h2>
    
    <c:set var="adminCount" value="0" />
	<c:set var="teacherCount" value="0" />
	<c:set var="memberCount" value="0" />

	<c:forEach var="user" items="${userList}">
    <c:if test="${user.adminYN eq 'Y'}">
        <c:set var="adminCount" value="${adminCount + 1}" />
    </c:if>
    <c:if test="${user.teacherYN eq 'Y'}">
        <c:set var="teacherCount" value="${teacherCount + 1}" />
    </c:if>
    <c:if test="${user.adminYN ne 'Y' and user.teacherYN ne 'Y'}">
        <c:set var="memberCount" value="${memberCount + 1}" />
    </c:if>
	</c:forEach>
    <p class="summary">
    총 ${userList.size()}명의 회원이 있습니다.<br>
    - 일반회원: ${memberCount}명<br>
    - 선생님: ${teacherCount}명<br>
    - 관리자: ${adminCount}명
	</p>

    <div class="search-box">
        <input type="text" id="searchInput" placeholder="이름을 입력하세요">
        <button id="searchBtn">검색</button>
    </div>

    <table class="member-table" id="memberTable">
        <thead>
            <tr>
                <th>회원 구분</th>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>생년월일</th>
                <th>금액</th>
                <th>설정</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="user" items="${userList}">
                <tr>
                    <td>
                        <c:choose>
                            <c:when test="${user.adminYN eq 'Y'}">관리자</c:when>
                            <c:when test="${user.teacherYN eq 'Y'}">선생님</c:when>
                            <c:otherwise>일반회원</c:otherwise>
                        </c:choose>
                    </td>
                    <td>${user.memberId}</td>
                    <td>
                        <span class="pw-mask">********</span>
						<button class="btn show" onclick="togglePw(this, 'pw-${user.memberId}')">보기</button>
						<span id="pw-${user.memberId}" class="pw-real" style="display:none;">${user.memberPw}</span>
                    </td>
                    <td>${user.memberName}</td>
                    <td>${user.memberBirth}</td>
                    <td>${user.memberMoney}</td>
                    <td>
                        <button class="btn delete" onclick="deleteUser('${user.memberId}')">삭제</button>
                        <button class="btn edit" onclick="openEditRow(this, '${user.memberId}')">수정</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
function openEditRow(btn, memberId) {
    const row = btn.closest('tr');
    const nextRow = row.nextElementSibling;

    // 이미 열려 있는 같은 행이면 닫기
    if (nextRow && nextRow.classList.contains('edit-row')) {
        nextRow.remove();
        return;
    }
    // 다른 열려 있는 수정창 닫기
    document.querySelectorAll('.edit-row').forEach(r => r.remove());

    const cells = row.children;
    const type = cells[0].innerText.trim();
    const memberName = cells[3].innerText.trim();
    const birth = cells[4].innerText.trim();
    const money = cells[5].innerText.trim();

    const newRow = document.createElement('tr');
    newRow.className = 'edit-row';
    const cell = document.createElement('td');
    cell.colSpan = 7;

    // 유니크 id 적용
    cell.innerHTML = `
        <div class="edit-box">
            <label>회원 구분:
                <select id="editType-${memberId}">
                    <option value="일반회원" ${type == '일반회원' ? 'selected' : ''}>일반회원</option>
                    <option value="선생님" ${type == '선생님' ? 'selected' : ''}>선생님</option>
                    <option value="관리자" ${type == '관리자' ? 'selected' : ''}>관리자</option>
                </select>
            </label>
            <label>아이디:<input type="text" id="editId-${memberId}" value="${memberId}"></label>
            <label>비밀번호:<input type="password" id="editPw-${memberId}" placeholder="새 비밀번호 입력"></label>
            <label>이름:<input type="text" id="editName-${memberId}" value="${memberName}"></label>
            <label>생년월일:<input type="date" id="editBirth-${memberId}" value="${birth.replaceAll('.', '-')}"></label>
            <label>금액:<input type="number" id="editMoney-${memberId}" value="${money}"></label>
            <button class="btn save" onclick="saveEdit('${memberId}')">수정 완료</button>
        </div>
    `;
    newRow.appendChild(cell);
    row.insertAdjacentElement('afterend', newRow);
}

function saveEdit(memberId) {
	let type = document.getElementById(`editType-${memberId}`).value;
	let teacherYN = type == '선생님' ? 'Y' : 'N';
	let adminYN = type == '관리자' ? 'Y' : 'N';
    const data = {
    	    memberId: document.getElementById(`editId-${memberId}`).value,
    	    memberPw: document.getElementById(`editPw-${memberId}`).value,
    	    memberName: document.getElementById(`editName-${memberId}`).value,
    	    memberBirth: document.getElementById(`editBirth-${memberId}`).value,
    	    memberMoney: document.getElementById(`editMoney-${memberId}`).value,
    	    teacherYN: teacherYN,
    	    adminYN: adminYN
    };

    $.ajax({
        url: '/admin/updateUser',
        type: 'POST',
        data: JSON.stringify(data),
        contentType: 'application/json; charset=UTF-8',
        success: function() {
            alert('회원 정보가 수정되었습니다.');
            location.reload();
        },
        error: function() {
            alert('수정 실패');
        }
    });
}

function deleteUser(memberId) {
    if (!confirm('정말 삭제하시겠습니까?')) return;
    $.ajax({
        url: '/admin/deleteUser',
        type: 'POST',
        data: { memberId },
        success: function() {
            alert('삭제되었습니다.');
            location.reload();
        },
        error: function() {
            alert('삭제 실패');
        }
    });
}
function togglePw(btn, pwId) {
    const pwReal = document.getElementById(pwId);
    const pwMask = btn.previousElementSibling;

    if (pwReal.style.display === "none") {
        pwReal.style.display = "inline";
        pwMask.style.display = "none";
        btn.textContent = "숨기기";
    } else {
        pwReal.style.display = "none";
        pwMask.style.display = "inline";
        btn.textContent = "보기";
    }
}
</script>
