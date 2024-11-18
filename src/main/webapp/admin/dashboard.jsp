<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-content">
  <div class="dashboard-header">
    <h1>Dashboard</h1>
    <p>Xem tổng quan về hệ thống của bạn</p>
  </div>

  <div class="stats-grid">
    <div class="stat-card">
      <h3>Tổng người dùng</h3>
      <div class="number">1,234</div>
      <div class="trend up">
        <i class="material-icons">arrow_upward</i>
        12% so với tháng trước
      </div>
    </div>
    <div class="stat-card">
      <h3>Tổng video</h3>
      <div class="number">856</div>
      <div class="trend up">
        <i class="material-icons">arrow_upward</i>
        8% so với tháng trước
      </div>
    </div>
    <div class="stat-card">
      <h3>Lượt thích</h3>
      <div class="number">3,592</div>
      <div class="trend down">
        <i class="material-icons">arrow_downward</i>
        3% so với tháng trước
      </div>
    </div>
    <div class="stat-card">
      <h3>Lượt chia sẻ</h3>
      <div class="number">945</div>
      <div class="trend up">
        <i class="material-icons">arrow_upward</i>
        15% so với tháng trước
      </div>
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
