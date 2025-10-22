<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="member-manage">
    <h2>회원 관리</h2>
    <p class="summary">총 ${uStatus.totalCount}명의 회원이 있습니다. [ 학생 : ${uStatus.studentCount}명 | 선생님 : ${uStatus.teacherCount}명 | 관리자 : ${uStatus.adminCount}명 ]</p>

    <div class="search-box">
        <input type="text" id="searchInput" placeholder="이름을 입력하세요" value="${searchKeyword}" onkeypress="handleEnterKey(event)">
        <button onclick="searchUsers()">검색</button>
    </div>

    <div class="sort-section">
        <label><input type="radio" name="sort" value="name" onchange="sortUsers(this.value)" ${currentSort eq 'name' or empty currentSort ? 'checked' : ''}> 이름순</label>
        <label><input type="radio" name="sort" value="type" onchange="sortUsers(this.value)" ${currentSort eq 'type' ? 'checked' : ''}> 권한별</label>
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
        <c:forEach var="user" items="${uList}" varStatus="status">
            <tr>
                <td>${user.memberType}</td>
                <td>${user.memberId}</td>
                <td>
                    <span class="pw-mask">***************</span>
                    <button class="btn show" onclick="togglePw(this, 'pw${status.index}')">보기</button>
                    <span id="pw${status.index}" class="pw-real" style="display:none;">${user.memberPw}</span>
                </td>
                <td>${user.memberName}</td>
                <td>${user.memberBirth}</td>
                <td>
                    <button class="btn delete" onclick="deleteUser('${user.memberId}')">삭제</button>
                    <button class="btn edit" onclick="openEditRow(this, '${user.memberId}')">수정</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${startNavi ne 1}">
            <button onclick="loadUserPage(${startNavi - 1}, '${currentSort}', '${searchKeyword}')">이전</button>
        </c:if>

        <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
            <c:choose>
                <c:when test="${currentPage eq n}">
                    <button class="active">${n}</button>
                </c:when>
                <c:otherwise>
                    <button onclick="loadUserPage(${n}, '${currentSort}', '${searchKeyword}')">${n}</button>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${endNavi ne maxPage}">
            <button onclick="loadUserPage(${endNavi + 1}, '${currentSort}', '${searchKeyword}')">다음</button>다음</button>
        </c:if>
    </div>
</div>

<script>
    function loadUserPage(pageNum, sortType, searchKeyword) {
        var url = "/admin/user?page=" + pageNum;
        if (sortType) {
            url += "&sort=" + sortType;
        }
        if (searchKeyword) {
            url += "&search=" + encodeURIComponent(searchKeyword);
        }
        $("#mainContent").load(url, function(response, status, xhr) {
            if (status == "error") {
                console.log("Error loading page:", xhr.status, xhr.statusText);
                $("#mainContent").html("<h2>페이지를 불러올 수 없습니다.</h2>");
            }
        });
    }

    function sortUsers(sortType) {
        var searchKeyword = document.getElementById('searchInput').value;
        loadUserPage(1, sortType, searchKeyword);
    }

    function searchUsers() {
        var searchKeyword = document.getElementById('searchInput').value;
        var sortType = document.querySelector('input[name="sort"]:checked').value;
        loadUserPage(1, sortType, searchKeyword);
    }

    function handleEnterKey(event) {
        if (event.key === 'Enter') {
            searchUsers();
        }
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

    function openEditRow(btn, memberId) {
        const row = btn.closest('tr');
        const table = document.getElementById('memberTable');

        // 현재 행이 이미 수정 모드인지 확인
        if (row.classList.contains('editing')) {
            // 수정 모드 닫기
            const existing = table.querySelector('.edit-row');
            if (existing) existing.remove();
            row.classList.remove('editing');
            document.querySelectorAll('.btn.edit').forEach(b => {
                b.disabled = false;
                b.style.backgroundColor = '#2980b9'; // 원래 색상으로 복원
            });
            return;
        }

        // 기존 수정행 제거 및 editing 클래스 제거
        const existing = table.querySelector('.edit-row');
        if (existing) existing.remove();
        document.querySelectorAll('tr.editing').forEach(tr => tr.classList.remove('editing'));

        // 모든 수정 버튼 활성화 및 색상 복원
        document.querySelectorAll('.btn.edit').forEach(b => {
            b.disabled = false;
            b.style.backgroundColor = '#2980b9';
        });
        
        // 현재 버튼만 선택된 상태로 표시
        btn.style.backgroundColor = '#1c6aa3';

        // 현재 행에 editing 클래스 추가
        row.classList.add('editing');

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
                <select id="editType-${id}">
                    <option ${type == '일반회원' ? 'selected' : ''}>일반회원</option>
                    <option ${type == '선생님' ? 'selected' : ''}>선생님</option>
                    <option ${type == '관리자' ? 'selected' : ''}>관리자</option>
                </select>
            </label>

            <label>비밀번호:
                <input type="password" id="editPw-${id}" placeholder="새 비밀번호 입력">
            </label>

            <label>이름:
                <input type="text" id="editName-${id}" value="${name}">
            </label>

            <label>생년월일:
                <input type="date" id="editBirth-${id}" value="${birth.replaceAll('.', '-')}">
            </label>

            <button class="btn save" onclick="saveEdit('${id}')">수정 완료</button>
        </div>
    `;
        newRow.appendChild(cell);
        row.insertAdjacentElement('afterend', newRow);
    }

    function saveEdit(memberId) {
        // 수정 행 바로 위의 원본 행에서 아이디를 가져오기
        const editRow = document.querySelector('.edit-row');
        const originalRow = editRow.previousElementSibling;
        const actualMemberId = originalRow.children[1].innerText.trim(); // 아이디 컬럼
        
        const typeSelect = editRow.querySelector('select');
        const pwInput = editRow.querySelector('input[type="password"]');
        const nameInput = editRow.querySelector('input[type="text"]:not([readonly])');
        const birthInput = editRow.querySelector('input[type="date"]');
        
        const type = typeSelect ? typeSelect.value.trim() : '';
        const pw = pwInput ? pwInput.value.trim() : '';
        const name = nameInput ? nameInput.value.trim() : '';
        const birth = birthInput ? birthInput.value.trim() : '';

        if (!type || !pw || !name || !birth) {
            alert('모든 항목을 입력해야 수정이 가능합니다.');
            return;
        }

        const data = {
            memberId: actualMemberId,
            memberPw: pw,
            memberName: name,
            memberBirth: birth,
            memberType: type
        };

        $.ajax({
            url: '/admin/updateUser',
            type: 'POST',
            data: JSON.stringify(data),
            contentType: 'application/json; charset=UTF-8',
            success: function(response) {
                // editing 클래스 제거
                document.querySelectorAll('tr.editing').forEach(tr => tr.classList.remove('editing'));
                // 수정 행 제거
                document.querySelector('.edit-row').remove();
                // 수정 버튼 활성화 및 색상 복원
                document.querySelectorAll('.btn.edit').forEach(b => {
                    b.disabled = false;
                    b.style.backgroundColor = '#2980b9';
                });
                
                alert('회원 정보가 수정되었습니다.');
                location.reload();
            },
            error: function(xhr, status, error) {
                alert('수정 실패: ' + xhr.responseText);
            }
        });
    }
</script>
