<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>강의 등록 - EduMate</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/common/footer.css">
    <link rel="stylesheet" href="/resources/css/lecture/add.css">
</head>
<body>
    <div class="main-container">
        <!-- Header Include -->
        <jsp:include page="../common/header.jsp" />
        
        <!-- Main Content -->
        <div class="content-wrapper">
            <h1 class="page-title">강의 등록</h1>
            
            <div class="form-container">
                <form id="lectureForm" action="/lecture/add" method="post" enctype="multipart/form-data">
                    <!-- 상단: 강의 기본정보 섹션 -->
                    <div class="basic-info-section">
                        <!-- 강의명 -->
                        <div class="form-group">
                            <label class="form-label" for="lectureName">강의명</label>
                            <input type="text" id="lectureName" name="lectureName" class="form-input" 
                                   placeholder="강의 제목을 입력해주세요" required>
                        </div>
                        
                        <!-- 카테고리와 가격을 한 줄에 배치 -->
                        <div class="form-group-row">
                            <!-- 카테고리 -->
                            <div class="form-group-half">
                                <label class="form-label-small" for="lectureCategory">카테고리</label>
                                <select id="lectureCategory" name="lectureCategory" class="form-input-small" required>
                                    <option value="">카테고리를 선택해주세요</option>
                                    <option value="프로그래밍">프로그래밍</option>
                                    <option value="디자인">디자인</option>
                                    <option value="데이터분석">데이터분석</option>
                                    <option value="비즈니스">비즈니스</option>
                                    <option value="언어">언어</option>
                                </select>
                            </div>
                            
                            <!-- 가격 -->
                            <div class="form-group-half">
                                <label class="form-label-small" for="lecturePrice">가격</label>
                                <div class="price-group-small">
                                    <span class="price-symbol-small">₩</span>
                                    <input type="number" id="lecturePrice" name="lecturePrice" class="form-input-small" 
                                           placeholder="가격을 입력해주세요" min="0" required>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 강의 설명 -->
                        <div class="form-group">
                            <label class="form-label" for="lectureDescription">강의 설명</label>
                            <textarea id="lectureDescription" name="lectureDescription" class="form-input" 
                                      style="height: 120px; resize: none; padding-top: 10px;" 
                                      placeholder="강의에 대한 자세한 설명을 입력해주세요" required></textarea>
                        </div>
                    </div>
                    
                    <!-- 하단: 파일 업로드 섹션 -->
                    <div class="upload-section">
                        <label class="form-label">파일 업로드</label>
                        <div class="videos-container">
                            <!-- 좌측: 썸네일 업로드 + 미리보기 섹션 -->
                            <div class="thumbnail-section">
                                <!-- 썸네일 이미지 업로드 -->
                                <div class="upload-section-title">썸네일 이미지</div>
                                <div class="video-item">
                                    <div class="video-order">📷</div>
                                    <div class="video-upload-section">
                                        <div class="video-upload-area" onclick="document.getElementById('thumbnailImage').click()">
                                            <div class="video-upload-text">썸네일 선택</div>
                                        </div>
                                        <input type="file" id="thumbnailImage" name="thumbnailImage" class="hidden" 
                                               accept="image/*" onchange="handleThumbnailUpload(this)" required>
                                    </div>
                                </div>
                                
                                <!-- 썸네일 미리보기 -->
                                <div class="videos-preview-title" style="margin-top: 20px;">썸네일 미리보기</div>
                                <div class="thumbnail-large-preview" id="thumbnailLargePreview">
                                    <div class="thumbnail-placeholder">
                                        썸네일 이미지를 선택하면<br>여기에 표시됩니다
                                    </div>
                                    <img id="thumbnailPreviewImage" class="thumbnail-preview-large" alt="썸네일 미리보기" style="display: none;">
                                </div>
                            </div>
                            
                            <!-- 우측: 영상 업로드 섹션 -->
                            <div class="videos-upload-section">
                                <!-- 강의 영상들 -->
                                <div class="upload-section-title">강의 영상</div>
                                <div class="videos-list" id="videosList">
                                    <!-- 첫 번째 비디오 항목 -->
                                    <div class="video-item" data-video-index="1">
                                        <div class="video-order">1</div>
                                        <div class="video-content">
                                            <div class="video-title-section">
                                                <input type="text" name="videoTitles[]" class="video-title-input" 
                                                       placeholder="강좌명을 입력해주세요" required>
                                            </div>
                                            <div class="video-upload-section">
                                                <div class="video-upload-area" onclick="this.parentElement.querySelector('input[type=file]').click()">
                                                    <div class="video-upload-text">영상 선택</div>
                                                </div>
                                                <input type="file" name="lectureVideos[]" class="hidden" 
                                                       accept="video/*" onchange="handleVideoUpload(this, 1)" required>
                                            </div>
                                        </div>
                                        <button type="button" class="remove-video-btn" onclick="removeVideoItem(this)" 
                                                style="display: none;">×</button>
                                    </div>
                                </div>
                                
                                <button type="button" class="add-video-btn" onclick="addVideoSection()">
                                    <span>+</span> 영상 추가
                                </button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 등록 버튼 -->
                    <div class="submit-container">
                        <button type="submit" class="submit-btn">강의 등록</button>
                    </div>
                </form>
            </div>
        </div>
        
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />
    </div>

    <script>
        let videoCount = 1;

        // 썸네일 업로드 처리
        function handleThumbnailUpload(input) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    // 업로드 영역 업데이트 - 파일명 표시
                    const uploadArea = input.parentElement.querySelector('.video-upload-area');
                    const uploadText = uploadArea.querySelector('.video-upload-text');
                    
                    uploadText.textContent = file.name;
                    uploadArea.classList.add('has-file');
                    
                    // 대형 미리보기 표시
                    const previewContainer = document.getElementById('thumbnailLargePreview');
                    const placeholder = previewContainer.querySelector('.thumbnail-placeholder');
                    const previewImage = document.getElementById('thumbnailPreviewImage');
                    
                    previewImage.src = e.target.result;
                    placeholder.style.display = 'none';
                    previewImage.style.display = 'block';
                    previewContainer.classList.add('has-image');
                };
                
                reader.readAsDataURL(file);
            }
        }
        
        // 비디오 업로드 트리거 (사용하지 않음 - 인라인 onclick 사용)
        
        // 비디오 업로드 처리
        function handleVideoUpload(input, index) {
            if (input.files && input.files[0]) {
                const file = input.files[0];
                
                // input의 부모 요소들을 통해 안전하게 찾기
                const videoItem = input.closest('.video-item');
                if (!videoItem) {
                    console.error('video-item을 찾을 수 없습니다.');
                    return;
                }
                
                const uploadArea = videoItem.querySelector('.video-upload-area');
                const uploadText = uploadArea.querySelector('.video-upload-text');
                
                if (!uploadArea || !uploadText) {
                    console.error('업로드 영역을 찾을 수 없습니다.');
                    return;
                }
                
                // 파일명 표시
                uploadText.textContent = file.name;
                uploadArea.classList.add('has-file');
                
                // 첫 번째 비디오가 아니면 삭제 버튼 표시
                if (index > 1) {
                    const removeBtn = videoItem.querySelector('.remove-video-btn');
                    if (removeBtn) {
                        removeBtn.style.display = 'flex';
                    }
                }
            }
        }
        
        // 비디오 미리보기 관련 함수들 제거됨
        
        // 새 비디오 섹션 추가
        function addVideoSection() {
            videoCount++;
            console.log('Adding video section, videoCount:', videoCount);
            const videosList = document.getElementById('videosList');
            
            const newVideoItem = document.createElement('div');
            newVideoItem.className = 'video-item';
            newVideoItem.setAttribute('data-video-index', videoCount);
            
            newVideoItem.innerHTML = `
                <div class="video-order">${videoCount}</div>
                <div class="video-content">
                    <div class="video-title-section">
                        <input type="text" name="videoTitles[]" class="video-title-input" 
                               placeholder="강좌명을 입력해주세요" required>
                    </div>
                    <div class="video-upload-section">
                        <div class="video-upload-area" onclick="this.parentElement.querySelector('input[type=file]').click()">
                            <div class="video-upload-text">영상 선택</div>
                        </div>
                        <input type="file" name="lectureVideos[]" class="hidden" 
                               accept="video/*" onchange="handleVideoUpload(this, ${videoCount})" required>
                    </div>
                </div>
                <button type="button" class="remove-video-btn" onclick="removeVideoItem(this)">×</button>
            `;
            
            console.log('New video item created with order:', videoCount);
            videosList.appendChild(newVideoItem);
            
            // DOM에 추가된 후 즉시 스타일과 내용 강제 적용
            setTimeout(() => {
                const addedElement = videosList.lastElementChild;
                const orderElement = addedElement.querySelector('.video-order');
                if (orderElement) {
                    // 스타일 강제 적용
                    orderElement.style.cssText = `
                        background: #333 !important;
                        color: white !important;
                        width: 30px !important;
                        height: 30px !important;
                        border-radius: 50% !important;
                        display: flex !important;
                        align-items: center !important;
                        justify-content: center !important;
                        font-weight: bold !important;
                        font-size: 12px !important;
                        flex-shrink: 0 !important;
                    `;
                    orderElement.textContent = videoCount;
                    console.log('Forced style applied to order element:', orderElement.textContent);
                    
                    // 화면 갱신 강제
                    orderElement.offsetHeight;
                }
            }, 50);
            
            // 모든 비디오 아이템에 삭제 버튼 표시 (첫 번째 제외)
            updateRemoveButtons();
        }
        
        // 비디오 섹션 제거 (새로운 함수)
        function removeVideoItem(button) {
            const videoItems = document.querySelectorAll('.video-item');
            if (videoItems.length <= 1) return; // 최소 1개는 유지
            
            const videoItem = button.closest('.video-item');
            if (videoItem) {
                videoItem.remove();
                
                // 순서 번호 재정렬
                reorderVideoItems();
                updateRemoveButtons();
            }
        }
        
        // 비디오 섹션 제거 (기존 함수 - 호환성 유지)
        function removeVideo(index) {
            if (videoCount <= 1) return; // 최소 1개는 유지
            
            const videoItem = document.querySelector(`[data-video-index="${index}"]`);
            if (videoItem) {
                videoItem.remove();
                
                // 순서 번호 재정렬
                reorderVideoItems();
                updateRemoveButtons();
            } else {
                console.error(`비디오 아이템을 찾을 수 없습니다. index: ${index}`);
            }
        }
        
        // 비디오 아이템 순서 재정렬
        function reorderVideoItems() {
            const videosList = document.getElementById('videosList');
            const videoItems = videosList.querySelectorAll('.video-item');
            console.log('Reordering videos, found:', videoItems.length);
            
            videoItems.forEach((item, index) => {
                const newIndex = index + 1;
                console.log(`Reordering item ${index} to ${newIndex}`);
                
                // data-video-index 업데이트
                item.setAttribute('data-video-index', newIndex);
                
                // 순서 번호 업데이트
                const orderElement = item.querySelector('.video-order');
                if (orderElement) {
                    // 스타일 강제 적용
                    orderElement.style.cssText = `
                        background: #333 !important;
                        color: white !important;
                        width: 30px !important;
                        height: 30px !important;
                        border-radius: 50% !important;
                        display: flex !important;
                        align-items: center !important;
                        justify-content: center !important;
                        font-weight: bold !important;
                        font-size: 12px !important;
                        flex-shrink: 0 !important;
                    `;
                    orderElement.textContent = newIndex;
                    console.log(`Set order element text to: ${newIndex}`);
                    
                    // 화면 갱신 강제
                    orderElement.offsetHeight;
                } else {
                    console.error('Order element not found for item:', item);
                }
                
                // 파일 입력 onchange 핸들러 업데이트
                const fileInput = item.querySelector('input[type="file"]');
                if (fileInput) {
                    fileInput.setAttribute('onchange', `handleVideoUpload(this, ${newIndex})`);
                }
            });
            
            // videoCount 업데이트
            videoCount = videoItems.length;
            console.log('Updated videoCount to:', videoCount);
        }
        
        // 삭제 버튼 표시 업데이트
        function updateRemoveButtons() {
            const videosList = document.getElementById('videosList');
            const videoItems = videosList.querySelectorAll('.video-item');
            
            videoItems.forEach((item, index) => {
                const removeBtn = item.querySelector('.remove-video-btn');
                if (removeBtn) { // removeBtn이 존재하는지 확인
                    if (videoItems.length > 1) {
                        removeBtn.style.display = 'flex';
                    } else {
                        removeBtn.style.display = 'none';
                    }
                }
            });
        }
        
        // 페이지 로드 시 초기화
        document.addEventListener('DOMContentLoaded', function() {
            // 첫 번째 비디오 아이템의 순서 번호 스타일 강제 적용
            const firstVideoItem = document.querySelector('.video-item[data-video-index="1"]');
            if (firstVideoItem) {
                const orderElement = firstVideoItem.querySelector('.video-order');
                if (orderElement) {
                    orderElement.style.cssText = `
                        background: #333 !important;
                        color: white !important;
                        width: 30px !important;
                        height: 30px !important;
                        border-radius: 50% !important;
                        display: flex !important;
                        align-items: center !important;
                        justify-content: center !important;
                        font-weight: bold !important;
                        font-size: 12px !important;
                        flex-shrink: 0 !important;
                    `;
                    orderElement.textContent = '1';
                    console.log('Initial style applied to first video order element');
                }
            }
        });

        // 폼 제출 시 로딩 표시만
        document.getElementById('lectureForm').addEventListener('submit', function(e) {
            const submitBtn = document.querySelector('.submit-btn');
            submitBtn.disabled = true;
            submitBtn.textContent = '업로드 중...';
        });
    </script>
</body>
</html>