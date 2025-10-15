<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>헤더</title>
        <link rel="stylesheet" href="/resources/css/common/header.css" />
    </head>
    <body>
        <header id="header">
            <div class="header-inner">
                <!-- 상단: 로고 + 검색창 -->
                <div class="top-row">
                    <div id="logo">
                        <h1>로고</h1>
                        <button class="categoryBtn">Ξ 카테고리</button>
                    </div>

                    <div id="search-nav">
                    <input type="text" class="searchBox" placeholder="검색어를 입력해주세요" />
                    <nav id="nav">
                    <ul class="topMenu">
                        <li><a href="#">강의/강좌</a></li>
                        <li><a href="#">내 강의실</a></li>
                        <li><a href="/reference/list">자료실</a></li>
                        <li><a href="#">공지사항</a></li>
                        <li><a href="#">특가</a></li>
                    </ul>
                    </nav>
                    </div>
                    <div class="loginBox">
                        <button>로그인/회원가입</button>
                    </div>
                
                </div>

                <!-- nav 메뉴 -->
                
            </div>
        </header>
    </body>
</html>
