<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
                    <h1 class="lesson-title">1. [개념] 빠르게 이해하는 딥러닝 개요</h1>

                    <div class="video-player">
                        <video id="video-element" class="video-element" preload="metadata">
                            <source src="/videos/lecture/123.mp4" type="video/mp4">
                            브라우저가 비디오를 지원하지 않습니다.
                        </video>
                        <div class="video-controls-custom">
                        <button class="control-btn play" id="play-btn" onclick="togglePlay()">▶️ 재생</button>
                        <div class="progress-area">
                            <span class="time-display" id="current-time">00:00</span>
                            <div class="progress-bar" onclick="seekVideo(event)">
                                <div class="progress-fill" id="progress-fill"></div>
                            </div>
                            <span class="time-display" id="total-time">00:00</span>
                        </div>
                        <select class="speed-control" onchange="changeSpeed(this.value)">
                            <option value="0.5">0.5x</option>
                            <option value="1" selected>1x</option>
                            <option value="1.25">1.25x</option>
                            <option value="1.5">1.5x</option>
                            <option value="2">2x</option>
                        </select>
                        <button class="control-btn" onclick="toggleFullscreen()">⛶</button>
                        </div>
                    </div>

                    <!-- Next Lecture Section -->
                    <div class="curriculum-item" onclick="goToNextLecture()">
                        <div class="curriculum-icon"></div>
                        <div class="curriculum-content">
                            <div class="curriculum-lesson">2. [실습] 딥러닝 환경 설정하기</div>
                        </div>
                        <div class="curriculum-duration">15분</div>
                    </div>
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

            function togglePlay() {
                const video = document.getElementById('video-element');
                const playBtn = document.getElementById('play-btn');
                
                if (video.paused) {
                    video.play();
                    playBtn.textContent = '⏸️ 일시정지';
                    playBtn.style.background = '#ef4444';
                } else {
                    video.pause();
                    playBtn.textContent = '▶️ 재생';
                    playBtn.style.background = '#4f46e5';
                }
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

            function goToNextLecture() {
                // 다음 강의로 이동하는 로직
                alert('다음 강의로 이동합니다.');
                // window.location.href = '/lecture/player?videoNo=3';
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
                const dropdown = document.querySelector(".ai-model-selector");
                if (!dropdown.contains(event.target)) {
                    dropdown.classList.remove("open");
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
                    playBtn.textContent = '▶️ 재생';
                    playBtn.style.background = '#4f46e5';
                });
                
                // 비디오 로드 시도
                video.load();
            });
        </script>
    </body>
</html>
