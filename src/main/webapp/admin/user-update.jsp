<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-content">
    <div class="edit-header">
        <h1>Chỉnh sửa thông tin người dùng</h1>
        <a href="#" class="back-button">
            <i class="material-icons">arrow_back</i>
            Trở về
        </a>
    </div>

    <div class="edit-form">

        <form>
            <div class="form-group">
                <label for="username">Tên đăng nhập</label>
                <input type="text" id="username" class="form-control" value="johndoe">
            </div>

            <div class="form-group">
                <label for="fullname">Họ và tên</label>
                <input type="text" id="fullname" class="form-control" value="John Doe">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" class="form-control" value="john.doe@example.com">
            </div>

            <div class="form-group">
                <label for="role">Vai trò</label>
                <select id="role" class="form-control">
                    <option value="admin">Admin</option>
                    <option value="user">User</option>
                    <option value="moderator">Moderator</option>
                </select>
            </div>

            <div class="form-group">
                <label for="status">Trạng thái</label>
                <select id="status" class="form-control">
                    <option value="active">Hoạt động</option>
                    <option value="inactive">Không hoạt động</option>
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
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                <button type="button" class="btn btn-secondary">Hủy</button>
            </div>
        </form>
    </div>
</div>

