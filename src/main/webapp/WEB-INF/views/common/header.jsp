<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header id="header">
    <div class="header-inner">
        <!-- 상단: 로고 + 검색창 -->
        <div class="top-row">
            <div id="logo">
                <h1>로고</h1>
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
                <button onclick="location.href = '/member/login'">로그인/회원가입</button>
            </div>
        
        </div>

        <!-- nav 메뉴 -->
        
    </div>
</header>

