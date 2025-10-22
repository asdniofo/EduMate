<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/admin/admin_lecture.css">

<div class="lecture-manage">
    <h2>강의 관리</h2>
    <p class="summary">총 ${totalCount}개의 강의가 있습니다.</p>

    <div class="search-box">
        <input type="text" id="searchInput" placeholder="강의명, 강사명을 입력하세요" value="${searchKeyword}" onkeypress="handleEnterKey(event)">
        <button onclick="searchLectures()">검색</button>
    </div>

    <div class="sort-section">
        <label><input type="radio" name="sort" value="name" onchange="sortLectures(this.value)" ${currentSort eq 'name' or empty currentSort ? 'checked' : ''}> 강의명순</label>
        <label><input type="radio" name="sort" value="date" onchange="sortLectures(this.value)" ${currentSort eq 'date' ? 'checked' : ''}> 등록일순</label>
        <label><input type="radio" name="sort" value="category" onchange="sortLectures(this.value)" ${currentSort eq 'category' ? 'checked' : ''}> 카테고리순</label>
        <label><input type="radio" name="sort" value="instructor" onchange="sortLectures(this.value)" ${currentSort eq 'instructor' ? 'checked' : ''}> 강사명순</label>
    </div>

    <table class="lecture-table" id="lectureTable">
        <thead>
        <tr>
            <th>강의명</th>
            <th>강사명</th>
            <th>카테고리</th>
            <th>가격</th>
            <th>등록일</th>
            <th>챕터수</th>
            <th>수강생수</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="lecture" items="${lectureList}" varStatus="status">
            <tr data-lecture-no="${lecture.lectureNo}">
                <td class="lecture-name">${lecture.lectureName}</td>
                <td>${lecture.memberName}</td>
                <td>${lecture.lectureCategory}</td>
                <td>₩ <fmt:formatNumber value="${lecture.lecturePrice}" pattern="#,###"/></td>
                <td><fmt:formatDate value="${lecture.lectureCreatedDate}" pattern="yyyy-MM-dd"/></td>
                <td class="chapter-count">-</td>
                <td>${lecture.countStudent}명</td>
                <td>
                    <button class="btn detail" onclick="toggleChapterView(this, ${lecture.lectureNo})">챕터보기</button>
                    <button class="btn delete" onclick="deleteLecture(${lecture.lectureNo})">강의삭제</button>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <c:if test="${startNavi ne 1}">
            <button onclick="loadLecturePage(${startNavi - 1}, '${currentSort}', '${searchKeyword}')">이전</button>
        </c:if>

        <c:forEach begin="${startNavi}" end="${endNavi}" var="n">
            <c:choose>
                <c:when test="${currentPage eq n}">
                    <button class="active">${n}</button>
                </c:when>
                <c:otherwise>
                    <button onclick="loadLecturePage(${n}, '${currentSort}', '${searchKeyword}')">${n}</button>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <c:if test="${endNavi ne maxPage}">
            <button onclick="loadLecturePage(${endNavi + 1}, '${currentSort}', '${searchKeyword}')">다음</button>
        </c:if>
    </div>
</div>

