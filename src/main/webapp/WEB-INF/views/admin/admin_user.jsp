<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="member-manage">
    <h2>회원 관리</h2>
    <p class="summary">총 0명의 회원이 있습니다. [ 회원 : 00명 | 선생님 : 00명 | 관리자 : 00명 ]</p>

    <div class="search-box">
        <input type="text" placeholder="이름을 입력하세요">
        <button>검색</button>
    </div>

    <div class="sort-section">
        <label><input type="radio" name="sort" checked> 이름순</label>
        <label><input type="radio" name="sort"> 최신순</label>
    </div>

    <table class="member-table" id="memberTable">
        <thead>
            <tr>
                <th>회원 구분</th>
                <th>아이디</th>
                <th>비밀번호</th>
                <th>이름</th>
                <th>생년월일</th>
                <th>설정</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>일반회원</td>
                <td>iwannagotohomerightnow</td>
                <td>
                    <span class="pw-mask">***************</span>
                    <button class="btn show" onclick="togglePw(this, 'pw1')">보기</button>
                    <span id="pw1" class="pw-real" style="display:none;">qwer1234!</span>
                </td>
                <td>남궁뚝딱</td>
                <td>1999.09.06</td>
                <td>
                    <button class="btn delete">삭제</button>
                    <button class="btn block">차단</button>
                    <button class="btn edit" onclick="openEditRow(this)">수정</button>
                </td>
            </tr>

            <tr>
                <td>선생님</td>
                <td>teach1234</td>
                <td>
                    <span class="pw-mask">***************</span>
                    <button class="btn show" onclick="togglePw(this, 'pw2')">보기</button>
                    <span id="pw2" class="pw-real" style="display:none;">teach4321!</span>
                </td>
                <td>홍길동</td>
                <td>1988.05.21</td>
                <td>
                    <button class="btn delete">삭제</button>
                    <button class="btn block">차단</button>
                    <button class="btn edit" onclick="openEditRow(this)">수정</button>
                </td>
            </tr>
        </tbody>
    </table>

    <div class="pagination">
        <button>이전</button>
        <button class="active">1</button>
        <button>2</button>
        <button>3</button>
        <button>4</button>
        <button>5</button>
        <button>다음</button>
    </div>
</div>

<script>
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

function openEditRow(btn) {
    const row = btn.closest('tr');
    const table = document.getElementById('memberTable');

    // 기존 수정행 제거
    const existing = table.querySelector('.edit-row');
    if (existing) existing.remove();

    // 수정 버튼 다시 활성화
    document.querySelectorAll('.btn.edit').forEach(b => b.disabled = false);
    btn.disabled = true;

    // 기존 데이터 추출
    const type = row.children[0].innerText.trim();
    const id = row.children[1].innerText.trim();
    const name = row.children[3].innerText.trim();
    const birth = row.children[4].innerText.trim();

    // 새로운 수정행 추가
    const newRow = document.createElement('tr');
    newRow.className = 'edit-row';
    const cell = document.createElement('td');
    cell.colSpan = 6;

    cell.innerHTML = `
        <div class="edit-box">
            <label>회원 구분:
                <select id="editType">
                    <option ${type == '일반회원' ? 'selected' : ''}>일반회원</option>
                    <option ${type == '선생님' ? 'selected' : ''}>선생님</option>
                    <option ${type == '관리자' ? 'selected' : ''}>관리자</option>
                </select>
            </label>

            <label>아이디:
                <input type="text" id="editId" value="${id}">
            </label>

            <label>비밀번호:
                <input type="password" id="editPw" placeholder="새 비밀번호 입력">
            </label>

            <label>이름:
                <input type="text" id="editName" value="${name}">
            </label>

            <label>생년월일:
                <input type="date" id="editBirth" value="${birth.replaceAll('.', '-')}">
            </label>

            <button class="btn save" onclick="saveEdit(this)">수정 완료</button>
        </div>
    `;
    newRow.appendChild(cell);
    row.insertAdjacentElement('afterend', newRow);
}

function saveEdit(btn) {
    const type = document.getElementById('editType').value.trim();
    const id = document.getElementById('editId').value.trim();
    const pw = document.getElementById('editPw').value.trim();
    const name = document.getElementById('editName').value.trim();
    const birth = document.getElementById('editBirth').value.trim();

    if (!type || !id || !pw || !name || !birth) {
        alert('모든 항목을 입력해야 수정이 가능합니다.');
        return;
    }

    alert('회원 정보가 수정되었습니다.');

    // 수정 행 제거
    document.querySelector('.edit-row').remove();
    document.querySelectorAll('.btn.edit').forEach(b => b.disabled = false);
}
</script>
