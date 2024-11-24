import {hideLoading,addEventButton,showAlert,showLoading} from './library.js'

function toggleTheme() {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-bs-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    html.setAttribute('data-bs-theme', newTheme);

    const icon = document.querySelector('.theme-switch i');
    icon.className = newTheme === 'light' ? 'fas fa-moon' : 'fas fa-sun';
}

function showVerificationModal() {
    const modal = new bootstrap.Modal(document.getElementById('verificationModal'));
    modal.show();
}

function hideVerificationModal() {
    const modal = new bootstrap.Modal(document.getElementById('verificationModal'));
    modal.hide();
}

document.querySelectorAll('.verification-input').forEach((input, index, inputs) => {
    input.addEventListener('input', function () {
        if (this.value.length === 1) {
            if (index < inputs.length - 1) inputs[index + 1].focus();
        }
    });

    input.addEventListener('keydown', function (e) {
        if (e.key === 'Backspace' && !this.value) {
            if (index > 0) inputs[index - 1].focus();
        }
    });
});

function loginHandle() {

    let loginRequest = {
        username: document.getElementById('loginUsername').value,
        password: document.getElementById('loginPassword').value,
        remember: document.getElementById('rememberMe').checked
    }

    if (loginRequest.username.trim().length === 0 || loginRequest.password.length === 0) {
        showAlert('warning', 'Cảnh báo', 'Thông tin đăng nhập không được bỏ trống!');
        return;
    }

    showLoading();

    fetch('/api/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(loginRequest)
    }).then(response => {
        if (!response.ok) {
            hideLoading();
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Máy chủ không phản hồi'));
        }
        return response.json();
    }).then(data => {
        hideLoading();
        if (data.status === 1) {
            showAlert('error', 'Lỗi', `${data.message}`);
        } else {
            window.location.href = data.message;
        }
    })
}

function getVerificationCode() {
    const inputs = document.querySelectorAll('.verification-input');
    let code = '';
    inputs.forEach(input => {
        code += input.value;
    });
    return code;
}

function registerHandle() {

    let registerRequest = {
        username: document.getElementById('registerUsername').value,
        password: document.getElementById('registerPassword').value,
        email: document.getElementById('registerEmail').value
    }

    let repassword = document.getElementById('registerRePassword').value;

    if (registerRequest.username.trim().length === 0 || registerRequest.password.length === 0 || repassword.length === 0) {
        showAlert('warning', 'Cảnh báo', 'Thông tin đăng nhập không được bỏ trống!');
        return;
    }

    if (registerRequest.password !== repassword) {
        showAlert('warning', 'Cảnh báo', 'Xác nhận mật khẩu không trùng khớp');
        return;
    }

    showLoading();

    fetch('/api/auth/register/1', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(registerRequest)
    }).then(response => {
        if (!response.ok) {
            hideLoading();
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Máy chủ không phản hồi'));
        }
        return response.json();
    }).then(data => {
        hideLoading();
        if (data.status === 0) {
            showVerificationModal();
        } else {
            showAlert('error', 'Lỗi', `${data.message}`);
        }
    });

}

function sendCode() {
    let request = {
        code: getVerificationCode()
    }
    if (request.code.length !== 6) {
        showAlert('warning', 'Cảnh báo', 'Mã xác thực phải đủ 6 kí tư');
        return;
    }
    showLoading();
    fetch('/api/auth/register/2', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(request)
    }).then(response => {
        if (!response.ok) {
            hideLoading();
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Máy chủ không phản hồi'));
        }
        return response.json();
    }).then(data => {
        hideLoading();
        if (data.status !== 0) {
            showAlert('error', 'Lỗi', `${data.message}`);
        } else {
            showAlert('success', 'Thành công', 'Đăng ký thành công');
            document.getElementById('btnSendCode').hidden = true;
            window.location.href = "/home";
        }
    });
}

function reSendCode() {
    hideVerificationModal();
    const inputs = document.querySelectorAll('.verification-input');
    inputs.forEach(input => {
        input.value = '';
    });
    registerHandle();
}

addEventButton('reSend',reSendCode);
addEventButton('btnLogin',loginHandle);
addEventButton('btnRegister',registerHandle);
addEventButton('btnSendCode',sendCode);
addEventButton('theme-switch',toggleTheme);

