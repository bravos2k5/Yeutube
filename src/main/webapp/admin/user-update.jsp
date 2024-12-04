<jsp:useBean id="user" scope="request" type="com.bravos.yeutube.model.User"/>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-content">
    <div class="edit-header">
        <h1>Chỉnh sửa thông tin người dùng</h1>
        <button id="btnBack" type="button" class="back-button">
            <i class="material-icons">arrow_back</i>
            Trở về
        </button>
    </div>

    <div class="edit-form">

        <form>
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input readonly type="text" id="username" class="form-control" value="${user.id}">
            </div>

            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" class="form-control" value="${user.fullName}">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input required type="email" id="email" class="form-control" value="${user.email}">
            </div>

            <div class="form-group">
                <label for="role">Vai trò</label>
                <select id="role" class="form-control">
                    <option ${user.admin == true ? 'selected' : ''} value="admin">Admin</option>
                    <option ${user.admin == false ? 'selected' : ''} value="user">User</option>
                </select>
            </div>

            <div class="form-group">
                <label for="password">Mật khẩu mới (để trống nếu không thay đổi)</label>
                <input type="password" id="password" class="form-control">
            </div>

            <div class="form-group">
                <label for="confirm-password">Xác nhận mật khẩu mới</label>
                <input type="password" id="confirm-password" class="form-control">
            </div>

            <div class="form-actions">
                <button id="btnSave" type="button" class="btn btn-primary">Lưu thay đổi</button>
            </div>
        </form>
    </div>
</div>

<script type="module" src="${pageContext.request.contextPath}/js/user-update.js"></script>

