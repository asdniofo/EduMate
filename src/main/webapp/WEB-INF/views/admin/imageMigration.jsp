<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>이미지 Cloudflare 마이그레이션 - EduMate</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        
        .warning-box {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        
        .migration-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #fafafa;
        }
        
        .migration-section h3 {
            margin-top: 0;
            color: #555;
        }
        
        .migration-section p {
            color: #666;
            margin-bottom: 15px;
        }
        
        .btn {
            background-color: #007bff;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 10px;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #0056b3;
        }
        
        .btn:disabled {
            background-color: #6c757d;
            cursor: not-allowed;
        }
        
        .btn-danger {
            background-color: #dc3545;
        }
        
        .btn-danger:hover {
            background-color: #c82333;
        }
        
        .btn-success {
            background-color: #28a745;
        }
        
        .btn-success:hover {
            background-color: #218838;
        }
        
        .progress-bar {
            width: 100%;
            height: 20px;
            background-color: #e0e0e0;
            border-radius: 10px;
            overflow: hidden;
            margin: 10px 0;
            display: none;
        }
        
        .progress-fill {
            height: 100%;
            background-color: #28a745;
            width: 0%;
            transition: width 0.3s;
        }
        
        .log-area {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            padding: 15px;
            height: 200px;
            overflow-y: auto;
            font-family: 'Courier New', monospace;
            font-size: 12px;
            margin-top: 20px;
            display: none;
        }
        
        .status-message {
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            display: none;
        }
        
        .status-success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }
        
        .status-error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        
        .status-info {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>이미지 Cloudflare 마이그레이션</h1>
        
        <div class="warning-box">
            <strong>⚠️ 주의사항:</strong>
            <ul>
                <li>이 작업은 데이터베이스의 이미지 URL을 Cloudflare R2 URL로 변경합니다.</li>
                <li>마이그레이션 중에는 서비스가 일시적으로 영향을 받을 수 있습니다.</li>
                <li>작업 전에 데이터베이스 백업을 권장합니다.</li>
            </ul>
        </div>
        
        <div class="migration-section">
            <h3>🎯 전체 마이그레이션</h3>
            <p>모든 이미지와 파일을 한번에 Cloudflare R2로 마이그레이션합니다.</p>
            <button class="btn btn-danger" onclick="migrateAll()" id="migrateAllBtn">
                전체 마이그레이션 시작
            </button>
        </div>
        
        <div class="migration-section">
            <h3>🎓 강의 이미지 마이그레이션</h3>
            <p>강의 썸네일 이미지를 Cloudflare R2로 마이그레이션합니다.</p>
            <button class="btn" onclick="migrateLectures()" id="migrateLecturesBtn">
                강의 이미지 마이그레이션
            </button>
        </div>
        
        <div class="migration-section">
            <h3>🎉 이벤트 이미지 마이그레이션</h3>
            <p>이벤트 메인 이미지, 썸네일, 콘텐츠 이미지를 마이그레이션합니다.</p>
            <button class="btn" onclick="migrateEvents()" id="migrateEventsBtn">
                이벤트 이미지 마이그레이션
            </button>
        </div>
        
        <div class="migration-section">
            <h3>🎬 비디오 파일 마이그레이션</h3>
            <p>강의 비디오 파일을 Cloudflare R2로 마이그레이션합니다.</p>
            <button class="btn" onclick="migrateVideos()" id="migrateVideosBtn">
                비디오 파일 마이그레이션
            </button>
        </div>
        
        <div class="migration-section">
            <h3>📎 아카이브 첨부파일 마이그레이션</h3>
            <p>아카이브 게시판의 첨부파일을 마이그레이션합니다.</p>
            <button class="btn" onclick="migrateArchives()" id="migrateArchivesBtn">
                아카이브 첨부파일 마이그레이션
            </button>
        </div>
        
        <div class="progress-bar" id="progressBar">
            <div class="progress-fill" id="progressFill"></div>
        </div>
        
        <div class="status-message" id="statusMessage"></div>
        
        <div class="log-area" id="logArea"></div>
    </div>

    <script>
        function showProgress() {
            document.getElementById('progressBar').style.display = 'block';
            document.getElementById('logArea').style.display = 'block';
        }
        
        function hideProgress() {
            document.getElementById('progressBar').style.display = 'none';
        }
        
        function updateProgress(percentage) {
            document.getElementById('progressFill').style.width = percentage + '%';
        }
        
        function showStatus(message, type) {
            const statusDiv = document.getElementById('statusMessage');
            statusDiv.className = 'status-message status-' + type;
            statusDiv.textContent = message;
            statusDiv.style.display = 'block';
        }
        
        function addLog(message) {
            const logArea = document.getElementById('logArea');
            const timestamp = new Date().toLocaleTimeString();
            logArea.innerHTML += '[' + timestamp + '] ' + message + '\n';
            logArea.scrollTop = logArea.scrollHeight;
        }
        
        function disableAllButtons() {
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(btn => btn.disabled = true);
        }
        
        function enableAllButtons() {
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach(btn => btn.disabled = false);
        }
        
        async function migrateAll() {
            if (!confirm('모든 이미지를 마이그레이션하시겠습니까? 이 작업은 시간이 오래 걸릴 수 있습니다.')) {
                return;
            }
            
            showProgress();
            disableAllButtons();
            addLog('전체 마이그레이션을 시작합니다...');
            updateProgress(10);
            
            try {
                const response = await fetch('/admin/migration/migrate-all', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                });
                
                const result = await response.json();
                
                if (result.success) {
                    updateProgress(100);
                    showStatus(result.message, 'success');
                    addLog('전체 마이그레이션이 완료되었습니다.');
                } else {
                    showStatus(result.message, 'error');
                    addLog('마이그레이션 실패: ' + result.message);
                }
            } catch (error) {
                showStatus('마이그레이션 중 오류가 발생했습니다.', 'error');
                addLog('오류: ' + error.message);
            } finally {
                enableAllButtons();
            }
        }
        
        async function migrateLectures() {
            if (!confirm('강의 이미지를 마이그레이션하시겠습니까?')) {
                return;
            }
            
            showProgress();
            disableAllButtons();
            addLog('강의 이미지 마이그레이션을 시작합니다...');
            updateProgress(20);
            
            try {
                const response = await fetch('/admin/migration/migrate-lectures', {
                    method: 'POST'
                });
                
                const result = await response.json();
                
                if (result.success) {
                    updateProgress(100);
                    showStatus(result.message, 'success');
                    addLog('강의 이미지 마이그레이션이 완료되었습니다.');
                } else {
                    showStatus(result.message, 'error');
                    addLog('마이그레이션 실패: ' + result.message);
                }
            } catch (error) {
                showStatus('마이그레이션 중 오류가 발생했습니다.', 'error');
                addLog('오류: ' + error.message);
            } finally {
                enableAllButtons();
            }
        }
        
        async function migrateEvents() {
            if (!confirm('이벤트 이미지를 마이그레이션하시겠습니까?')) {
                return;
            }
            
            showProgress();
            disableAllButtons();
            addLog('이벤트 이미지 마이그레이션을 시작합니다...');
            updateProgress(20);
            
            try {
                const response = await fetch('/admin/migration/migrate-events', {
                    method: 'POST'
                });
                
                const result = await response.json();
                
                if (result.success) {
                    updateProgress(100);
                    showStatus(result.message, 'success');
                    addLog('이벤트 이미지 마이그레이션이 완료되었습니다.');
                } else {
                    showStatus(result.message, 'error');
                    addLog('마이그레이션 실패: ' + result.message);
                }
            } catch (error) {
                showStatus('마이그레이션 중 오류가 발생했습니다.', 'error');
                addLog('오류: ' + error.message);
            } finally {
                enableAllButtons();
            }
        }
        
        async function migrateVideos() {
            if (!confirm('비디오 파일을 마이그레이션하시겠습니까?')) {
                return;
            }
            
            showProgress();
            disableAllButtons();
            addLog('비디오 파일 마이그레이션을 시작합니다...');
            updateProgress(20);
            
            try {
                const response = await fetch('/admin/migration/migrate-videos', {
                    method: 'POST'
                });
                
                const result = await response.json();
                
                if (result.success) {
                    updateProgress(100);
                    showStatus(result.message, 'success');
                    addLog('비디오 파일 마이그레이션이 완료되었습니다.');
                } else {
                    showStatus(result.message, 'error');
                    addLog('마이그레이션 실패: ' + result.message);
                }
            } catch (error) {
                showStatus('마이그레이션 중 오류가 발생했습니다.', 'error');
                addLog('오류: ' + error.message);
            } finally {
                enableAllButtons();
            }
        }
        
        async function migrateArchives() {
            if (!confirm('아카이브 첨부파일을 마이그레이션하시겠습니까?')) {
                return;
            }
            
            showProgress();
            disableAllButtons();
            addLog('아카이브 첨부파일 마이그레이션을 시작합니다...');
            updateProgress(20);
            
            try {
                const response = await fetch('/admin/migration/migrate-archives', {
                    method: 'POST'
                });
                
                const result = await response.json();
                
                if (result.success) {
                    updateProgress(100);
                    showStatus(result.message, 'success');
                    addLog('아카이브 첨부파일 마이그레이션이 완료되었습니다.');
                } else {
                    showStatus(result.message, 'error');
                    addLog('마이그레이션 실패: ' + result.message);
                }
            } catch (error) {
                showStatus('마이그레이션 중 오류가 발생했습니다.', 'error');
                addLog('오류: ' + error.message);
            } finally {
                enableAllButtons();
            }
        }
    </script>
</body>
</html>