<script>
    $(document).ready(function() {
        // 페이지 로드시 각 강의의 챕터 수 조회
        $('.lecture-table tbody tr').each(function() {
            const lectureNo = $(this).data('lecture-no');
            const chapterCountCell = $(this).find('.chapter-count');
            
            $.get('/admin/lecture/videos', { lectureNo: lectureNo })
                .done(function(videos) {
                    chapterCountCell.text(videos.length + '개');
                })
                .fail(function() {
                    chapterCountCell.text('0개');
                });
        });
    });

    function loadLecturePage(pageNum, sortType, searchKeyword) {
        var url = "/admin/lecture?page=" + pageNum;
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

    function sortLectures(sortType) {
        var searchKeyword = document.getElementById('searchInput').value;
        loadLecturePage(1, sortType, searchKeyword);
    }

    function searchLectures() {
        var searchKeyword = document.getElementById('searchInput').value;
        var sortType = document.querySelector('input[name="sort"]:checked').value;
        loadLecturePage(1, sortType, searchKeyword);
    }

    function handleEnterKey(event) {
        if (event.key === 'Enter') {
            searchLectures();
        }
    }

    function toggleChapterView(btn, lectureNo) {
        const row = btn.closest('tr');
        const table = document.getElementById('lectureTable');
        
        // 이미 챕터가 표시되어 있는지 확인
        const existingChapterRow = row.nextElementSibling;
        if (existingChapterRow && existingChapterRow.classList.contains('chapter-row')) {
            // 챕터 행이 있으면 제거
            existingChapterRow.remove();
            btn.textContent = '챕터보기';
            row.classList.remove('expanded');
            return;
        }

        // 다른 모든 챕터 행들 제거
        document.querySelectorAll('.chapter-row').forEach(chapterRow => {
            chapterRow.remove();
        });
        document.querySelectorAll('.expanded').forEach(expandedRow => {
            expandedRow.classList.remove('expanded');
            expandedRow.querySelector('.btn.detail').textContent = '챕터보기';
        });

        // 현재 행을 확장된 상태로 표시
        row.classList.add('expanded');
        btn.textContent = '접기';

        // 챕터 목록 조회 및 표시
        $.get('/admin/lecture/videos', { lectureNo: lectureNo })
            .done(function(videos) {
                showChapterList(row, videos, lectureNo);
            })
            .fail(function() {
                alert('챕터 목록을 불러올 수 없습니다.');
                btn.textContent = '챕터보기';
                row.classList.remove('expanded');
            });
    }

    function showChapterList(parentRow, videos, lectureNo) {
        // 새로운 챕터 행 생성
        const chapterRow = document.createElement('tr');
        chapterRow.className = 'chapter-row';
        
        const cell = document.createElement('td');
        cell.colSpan = 8;
        
        let chapterHtml = '<div class="chapter-container">';
        chapterHtml += '<h4>챕터 목록</h4>';
        
        if (videos.length === 0) {
            chapterHtml += '<p class="no-chapters">등록된 챕터가 없습니다.</p>';
        } else {
            chapterHtml += '<table class="chapter-table">';
            chapterHtml += '<thead><tr><th>순서</th><th>챕터명</th><th>재생시간</th><th>관리</th></tr></thead>';
            chapterHtml += '<tbody>';
            
            videos.forEach(function(video) {
                const minutes = Math.floor(video.videoTime / 60);
                const seconds = video.videoTime % 60;
                const timeStr = minutes + '분 ' + seconds + '초';
                
                chapterHtml += '<tr>';
                chapterHtml += '<td>' + video.videoOrder + '</td>';
                chapterHtml += '<td>' + video.videoTitle + '</td>';
                chapterHtml += '<td>' + timeStr + '</td>';
                chapterHtml += '<td><button class="btn delete-chapter" onclick="deleteChapter(' + video.videoNo + ', ' + lectureNo + ')">삭제</button></td>';
                chapterHtml += '</tr>';
            });
            
            chapterHtml += '</tbody></table>';
        }
        
        chapterHtml += '</div>';
        cell.innerHTML = chapterHtml;
        chapterRow.appendChild(cell);
        
        // 부모 행 다음에 삽입
        parentRow.insertAdjacentElement('afterend', chapterRow);
    }

    function deleteChapter(videoNo, lectureNo) {
        if (!confirm('이 챕터를 삭제하시겠습니까? 삭제 후 순서가 자동으로 재정렬됩니다.')) return;
        
        $.post('/admin/lecture/deleteVideo', { videoNo: videoNo, lectureNo: lectureNo })
            .done(function() {
                alert('챕터가 삭제되고 순서가 재정렬되었습니다.');
                // 챕터 목록 새로고침
                const expandedRow = document.querySelector('.expanded');
                if (expandedRow) {
                    const btn = expandedRow.querySelector('.btn.detail');
                    toggleChapterView(btn, lectureNo);
                    toggleChapterView(btn, lectureNo);
                }
                // 챕터 수 업데이트
                updateChapterCount(lectureNo);
            })
            .fail(function() {
                alert('챕터 삭제에 실패했습니다.');
            });
    }

    function deleteLecture(lectureNo) {
        if (!confirm('이 강의를 삭제하시겠습니까? 모든 챕터도 함께 삭제됩니다.')) return;
        
        $.post('/admin/lecture/delete', { lectureNo: lectureNo })
            .done(function() {
                alert('강의가 삭제되었습니다.');
                location.reload();
            })
            .fail(function() {
                alert('강의 삭제에 실패했습니다.');
            });
    }

    function updateChapterCount(lectureNo) {
        const row = document.querySelector(`tr[data-lecture-no="${lectureNo}"]`);
        const chapterCountCell = row.querySelector('.chapter-count');
        
        $.get('/admin/lecture/videos', { lectureNo: lectureNo })
            .done(function(videos) {
                chapterCountCell.textContent = videos.length + '개';
            })
            .fail(function() {
                chapterCountCell.textContent = '0개';
            });
    }
</script>