<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>강의 재생 - EduMate</title>
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
        <link rel="stylesheet" href="/resources/css/lecture/player.css">
    </head>
    <body>
        <div class="main-container">
            <!-- Header Include -->
            <jsp:include page="../common/header.jsp" />

            <!-- Main Content Area -->
            <div class="content-area">
                <!-- Video Player Section -->
                <div class="video-section">
                    <div class="video-player">
                        <h1 class="lesson-title">${currentVideo[0].videoOrder}. ${currentVideo[0].videoTitle}</h1>
                        <video id="video-element" class="video-element" preload="metadata" onclick="togglePlay()">
                            <source src="${currentVideo[0].videoPath}" type="video/mp4">
                            브라우저가 비디오를 지원하지 않습니다.
                        </video>
                        <div class="video-controls-custom">
                        <button class="control-btn play" id="play-btn" onclick="togglePlay()">▶</button>
                        <div class="progress-area">
                            <span class="time-display" id="current-time">00:00</span>
                            <div class="progress-bar" onclick="seekVideo(event)">
                                <div class="progress-fill" id="progress-fill"></div>
                            </div>
                            <span class="time-display" id="total-time">00:00</span>
                        </div>
                        <div class="speed-control-container">
                            <div class="speed-control" onclick="toggleSpeedDropdown()">
                                <span class="speed-text">1x</span>
                            </div>
                            <div class="speed-options">
                                <div class="speed-option" onclick="selectSpeed(this, '0.5')">0.5x</div>
                                <div class="speed-option selected" onclick="selectSpeed(this, '1')">1x</div>
                                <div class="speed-option" onclick="selectSpeed(this, '1.25')">1.25x</div>
                                <div class="speed-option" onclick="selectSpeed(this, '1.5')">1.5x</div>
                                <div class="speed-option" onclick="selectSpeed(this, '2')">2x</div>
                            </div>
                        </div>
                        <button class="control-btn" onclick="toggleFullscreen()">⛶</button>
                        </div>
                    </div>

                    <!-- Next Lecture Section -->
                    <c:if test="${not empty nextVideo}">
                        <div class="curriculum-item" onclick="location.href='/lecture/player?videoNo=${nextVideo[0].videoNo}'">
                            <div class="curriculum-icon"></div>
                            <div class="curriculum-content">
                                <div class="curriculum-lesson">${nextVideo[0].videoOrder}. ${nextVideo[0].videoTitle}</div>
                            </div>
                            <div class="curriculum-duration">${nextVideo[0].time}</div>
                        </div>
                    </c:if>
                </div>

                <!-- Chat Section -->
                <div class="chat-section">
                    <div class="ai-model-selector" onclick="toggleAiDropdown()">
                        <div class="ai-model-text">AI에게 질문하기</div>
                        <div class="ai-dropdown-arrow"></div>
                        <div class="ai-model-options">
                            <div class="ai-model-option selected" onclick="selectAiOption(this, 'AI에게 질문하기', event)">
                                AI에게 질문하기
                            </div>
                            <div class="ai-model-option" onclick="selectAiOption(this, '질문 게시판', event)">
                                질문 게시판
                            </div>
                        </div>
                    </div>

                    <div class="chat-messages" id="chat-messages">
                        <div class="message ai">
                            <div class="message-text">안녕하세요! ${lectureName} 강의에 대해 궁금한
                                점이 있으시면 언제든 물어보세요</div>
                        </div>
                    </div>

                    <div class="chat-input-section" id="ai-chat-input">
                        <textarea
                                class="chat-input"
                                placeholder="질문을 입력하세요..."
                                id="chat-input"
                                rows="3"
                                onkeypress="handleKeyPress(event)"></textarea>
                        <button class="send-button" onclick="sendMessage()">전송</button>
                    </div>

                    <!-- 강사님 질문 폼 영역 (숨김 상태) -->
                    <div class="instructor-question-container" id="instructor-question-container" style="display: none;">
                        <div class="instructor-form-wrapper">
                            <div class="instructor-header">
                                <h3 class="instructor-title">질문 게시판</h3>
                                <p class="instructor-subtitle">질문 제목과 내용을 입력해주세요.</p>
                            </div>
                            <form class="instructor-question-form" id="instructor-question-form" onsubmit="submitInstructorQuestion(event)">
                                <div class="instructor-field-group">
                                    <label class="instructor-label" for="instructor-question-title">질문 제목</label>
                                    <input class="instructor-input" type="text" id="instructor-question-title" name="title" placeholder="질문 제목을 입력하세요" required>
                                </div>
                                <div class="instructor-field-group">
                                    <label class="instructor-label" for="instructor-question-content">질문 내용</label>
                                    <textarea class="instructor-textarea" id="instructor-question-content" name="content" rows="6" placeholder="질문 내용을 자세히 입력하세요" required></textarea>
                                </div>
                                <input type="hidden" name="videoNo" value="${currentVideo[0].videoNo}">
                                <input type="hidden" name="lectureNo" value="${currentVideo[0].lectureNo}">
                                <div class="instructor-button-group">
                                    <button type="submit" class="instructor-submit-button">질문 등록</button>
                                    <button type="button" class="instructor-cancel-button" onclick="resetInstructorForm()">취소</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        
        <!-- Footer Include -->
        <jsp:include page="../common/footer.jsp" />

        <script>
            let video = null;
            let isPlaying = false;
            let controlsTimeout = null;
            let videoPlayer = null;
            let lastUserQuestion = ""; // 마지막 질문 저장

            function togglePlay() {
                const video = document.getElementById('video-element');
                const playBtn = document.getElementById('play-btn');
                const videoPlayer = document.querySelector('.video-player');
                
                if (video.paused) {
                    video.play();
                    playBtn.innerHTML = '||';
                    videoPlayer.classList.add('playing');
                    hideControlsAfterDelay();
                } else {
                    video.pause();
                    playBtn.innerHTML = '▶';
                    videoPlayer.classList.remove('playing');
                    showControls();
                }
            }

            function showControls() {
                const videoPlayer = document.querySelector('.video-player');
                videoPlayer.classList.remove('hide-controls');
                clearTimeout(controlsTimeout);
            }

            function hideControlsAfterDelay() {
                const video = document.getElementById('video-element');
                const videoPlayer = document.querySelector('.video-player');
                
                clearTimeout(controlsTimeout);
                if (!video.paused) {
                    controlsTimeout = setTimeout(() => {
                        videoPlayer.classList.add('hide-controls');
                    }, 3000); // 3초 후 숨김
                }
            }

            function handleMouseMove() {
                showControls();
                hideControlsAfterDelay();
            }

            function seekVideo(event) {
                const video = document.getElementById('video-element');
                const progressBar = event.currentTarget;
                const rect = progressBar.getBoundingClientRect();
                const clickX = event.clientX - rect.left;
                const percentage = (clickX / rect.width);
                
                video.currentTime = percentage * video.duration;
            }

            function changeSpeed(speed) {
                const video = document.getElementById('video-element');
                video.playbackRate = parseFloat(speed);
            }

            function toggleSpeedDropdown() {
                const container = document.querySelector('.speed-control-container');
                container.classList.toggle('open');
            }

            function selectSpeed(element, speed) {
                // 이전 선택 제거
                document.querySelectorAll('.speed-option').forEach(option => {
                    option.classList.remove('selected');
                });
                
                // 새로운 선택 표시
                element.classList.add('selected');
                
                // 속도 변경
                changeSpeed(speed);
                
                // 표시 텍스트 업데이트
                document.querySelector('.speed-text').textContent = speed + 'x';
                
                // 드롭다운 닫기
                document.querySelector('.speed-control-container').classList.remove('open');
            }

            function toggleFullscreen() {
                const videoPlayer = document.querySelector('.video-player');
                if (document.fullscreenElement) {
                    document.exitFullscreen();
                } else {
                    if (videoPlayer.requestFullscreen) {
                        videoPlayer.requestFullscreen();
                    } else if (videoPlayer.webkitRequestFullscreen) {
                        videoPlayer.webkitRequestFullscreen();
                    } else if (videoPlayer.msRequestFullscreen) {
                        videoPlayer.msRequestFullscreen();
                    }
                }
            }

            function formatTime(seconds) {
                if (isNaN(seconds) || seconds < 0) {
                    return '00:00';
                }
                const minutes = Math.floor(seconds / 60);
                const remainingSeconds = Math.floor(seconds % 60);
                
                const paddedMinutes = minutes < 10 ? '0' + minutes : minutes;
                const paddedSeconds = remainingSeconds < 10 ? '0' + remainingSeconds : remainingSeconds;
                
                return paddedMinutes + ':' + paddedSeconds;
            }

            function updateProgress() {
                const video = document.getElementById('video-element');
                const progressFill = document.getElementById('progress-fill');
                const currentTime = document.getElementById('current-time');
                const totalTime = document.getElementById('total-time');
                
                if (video.duration && !isNaN(video.duration)) {
                    const percentage = (video.currentTime / video.duration) * 100;
                    progressFill.style.width = percentage + '%';
                    currentTime.textContent = formatTime(video.currentTime);
                    totalTime.textContent = formatTime(video.duration);
                } else {
                    currentTime.textContent = '00:00';
                    totalTime.textContent = '00:00';
                }
            }

            function sendMessage() {
                const input = document.getElementById("chat-input");
                const messages = document.getElementById("chat-messages");
                const message = input.value.trim();

                if (message) {
                    // 마지막 질문 저장
                    lastUserQuestion = message;
                    
                    // 사용자 메시지 추가
                    const userMessage = document.createElement("div");
                    userMessage.className = "message user";
                    userMessage.innerHTML = '<div class="message-text">' + message + '</div>';
                    messages.appendChild(userMessage);

                    input.value = "";
                    messages.scrollTop = messages.scrollHeight;

                    // 선택된 옵션 확인
                    const selectedOption = document.querySelector(".ai-model-option.selected");
                    const selectedOptionText = selectedOption ? selectedOption.textContent.trim() : "AI에게 질문하기";

                    // AI에게 질문하기가 선택된 경우에만 API 호출
                    if (selectedOptionText === "AI에게 질문하기") {
                        // 로딩 메시지 추가
                        const loadingMessage = document.createElement("div");
                        loadingMessage.className = "message ai";
                        loadingMessage.innerHTML = '<div class="message-text">답변을 생성중입니다...</div>';
                        messages.appendChild(loadingMessage);
                        messages.scrollTop = messages.scrollHeight;

                        // API 호출
                        fetch('/api/chat/send', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                            },
                            body: JSON.stringify({
                                message: message,
                                detailed: "false"
                            })
                        })
                        .then(response => response.json())
                        .then(data => {
                            // 로딩 메시지 제거
                            if (loadingMessage && loadingMessage.parentNode) {
                                messages.removeChild(loadingMessage);
                            }
                            
                            // AI 응답 추가
                            const aiMessage = document.createElement("div");
                            aiMessage.className = "message ai";
                            
                            if (data.success) {
                                // 마크다운 문법 제거하여 깔끔하게 표시
                                const cleanResponse = data.response
                                    .replace(/\*\*(.*?)\*\*/g, '$1')  // **텍스트** -> 텍스트
                                    .replace(/\*(.*?)\*/g, '$1')      // *텍스트* -> 텍스트
                                    .replace(/`(.*?)`/g, '$1')        // `코드` -> 코드
                                    .replace(/#+ (.+)/g, '$1')        // # 제목 -> 제목
                                    .replace(/\n/g, '<br>');          // 줄바꿈 처리
                                aiMessage.innerHTML = '<div class="message-text">' + cleanResponse + '</div>';
                            } else {
                                aiMessage.innerHTML = '<div class="message-text">답변을 생성하는데 문제가 발생했습니다. 다시 시도해주세요.</div>';
                            }
                            
                            messages.appendChild(aiMessage);
                            
                            // 자세히 버튼을 메시지 영역에 추가
                            const detailButtonContainer = document.createElement("div");
                            detailButtonContainer.className = "detail-button-container";
                            detailButtonContainer.innerHTML = '<button class="detail-button-chat" onclick="sendDetailedAnswer()">자세히</button>';
                            messages.appendChild(detailButtonContainer);
                            
                            messages.scrollTop = messages.scrollHeight;
                        })
                        .catch(error => {
                            console.error('API 호출 오류:', error);
                            // 로딩 메시지 제거
                            if (loadingMessage && loadingMessage.parentNode) {
                                messages.removeChild(loadingMessage);
                            }
                            
                            // 에러 메시지 추가
                            const errorMessage = document.createElement("div");
                            errorMessage.className = "message ai";
                            errorMessage.innerHTML = '<div class="message-text">네트워크 연결에 문제가 있습니다. 잠시 후 다시 시도해주세요.</div>';
                            messages.appendChild(errorMessage);
                            messages.scrollTop = messages.scrollHeight;
                        });
                    } else {
                        // 질문 게시판 - 기존 시뮬레이션 응답
                        setTimeout(() => {
                            const aiMessage = document.createElement("div");
                            aiMessage.className = "message ai";
                            aiMessage.innerHTML = '<div class="message-text">질문이 전달되었습니다. 강사님이 답변드릴 예정입니다.</div>';
                            messages.appendChild(aiMessage);
                            messages.scrollTop = messages.scrollHeight;
                        }, 1000);
                    }
                }
            }

            function handleKeyPress(event) {
                if (event.key === "Enter" && !event.shiftKey) {
                    event.preventDefault();
                    sendMessage();
                }
            }

            function sendDetailedAnswer() {
                if (!lastUserQuestion) return;
                
                const messages = document.getElementById("chat-messages");
                
                // 로딩 메시지 추가
                const loadingMessage = document.createElement("div");
                loadingMessage.className = "message ai";
                loadingMessage.innerHTML = '<div class="message-text">자세한 답변을 생성중입니다...</div>';
                messages.appendChild(loadingMessage);
                messages.scrollTop = messages.scrollHeight;
                
                // 자세히 버튼 제거
                const detailButtonContainer = document.querySelector(".detail-button-container");
                if (detailButtonContainer) {
                    detailButtonContainer.remove();
                }

                // API 호출 (자세한 답변)
                fetch('/api/chat/send', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        message: lastUserQuestion,
                        detailed: "true"
                    })
                })
                .then(response => response.json())
                .then(data => {
                    // 로딩 메시지 제거
                    if (loadingMessage && loadingMessage.parentNode) {
                        messages.removeChild(loadingMessage);
                    }
                    
                    // AI 자세한 응답 추가
                    const aiMessage = document.createElement("div");
                    aiMessage.className = "message ai";
                    
                    if (data.success) {
                        // 마크다운 문법 제거하여 깔끔하게 표시
                        const cleanResponse = data.response
                            .replace(/\*\*(.*?)\*\*/g, '$1')  // **텍스트** -> 텍스트
                            .replace(/\*(.*?)\*/g, '$1')      // *텍스트* -> 텍스트
                            .replace(/`(.*?)`/g, '$1')        // `코드` -> 코드
                            .replace(/#+ (.+)/g, '$1')        // # 제목 -> 제목
                            .replace(/\n/g, '<br>');          // 줄바꿈 처리
                        aiMessage.innerHTML = '<div class="message-text">' + cleanResponse + '</div>';
                    } else {
                        aiMessage.innerHTML = '<div class="message-text">자세한 답변을 생성하는데 문제가 발생했습니다.</div>';
                    }
                    
                    messages.appendChild(aiMessage);
                    messages.scrollTop = messages.scrollHeight;
                })
                .catch(error => {
                    console.error('API 호출 오류:', error);
                    // 로딩 메시지 제거
                    if (loadingMessage && loadingMessage.parentNode) {
                        messages.removeChild(loadingMessage);
                    }
                    
                    // 에러 메시지 추가
                    const errorMessage = document.createElement("div");
                    errorMessage.className = "message ai";
                    errorMessage.innerHTML = '<div class="message-text">네트워크 연결에 문제가 있습니다.</div>';
                    messages.appendChild(errorMessage);
                    messages.scrollTop = messages.scrollHeight;
                });
            }

            function toggleAiDropdown() {
                const dropdown = document.querySelector(".ai-model-selector");
                dropdown.classList.toggle("open");
            }

            function selectAiOption(element, value, event) {
                // 이벤트 전파 방지
                if (event) {
                    event.stopPropagation();
                }
                
                console.log("selectAiOption 호출됨:", value);
                
                // 이전 선택 제거
                document.querySelectorAll(".ai-model-option").forEach((option) => {
                    option.classList.remove("selected");
                });

                // 새로운 선택 표시
                element.classList.add("selected");

                // 선택된 값 업데이트
                document.querySelector(".ai-model-text").textContent = value;

                // 드롭다운 닫기 (강제로 open 클래스 제거)
                const dropdown = document.querySelector(".ai-model-selector");
                if (dropdown) {
                    dropdown.classList.remove("open");
                    // 추가적으로 강제 닫기
                    setTimeout(() => {
                        dropdown.classList.remove("open");
                    }, 10);
                }

                // 영역 전환
                const chatMessages = document.getElementById("chat-messages");
                const aiChatInput = document.getElementById("ai-chat-input");
                const instructorContainer = document.getElementById("instructor-question-container");

                if (value === "AI에게 질문하기") {
                    // AI 채팅 영역 표시
                    chatMessages.style.display = "block";
                    aiChatInput.style.display = "flex";
                    instructorContainer.style.display = "none";
                    
                    // AI 채팅 메시지 초기화
                    chatMessages.innerHTML = '<div class="message ai"><div class="message-text">안녕하세요! ${lectureName} 강의에 대해 궁금한 점이 있으시면 언제든 물어보세요</div></div>';
                    chatMessages.scrollTop = chatMessages.scrollHeight;
                } else if (value === "질문 게시판") {
                    // 강사님 질문 폼 표시
                    chatMessages.style.display = "none";
                    aiChatInput.style.display = "none";
                    instructorContainer.style.display = "block";
                    
                    // 강사님 질문 폼 초기화
                    resetInstructorForm();
                }
            }

            function submitInstructorQuestion(event) {
                event.preventDefault();
                
                const form = event.target;
                const formData = new FormData(form);
                
                const questionData = {
                    title: formData.get('title'),
                    content: formData.get('content'),
                    videoNo: formData.get('videoNo'),
                    lectureNo: formData.get('lectureNo')
                };

                // 질문 등록 API 호출
                fetch('/api/chat/teacher', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(questionData)
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert('질문이 성공적으로 등록되었습니다. 강사님이 답변해드릴 예정입니다.');
                        resetInstructorForm();
                    } else {
                        alert('질문 등록에 실패했습니다. 다시 시도해주세요.');
                    }
                })
                .catch(error => {
                    console.error('질문 등록 오류:', error);
                    alert('네트워크 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                });
            }

            function resetInstructorForm() {
                const form = document.getElementById('instructor-question-form');
                if (form) {
                    form.reset();
                }
            }

            // 외부 클릭 시 드롭다운 닫기
            document.addEventListener("click", function (event) {
                const aiDropdown = document.querySelector(".ai-model-selector");
                if (!aiDropdown.contains(event.target)) {
                    aiDropdown.classList.remove("open");
                }
                
                const speedDropdown = document.querySelector(".speed-control-container");
                if (!speedDropdown.contains(event.target)) {
                    speedDropdown.classList.remove("open");
                }
            });

            // 페이지 로드 시 초기화
            document.addEventListener("DOMContentLoaded", function () {
                const chatMessages = document.getElementById("chat-messages");
                chatMessages.scrollTop = chatMessages.scrollHeight;
                
                // 비디오 이벤트 리스너 설정
                const video = document.getElementById('video-element');
                video.addEventListener('timeupdate', updateProgress);
                video.addEventListener('loadedmetadata', updateProgress);
                video.addEventListener('durationchange', updateProgress);
                video.addEventListener('canplay', updateProgress);
                video.addEventListener('ended', function() {
                    const playBtn = document.getElementById('play-btn');
                    const videoPlayer = document.querySelector('.video-player');
                    playBtn.innerHTML = '▶';
                    videoPlayer.classList.remove('playing');
                    showControls();
                });
                
                // 비디오 플레이어에 마우스 이벤트 리스너 추가
                const videoPlayer = document.querySelector('.video-player');
                videoPlayer.addEventListener('mousemove', handleMouseMove);
                videoPlayer.addEventListener('mouseenter', showControls);
                videoPlayer.addEventListener('mouseleave', () => {
                    if (!video.paused) {
                        hideControlsAfterDelay();
                    }
                });
                
                // 비디오 로드 시도
                video.load();
            });
        </script>
    </body>
</html>
