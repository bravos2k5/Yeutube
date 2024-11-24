import {addEventButton, showAlert} from "./library.js";

function save() {
    let request = {
        username: document.getElementById('username').value,
        fullName: document.getElementById('fullname').value,
        email: document.getElementById('email').value,
        admin: document.getElementById('role').value === 'admin',
        password: document.getElementById('password').value
    }

    if (request.password != null && request.password.length !== 0) {
        let rePassword = document.getElementById('confirm-password').value;
        if(request.password !== rePassword) {
            showAlert('warning','Mật khẩu', 'Mật khẩu không trùng khớp');
            return;
        }
    }
    fetch('/api/admin/users/update', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(request)
    }).then(response => {
        if(!response.ok) {
            showAlert('error','Server không phản hồi','Hãy thử lại sau');
            return Promise.reject(new Error('Lỗi'));
        }
        return response.json();
    }).then(data => {
        showAlert(data.status === 1 ? 'error' : 'success', 'Thông báo', data.message);
    });
    document.getElementById('password').value = '';
    document.getElementById('confirm-password').value = '';

}

addEventButton('btnSave',save);