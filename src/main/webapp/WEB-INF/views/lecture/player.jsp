<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>player</title>
        <link rel="stylesheet" href="../resources/css/lecture/player.css">
    </head>
    <body>
        <div class="main-container">
            <!-- Header -->
            <div class="header-bar">
                <div class="header-text">헤더</div>
            </div>

            <!-- Main Content Area -->
            <div class="content-area">
                <!-- Video Player Section -->
                <div class="video-section">
                    <h1 class="lesson-title">${currentVideo[0].videoOrder}. ${currentVideo[0].videoTitle}</h1>

                    <div class="video-player">
                        <video id="video-element" class="video-element" preload="metadata" onclick="togglePlay()">
                            <source src="/videos/lecture/${currentVideo[0].videoPath}" type="video/mp4">
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
                            <div class="ai-model-option selected" onclick="selectAiOption(this, 'AI에게 질문하기')">
                                AI에게 질문하기
                            </div>
                            <div class="ai-model-option" onclick="selectAiOption(this, '강사님에게 질문하기')">
                                강사님에게 질문하기
                            </div>
                        </div>
                    </div>

                    <div class="chat-messages" id="chat-messages">
                        <div class="message ai">
                            <div class="message-text">안녕하세요! 딥러닝 강의에 대해 궁금한 점이 있으시면 언제든 물어보세요.</div>
                        </div>
                    </div>

                    <div class="chat-input-section">
                        <span class="chat-input-label">채팅창</span>
                        <input
                                type="text"
                                class="chat-input"
                                placeholder="질문을 입력하세요..."
                                id="chat-input"
                                onkeypress="handleKeyPress(event)"/>
                        <button class="send-button" onclick="sendMessage()">전송</button>
                    </div>
                </div>
            </div>

            <!-- Footer -->
            <div class="footer-bar">
                <div class="footer-text">푸터</div>
            </div>
        </div>

        <script>
            let video = null;
            let isPlaying = false;
            let controlsTimeout = null;
            let videoPlayer = null;

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
                    // 사용자 메시지 추가
                    const userMessage = document.createElement("div");
                    userMessage.className = "message user";
                    userMessage.innerHTML = `<div class="message-text">${message}</div>`;
                    messages.appendChild(userMessage);

                    // AI 응답 시뮬레이션
                    setTimeout(() => {
                        const aiMessage = document.createElement("div");
                        aiMessage.className = "message ai";
                        aiMessage.innerHTML = `<div class="message-text">딥러닝에 대한 좋은 질문이네요! "${message}"에 대해 더 자세히 설명드리겠습니다.</div>`;
                        messages.appendChild(aiMessage);
                        messages.scrollTop = messages.scrollHeight;
                    }, 1000);

                    input.value = "";
                    messages.scrollTop = messages.scrollHeight;
                }
            }

            function handleKeyPress(event) {
                if (event.key === "Enter") {
                    sendMessage();
                }
            }

            function toggleAiDropdown() {
                const dropdown = document.querySelector(".ai-model-selector");
                dropdown.classList.toggle("open");
            }

            function selectAiOption(element, value) {
                // 이전 선택 제거
                document.querySelectorAll(".ai-model-option").forEach((option) => {
                    option.classList.remove("selected");
                });

                // 새로운 선택 표시
                element.classList.add("selected");

                // 선택된 값 업데이트
                document.querySelector(".ai-model-text").textContent = value;

                // 드롭다운 닫기
                document.querySelector(".ai-model-selector").classList.remove("open");

                // 채팅 메시지 초기화
                const chatMessages = document.getElementById("chat-messages");
                if (value === "AI에게 질문하기") {
                    chatMessages.innerHTML =
                        '<div class="message ai"><div class="message-text">안녕하세요! 딥러닝 강의에 대해 궁금한 점이 있으시면 언제든 물어보세요.</div></div>';
                } else {
                    chatMessages.innerHTML =
                        '<div class="message ai"><div class="message-text">안녕하세요! 강사입니다. 강의 내용에 대해 궁금한 점이 있으시면 언제든 질문해주세요.</div></div>';
                }
                chatMessages.scrollTop = chatMessages.scrollHeight;
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
