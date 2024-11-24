import {addEventButton, showAlert} from "./library.js";

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
        if (!response.ok) {
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Lỗi xử lý máy chủ'));
        }
        return response.json();
    }).then(data => {
        showAlert(data.status === 0 ? 'success' : 'error', 'Thông báo', data.message);
    })

}

function changePassword() {

    const request = {
        oldPassword: document.getElementById('current-password').value,
        newPassword: document.getElementById('new-password').value
    }

    let confirmPassword = document.getElementById('confirm-password').value;
    if (request.newPassword !== confirmPassword) {
        showAlert('warning', 'Cảnh báo', 'Mật khẩu không trùng khớp');
        return;
    }

    fetch('/api/private/changepassword', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(request)
    }).then(response => {
        if (!response.ok) {
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Lỗi xử lý máy chủ'));
        }
        return response.json();
    }).then(data => {
        document.getElementById('current-password').value = '';
        document.getElementById('new-password').value = '';
        document.getElementById('confirm-password').value = '';
        showAlert(data.status === 0 ? 'success' : 'error', 'Thông báo', data.message);
    })

}

addEventButton('saveChanges', changeInfo);
addEventButton('changePassword', changePassword);