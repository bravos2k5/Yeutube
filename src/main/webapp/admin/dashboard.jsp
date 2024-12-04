<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="main-content">
    
    <div class="dashboard-header">
        <h1>Dashboard</h1>
        <p>Xem tổng quan về hệ thống của bạn</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <h3>Tổng người dùng</h3>
            <div class="number">${allUserCount}</div>
        </div>
        <div class="stat-card">
            <h3>Tổng lượt truy cập</h3>
            <div class="number">${totalAccess}</div>
        </div>
        <div class="stat-card">
            <h3>Người đang truy cập</h3>
            <div class="number">${currentActive}</div>
        </div>
        <div class="stat-card">
            <h3>Tổng số video</h3>
            <div class="number">${videoCount}</div>
        </div>
    </div>

    <div class="recent-activity">
        <h2>Hoạt động gần đây</h2>
        <ul class="activity-list">
            <jsp:useBean id="activities" scope="request" type="java.util.List<com.bravos.yeutube.dto.Activity>"/>
            <c:forEach var="activity" items="${activities}">
                <li class="activity-item">
                    <div class="activity-icon">
                        <i class="material-icons">${activity.type == 1 ? 'video_library' : 'person-add'}</i>
                    </div>
                    <div class="activity-details">
                            ${activity.message}
                        <div style="font-size: 12px; color: #666;">${activity.dateTimeString}</div>
                    </div>
                </li>
            </c:forEach>
        </ul>
    </div>
</div>
