<jsp:useBean id="userr" scope="request" type="com.bravos.yeutube.model.User"/>

<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="profile-container">

        <div class="profile-section">
            <h2 class="section-title">Thông tin cá nhân</h2>
            <form>
                <div class="form-group">
                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" class="form-control" value="${userr.fullName}">
                </div>
                <div class="form-group">
                    <label for="email">Địa chỉ email</label>
                    <input type="email" id="email" class="form-control" value="${userr.email}">
                </div>
                <button id="saveChanges" type="button" class="btn">Lưu thay đổi</button>
            </form>
        </div>

        <div class="profile-section">
            <h2 class="section-title">Đổi mật khẩu</h2>
            <form>
                <div class="form-group">
                    <label for="current-password">Mật khẩu hiện tại</label>
                    <input type="password" id="current-password" class="form-control">
                </div>
                <div class="form-group">
                    <label for="new-password">Mật khẩu mới</label>
                    <input type="password" id="new-password" class="form-control">
                </div>
                <div class="form-group">
                    <label for="confirm-password">Nhập lại mật khẩu</label>
                    <input type="password" id="confirm-password" class="form-control">
                </div>
                <button id="changePassword" type="button" class="btn">Đổi mật khẩu</button>
            </form>
        </div>

    </div>
</div>

<script type="module" src="${pageContext.request.contextPath}/js/personal.js"></script>

