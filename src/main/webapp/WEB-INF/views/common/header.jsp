<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header id="header">
    <div class="header-inner">
        <!-- 상단: 로고 + 검색창 -->
        <div class="top-row">
            <div id="logo">
                <a href="/">
                    <img src="${pageContext.request.contextPath}/resources/images/common/logo.png">
                </a>
                <button class="categoryBtn">Ξ 카테고리</button>

            </div>
            <div id="search-nav">
            <form action="/lecture/list" method="get" style="display: inline;">
                <input type="text" name="search" class="searchBox" placeholder="검색어를 입력해주세요" value="${param.search}" />
                <button type="submit" style="display: none;"></button>
            </form>
            <nav id="nav">
            <ul class="topMenu">
                <li><a href="/lecture/list">전체 강의</a></li>
                <li><a href="/reference/list">자료실</a></li>
                <li><a href="/notice/list">공지사항</a></li>
                <li><a href="/teacher/question/list">질문 게시판</a></li>
                <li><a href="/member/request">건의사항</a></li>
            </ul>
            </nav>
            </div>
            <div class="loginBox">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginId}">
                        <!-- 로그인된 상태 - 드롭다운 메뉴 -->
                        <div class="user-menu">
                            <c:choose>
                                <c:when test="${sessionScope.adminYn eq 'Y'}">
                                    <img src="${pageContext.request.contextPath}/resources/images/common/mypage3.png" alt="관리자" class="user-icon">
                                </c:when>
                                <c:when test="${sessionScope.teacherYn eq 'Y'}">
                                    <img src="${pageContext.request.contextPath}/resources/images/common/mypage2.png" alt="선생님" class="user-icon">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/resources/images/common/mypage4.png" alt="마이페이지" class="user-icon">
                                </c:otherwise>
                            </c:choose>
                            <div class="dropdown-menu">
                                <c:choose>
                                    <c:when test="${sessionScope.adminYn eq 'Y'}">
                                        <!-- 관리자인 경우 -->
                                        <a href="/admin/main">관리자 페이지</a>
                                    </c:when>
                                    <c:when test="${sessionScope.teacherYn eq 'Y'}">
                                        <!-- 선생님인 경우 -->
                                        <a href="/lecture/add">강의 추가</a>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- 일반 회원인 경우 -->
                                        <a href="/member/mypage">마이페이지</a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="/member/logout">로그아웃</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 로그인되지 않은 상태 - 로그인 페이지로 이동 -->
                        <a href="/member/login">
                            <img src="${pageContext.request.contextPath}/resources/images/common/mypage1.png" alt="로그인" class="user-icon">
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<script>
    document.addEventListener('DOMContentLoaded', function() {
    const userMenu = document.querySelector('.user-menu');
    const userIcon = document.querySelector('.user-icon');
    if (userIcon && userMenu) {
        // 사용자 아이콘 클릭 시 메뉴 토글
        userIcon.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();
            userMenu.classList.toggle('active');
        });
        
        // 메뉴 외부 클릭 시 메뉴 닫기
        document.addEventListener('click', function(e) {
            if (!userMenu.contains(e.target)) {
                userMenu.classList.remove('active');
            }
        });
    }
});
</script>

