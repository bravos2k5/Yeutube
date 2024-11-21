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
            <li class="activity-item">
                <div class="activity-icon">
                    <i class="material-icons">person_add</i>
                </div>
                <div class="activity-details">
                    <strong>Nguyễn Văn A</strong> đã đăng ký tài khoản mới
                    <div style="font-size: 12px; color: #666;">2 phút trước</div>
                </div>
            </li>
            <li class="activity-item">
                <div class="activity-icon">
                    <i class="material-icons">video_library</i>
                </div>
                <div class="activity-details">
                    <strong>Trần Thị B</strong> đã đăng video mới
                    <div style="font-size: 12px; color: #666;">15 phút trước</div>
                </div>
            </li>
            <li class="activity-item">
                <div class="activity-icon">
                    <i class="material-icons">favorite</i>
                </div>
                <div class="activity-details">
                    <strong>Lê Văn C</strong> đã thích video "Hướng dẫn nấu ăn"
                    <div style="font-size: 12px; color: #666;">1 giờ trước</div>
                </div>
            </li>
        </ul>
    </div>
</div>
