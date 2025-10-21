<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header id="header">
    <div class="header-inner">
        <!-- 상단: 로고 + 검색창 -->
        <div class="top-row">
            <div id="logo">
                <a href="/"><h1>로고</h1></a>
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
                <li><a href="#">내 강의실</a></li>
                <li><a href="#">자료실</a></li>
                <li><a href="#">공지사항</a></li>
                <li><a href="#">특가</a></li>
            </ul>
            </nav>
            </div>
            <div class="loginBox">
                <c:choose>
                    <c:when test="${not empty sessionScope.loginId}">
                        <!-- 로그인된 상태 - 드롭다운 메뉴 -->
                        <div class="user-menu">
                            <img src="/images/common/mypage2.png" alt="마이페이지" class="user-icon">
                            <div class="dropdown-menu">
                                <a href="/member/mypage">마이페이지</a>
                                <a href="/member/logout">로그아웃</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 로그인되지 않은 상태 - 로그인 페이지로 이동 -->
                        <a href="/member/login">
                            <img src="/images/common/mypage1.png" alt="로그인" class="user-icon">
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

