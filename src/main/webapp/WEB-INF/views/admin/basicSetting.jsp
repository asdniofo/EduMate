<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" href="/resources/css/admin/basicSetting.css">

<div class="basic-setting">
    <h2>기본 환경설정</h2>
    <p class="summary">시스템 관리 및 각종 설정을 확인할 수 있습니다.</p>

    <div class="menu-grid">
        <!-- 회원 관리 카드 -->
        <div class="menu-card" onclick="loadPage('/admin/user')">
            <div class="card-icon">👥</div>
            <h3>회원 관리</h3>
            <p>회원 정보 조회, 수정, 삭제</p>
        </div>

        <!-- 강의 관리 카드 -->
        <div class="menu-card" onclick="loadPage('/admin/lecture')">
            <div class="card-icon">📚</div>
            <h3>강의 관리</h3>
            <p>강의 목록, 챕터 관리</p>
        </div>

        <!-- 게시글 관리 카드 -->
        <div class="menu-card" onclick="loadPage('/admin/list')">
            <div class="card-icon">📝</div>
            <h3>게시글 관리</h3>
            <p>카테고리별 게시글 관리</p>
        </div>
    </div>

    <!-- 최근 활동 섹션 -->
    <div class="recent-activity">
        <h3>최근 시스템 활동</h3>
        <div class="activity-list">
            <div class="activity-item">
                <div class="activity-icon">👤</div>
                <div class="activity-content">
                    <span class="activity-text">새로운 회원이 가입했습니다.</span>
                    <span class="activity-time">2시간 전</span>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon">📚</div>
                <div class="activity-content">
                    <span class="activity-text">새로운 강의가 등록되었습니다.</span>
                    <span class="activity-time">5시간 전</span>
                </div>
            </div>
            <div class="activity-item">
                <div class="activity-icon">💰</div>
                <div class="activity-content">
                    <span class="activity-text">강의 구매가 완료되었습니다.</span>
                    <span class="activity-time">1일 전</span>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function loadPage(url) {
        // 사이드바 active 상태 변경
        $(".sidebar-menu li").removeClass("active");
        
        // URL에 따라 해당 메뉴에 active 클래스 추가
        if (url === '/admin/user') {
            $(".sidebar-menu a[href='/admin/user']").parent().addClass("active");
        } else if (url === '/admin/lecture') {
            $(".sidebar-menu a[href='/admin/lecture']").parent().addClass("active");
        } else if (url === '/admin/list') {
            $(".sidebar-menu a[href='/admin/list']").parent().addClass("active");
        }
        
        $("#mainContent").load(url, function(response, status, xhr) {
            if (status == "error") {
                console.log("Error loading page:", xhr.status, xhr.statusText);
                $("#mainContent").html("<h2>페이지를 불러올 수 없습니다.</h2>");
            }
        });
    }

</script>
