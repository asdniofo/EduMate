<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <title>Edumate 관리자 페이지</title>
        <link rel="stylesheet" href="/resources/css/admin/admin.css">
        <link rel="stylesheet" href="/resources/css/common/header.css">
        <link rel="stylesheet" href="/resources/css/common/footer.css">
    </head>
    <script src="/resources/js/admin/admin.js"></script>
    <body>
        <jsp:include page="../common/header.jsp"/>

        <div class="admin-wrapper">
            <!-- 사이드바 -->
            <aside class="sidebar">
                <a href="/admin/main">
                    <img class="login-logo" src="https://pub-f8fd744877724e40a29110baaa7d9f66.r2.dev/common/images/logo2.png">
                </a>
                <ul class="sidebar-menu">
                    <li class="active"><a href="/admin/setting">결제 관리<span>&gt;</span></a></li>
                    <li><a href="/admin/user">회원 관리<span>&gt;</span></a></li>
                    <li><a href="/admin/lecture">강의 관리<span>&gt;</span></a></li>
                    <li><a href="/admin/list">게시글 관리<span>&gt;</span></a></li>
                </ul>
            </aside>

            <!-- 메인 컨텐츠 -->
            <section class="main-content" id="mainContent">
                <%-- 기본 화면 (기본 설정) --%>
                <jsp:include page="../admin/basicSetting.jsp"/>
            </section>
        </div>
        <jsp:include page="../common/footer.jsp"/>
    </body>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(function () {
            // 사이드바 클릭 시 동작
            $(".sidebar-menu a").on("click", function (e) {
                e.preventDefault(); // a태그의 기본 이동 막기

                const url = $(this).attr("href"); // ex) /admin/user

                // 사이드바 active 표시 변경
                $(".sidebar-menu li").removeClass("active");
                $(this).parent().addClass("active");

                // Ajax로 JSP 내용만 교체
                console.log("Loading URL:", url);
                $("#mainContent").load(url, function (response, status, xhr) {
                    if (status == "error") {
                        console.log("Error loading page:", xhr.status, xhr.statusText);
                        $("#mainContent").html("<h2>페이지를 불러올 수 없습니다.</h2>");
                    } else {
                        console.log("Page loaded successfully");
                    }
                });
            });
        });
    </script>
</html>