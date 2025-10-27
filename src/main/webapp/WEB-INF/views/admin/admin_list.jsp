<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/resources/css/admin/admin_list.css">

<div class="board-manage">
    <h2>게시글 관리</h2>
    <p class="summary">카테고리별 게시글 현황을 확인할 수 있습니다.</p>

    <table class="board-table">
        <thead>
        <tr>
            <th>카테고리</th>
            <th>게시글 개수</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td><a href="/reference/list">자료실</a></td>
            <td>${rCount}</td>
        </tr>
        <tr>
            <td><a href="/notice/list">공지사항</a></td>
            <td>${nCount}</td>
        </tr>
        <tr>
            <td><a href="/teacher/question/list">질문/답변</a></td>
            <td>${tCount}</td>
        </tr>
        <tr>
            <td><a href="/member/request">건의사항</a></td>
            <td>${mCount}</td>
        </tr>
        <tr>
            <td><a href="/event/list">이벤트</a></td>
            <td>${eCount}</td>
        </tr>
        </tbody>
    </table>
</div>
