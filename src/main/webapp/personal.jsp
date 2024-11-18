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
                <button type="submit" class="btn">Đổi mật khẩu</button>
            </form>
        </div>

    </div>
</div>

<script type="module">

    import {showAlert} from "/js/popup.js";

    function changeInfo() {

        const request = {
            fullName: document.getElementById('fullname').value,
            email: document.getElementById('email').value
        }

        fetch('/api/private/changeinfo', {
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(request)
        }).then(response => {
            if(!response.ok) {
                showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
                return Promise.reject(new Error('Lỗi xử lý máy chủ'));
            }
            return response.json();
        }).then(data => {
            showAlert(data.status === 0 ? 'success' : 'error','Thông báo',data.message);
        })

    }

    function addEventButton(buttonId, event) {
        document.addEventListener("DOMContentLoaded", function () {
            const button = document.getElementById(buttonId);
            button.addEventListener("click", event);
        });
    }

    addEventButton('saveChanges',changeInfo);



</script>

