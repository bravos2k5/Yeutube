<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="main-content">
    <div class="content-header">
        <h1>Quản lý Chia sẻ</h1>
    </div>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-title">Tổng số chia sẻ</div>
            <div class="stat-value">1,234</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Chia sẻ hôm nay</div>
            <div class="stat-value">45</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Người dùng tích cực</div>
            <div class="stat-value">89</div>
        </div>
    </div>

    <form class="search-box" action="">
        <input type="text" class="search-input" placeholder="Tìm kiếm theo email...">
        <button class="btn btn-info">
            <i class="material-icons">search</i>
        </button>
    </form>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Tên người dùng</th>
                <th>Tiêu đề</th>
                <th>Email</th>
                <th>Ngày chia sẻ</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <jsp:useBean id="shares" scope="request" type="java.util.List<com.bravos.yeutube.model.Share>"/>
            <c:forEach var="share" items="${shares}">
                <tr>
                    <td>${share.user.id}</td>
                    <td>${share.video.title}</td>
                    <td>${share.email}</td>
                    <td>${share.sharedDate}</td>
                    <td>
                        <button class="btn btn-danger">
                            <i class="material-icons">delete</i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button class="page-btn">
            <i class="material-icons">chevron_left</i>
        </button>
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn">
            <i class="material-icons">chevron_right</i>
        </button>
    </div>
</div>
