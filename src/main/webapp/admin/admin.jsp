<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang quản trị Youtube</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-${link}.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popup.css">
    <style>
        select {
            width: 100%;
            max-width: 300px;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            font-size: 16px;
            color: #333;
            appearance: none; /* Loại bỏ mũi tên mặc định trên một số trình duyệt */
            -webkit-appearance: none; /* Cho Safari/Chrome */
            -moz-appearance: none; /* Cho Firefox */
            cursor: pointer;
        }

        option {
            padding: 10px;
            font-size: 16px;
            color: #333;
            background-color: #fff;
        }
    </style>
</head>
<body>
<div class="notification-container" id="notificationContainer"></div>
<div class="sidebar">
    <div class="logo">Admin</div>
    <nav>

        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
            <i class="material-icons">dashboard</i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="nav-item">
            <i class="material-icons">person</i>
            <span>Người dùng</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/videos" class="nav-item">
            <i class="material-icons">video_library</i>
            <span>Video</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/favourites" class="nav-item">
            <i class="material-icons">favorite</i>
            <span>Favourites</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/shares" class="nav-item">
            <i class="material-icons">share</i>
            <span>Shares</span>
        </a>
    </nav>
</div>

<div id="overlay" class="overlay">
    <div class="loading-spinner"></div>
</div>

<jsp:include page="${link}.jsp"/>

</body>
</html>
