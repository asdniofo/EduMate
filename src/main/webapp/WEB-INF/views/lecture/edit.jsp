<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 수정 - EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/lecture/edit.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />
        
        <!-- Main Content -->
        <div class="content-wrapper">
            <h1 class="page-title">강의 수정</h1>
            
            <div class="form-container">
                <form id="lectureEditForm" action="/lecture/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="lectureNo" value="${lecture.lectureNo}">
                    
                    <!-- 상단: 강의 기본정보 섹션 -->
                    <div class="basic-info-section">
                        <!-- 강의명 -->
                        <div class="form-group">
                            <label class="form-label" for="lectureName">강의명</label>
                            <input type="text" id="lectureName" name="lectureName" class="form-input" 
                                   placeholder="강의 제목을 입력해주세요" value="${lecture.lectureName}" required>
                        </div>
                        
                        <!-- 카테고리와 가격을 한 줄에 배치 -->
                        <div class="form-group-row">
                            <!-- 카테고리 -->
                            <div class="form-group-half">
                                <label class="form-label-small" for="lectureCategory">카테고리</label>
                                <select id="lectureCategory" name="lectureCategory" class="form-input-small" required>
                                    <option value="">카테고리를 선택해주세요</option>
                                    <option value="프로그래밍" ${lecture.lectureCategory eq '프로그래밍' ? 'selected' : ''}>프로그래밍</option>
                                    <option value="디자인" ${lecture.lectureCategory eq '디자인' ? 'selected' : ''}>디자인</option>
                                    <option value="데이터분석" ${lecture.lectureCategory eq '데이터분석' ? 'selected' : ''}>데이터분석</option>
                                    <option value="비즈니스" ${lecture.lectureCategory eq '비즈니스' ? 'selected' : ''}>비즈니스</option>
                                    <option value="언어" ${lecture.lectureCategory eq '언어' ? 'selected' : ''}>언어</option>
                                </select>
                            </div>
                            
                            <!-- 가격 -->
                            <div class="form-group-half">
                                <label class="form-label-small" for="lecturePrice">가격</label>
                                <div class="price-group-small">
                                    <span class="price-symbol-small">₩</span>
                                    <input type="number" id="lecturePrice" name="lecturePrice" class="form-input-small" 
                                           placeholder="가격을 입력해주세요" value="${lecture.lecturePrice}" min="0" required>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 강의 설명 -->
                        <div class="form-group">
                            <label class="form-label" for="lectureDescription">강의 설명</label>
                            <textarea id="lectureDescription" name="lectureDescription" class="form-input" 
                                      style="height: 120px; resize: none; padding-top: 10px;" 
                                      placeholder="강의에 대한 자세한 설명을 입력해주세요" required>${lecture.lectureContent}</textarea>
                        </div>
                    </div>
                    
                    <!-- 썸네일 업데이트 섹션 -->
                    <div class="upload-section">
                        <label class="form-label">썸네일 이미지 수정</label>
                        <div class="thumbnail-section">
                            <div class="video-item">
                                <div class="video-order">📷</div>
                                <div class="video-upload-section">
                                    <div class="video-upload-area" onclick="document.getElementById('thumbnailImage').click()">
                                        <div class="video-upload-text">새 썸네일 선택 (선택사항)</div>
                                    </div>
                                    <input type="file" id="thumbnailImage" name="thumbnailImage" class="hidden" 
                                           accept="image/*" onchange="handleThumbnailUpload(this)">
                                </div>
                            </div>
                            
                            <!-- 현재 썸네일 미리보기 -->
                            <div class="videos-preview-title" style="margin-top: 20px;">현재 썸네일</div>
                            <div class="thumbnail-large-preview" id="currentThumbnail">
                                <c:choose>
                                    <c:when test="${not empty lecture.lecturePath}">
                                        <img src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/lecture/${lecture.lecturePath}" alt="현재 썸네일" class="thumbnail-preview-large">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="thumbnail-placeholder">썸네일이 없습니다</div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <!-- 새 썸네일 미리보기 -->
                            <div class="videos-preview-title" style="margin-top: 20px; display: none;" id="newThumbnailTitle">새 썸네일 미리보기</div>
                            <div class="thumbnail-large-preview" id="thumbnailLargePreview" style="display: none;">
                                <img id="thumbnailPreviewImage" class="thumbnail-preview-large" alt="새 썸네일 미리보기">
                            </div>
                        </div>
                    </div>
                    
                </form>
                
                <!-- 챕터 관리 섹션 -->
                <div class="chapter-management">
                    <h3>챕터 관리</h3>
                    <p>챕터를 드래그하여 순서를 변경하거나, 불필요한 챕터를 삭제할 수 있습니다. 수정이 필요한 경우 삭제 후 새로 추가해주세요.</p>
                    
                    <div class="chapter-list" id="chapterList">
                        <c:forEach var="video" items="${videoList}" varStatus="status">
                            <div class="chapter-item" data-video-no="${video.videoNo}" data-order="${video.videoOrder}">
                                <div class="chapter-order">${video.videoOrder}</div>
                                <div class="chapter-content">
                                    <div class="chapter-title">${video.videoTitle}</div>
                                    <div class="chapter-info">
                                        재생시간: <span class="video-duration">${video.time}</span> | 
                                        파일: ${video.videoPath}
                                    </div>
                                </div>
                                <div class="chapter-actions">
                                    <button type="button" class="btn-small btn-delete" onclick="deleteChapter(${video.videoNo})">삭제</button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <!-- 새 챕터 추가 -->
                    <div class="add-chapter-section">
                        <h4>새 챕터 추가</h4>
                        <form id="addChapterForm" enctype="multipart/form-data">
                            <input type="hidden" name="lectureNo" value="${lecture.lectureNo}">
                            <div class="add-chapter-form">
                                <div class="add-chapter-input">
                                    <label>챕터명</label>
                                    <input type="text" name="videoTitle" placeholder="챕터 제목을 입력하세요" required>
                                </div>
                                <div class="add-chapter-input">
                                    <label>영상 파일</label>
                                    <input type="file" name="videoFile" accept="video/*" required>
                                </div>
                                <button type="button" class="add-chapter-btn" onclick="addChapter()">챕터 추가</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- 수정 버튼 -->
                <div class="submit-container">
                    <button type="submit" form="lectureEditForm" class="submit-btn">강의 정보 수정</button>
                </div>
            </div>
        </div>
        
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />
    </div>


    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sortablejs@1.15.0/Sortable.min.js"></script>
    <script>
        // 썸네일 업로드 처리
        function handleThumbnailUpload(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    const uploadArea = input.parentElement.querySelector('.video-upload-area');
                    const uploadText = uploadArea.querySelector('.video-upload-text');
                    
                    uploadText.textContent = file.name;
                    uploadArea.classList.add('has-file');
                    
                    // 새 썸네일 미리보기 표시
                    const newThumbnailTitle = document.getElementById('newThumbnailTitle');
                    const previewContainer = document.getElementById('thumbnailLargePreview');
                    const previewImage = document.getElementById('thumbnailPreviewImage');
                    
                    previewImage.src = e.target.result;
                    newThumbnailTitle.style.display = 'block';
                    previewContainer.style.display = 'block';
                };
                
                reader.readAsDataURL(file);
            }
        }

        // 드래그 앤 드롭으로 챕터 순서 변경
        const sortable = Sortable.create(document.getElementById('chapterList'), {
            animation: 150,
            ghostClass: 'sortable-placeholder',
            chosenClass: 'dragging',
            onEnd: function(evt) {
                updateChapterOrder();
            }
        });

        // 챕터 순서 업데이트
        function updateChapterOrder() {
            const items = document.querySelectorAll('.chapter-item');
            const orderData = [];
            
            items.forEach((item, index) => {
                const videoNo = parseInt(item.getAttribute('data-video-no'));
                const newOrder = index + 1;
                orderData.push({ videoNo: videoNo, newOrder: newOrder });
                
                // 화면의 순서 번호 업데이트
                item.querySelector('.chapter-order').textContent = newOrder;
                item.setAttribute('data-order', newOrder);
            });
            
            // 서버로 순서 변경 요청
            $.ajax({
                url: '/lecture/updateChapterOrder',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    lectureNo: ${lecture.lectureNo},
                    chapters: orderData
                }),
                success: function(response) {
                    // 이벤트 리바인딩
                    rebindEvents();
                },
                error: function() {
                    location.reload(); // 실패시 페이지 새로고침
                }
            });
        }


        // 챕터 추가
        function addChapter() {
            const form = document.getElementById('addChapterForm');
            const formData = new FormData(form);
            
            if (!form.videoTitle.value.trim()) {
                alert('챕터명을 입력해주세요.');
                return;
            }
            
            if (!form.videoFile.files[0]) {
                alert('영상 파일을 선택해주세요.');
                return;
            }
            
            $.ajax({
                url: '/lecture/addChapter',
                method: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    alert('챕터가 추가되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('챕터 추가에 실패했습니다.');
                }
            });
        }


        // 챕터 삭제
        function deleteChapter(videoNo) {
            if (!confirm('이 챕터를 삭제하시겠습니까? 삭제 후 순서가 자동으로 재정렬됩니다.')) {
                return;
            }
            
            $.ajax({
                url: '/lecture/deleteChapter',
                method: 'POST',
                data: { 
                    videoNo: videoNo,
                    lectureNo: ${lecture.lectureNo}
                },
                success: function(response) {
                    alert('챕터가 삭제되었습니다.');
                    location.reload();
                },
                error: function() {
                    alert('챕터 삭제에 실패했습니다.');
                }
            });
        }

        // 폼 제출 이벤트 바인딩 함수
        function bindSubmitEvent() {
            const form = document.getElementById('lectureEditForm');
            const submitBtn = document.querySelector('.submit-btn');
            
            if (form && submitBtn) {
                // 기존 이벤트 리스너 제거
                form.removeEventListener('submit', handleFormSubmit);
                // 새 이벤트 리스너 추가
                form.addEventListener('submit', handleFormSubmit);
            }
        }
        
        // 폼 제출 핸들러 함수
        function handleFormSubmit(e) {
            const submitBtn = document.querySelector('.submit-btn');
            if (submitBtn) {
                submitBtn.disabled = true;
                submitBtn.textContent = '수정 중...';
            }
        }
        
        // 페이지 로드 시 이벤트 바인딩
        document.addEventListener('DOMContentLoaded', function() {
            bindSubmitEvent();
        });
        
        // 챕터 순서 변경 후 이벤트 리바인딩
        function rebindEvents() {
            bindSubmitEvent();
        }

    </script>
</body>
</html>