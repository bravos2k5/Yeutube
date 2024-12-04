import {addEventButton, showAlert} from "./library.js";


const step1 = document.getElementById('step1');
const step2 = document.getElementById('step2');
const step3 = document.getElementById('step3');
const userEmail = document.getElementById('userEmail');
const overlay = document.getElementById('overlay');

async function checkUsername() {
    const username = document.getElementById('recoveryUsername').value.trim();
    if (!username) {
        showAlert('warning', 'Cảnh báo', 'Vui lòng nhập tên tài khoản');
        return;
    }

    try {
        overlay.style.display = 'flex';
        await fetch('/api/auth/forget/check-username', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({username})
        }).then(response => {
            if (!response.ok) {
                return Promise.reject(new Error("Lỗi"));
            }
            return response.json();
        }).then(data => {
            if (data.status == 0) {
                userEmail.textContent = data.content;
                step1.style.display = 'none';
                step2.style.display = 'block';
            } else {
                showAlert('error', 'Thông báo', `${data.content}`);
            }
        });
    } finally {
        overlay.style.display = 'none';
    }
}

async function verifyCode() {
    const code = Array.from(verificationInputs).map(input => input.value).join('');

    if (code.length !== 6) {
        showAlert('warning', 'Vui lòng nhập đủ mã xác nhận', 'Nhập đủ 6 ký tự đi bạn ơi');
        return;
    }

    overlay.style.display = 'flex';

    try {
        let resetRequest = {
            username: document.getElementById('recoveryUsername').value,
            code
        }

        await fetch('/api/auth/forget/verify-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(resetRequest)
        }).then(response => {
            if (!response.ok) {
                showAlert('error', 'Lỗi', 'Lỗi server rồi cậu');
                return Promise.reject(new Error('Lỗi server rồi cậu'));
            }
            return response.json();
        }).then(data => {
            showAlert(data.status == 0 ? 'success' : 'error', 'Thông báo', `${data.content}`)
            if (data.status == 0) {
                step2.style.display = 'none';
                step3.style.display = 'block';
            }
        })
    } finally {
        overlay.style.display = 'none';
    }

}

async function resetPassword() {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmNewPassword').value;

    if (!newPassword || !confirmPassword) {
        showAlert('warning', 'Cảnh báo', 'Vui lòng điền đầy đủ thông tin');
        return;
    }

    if (newPassword !== confirmPassword) {
        showAlert('warning', 'Cảnh báo', 'Mật khẩu không trùng khớp');
        return;
    }

    overlay.style.display = 'flex';
    try {

        let resetRequest = {
            username: document.getElementById('recoveryUsername').value,
            newPassword
        }

        await fetch('/api/auth/forget/reset-password', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(resetRequest)
        }).then(response => {
            if (!response.ok) {
                return Promise.reject(new Error('Server looix'));
            }
            return response.json();
        }).then(data => {
            overlay.style.display = 'none';
            showAlert(data.status == 0 ? 'success' : 'error', 'Thông báo', `${data.content}`)
            if (data.status == 0) {
                setTimeout(function () {
                    window.location.href = '/login';
                }, 2000);
            }
        });
    } finally {
        overlay.style.display = 'none';
    }
}

addEventButton('btnCheckUsername',checkUsername);
addEventButton('btnVerifyCode',verifyCode);
addEventButton('btnResetPassword',resetPassword);


const verificationInputs = document.querySelectorAll('.verification-input');
verificationInputs.forEach((input, index) => {
    input.addEventListener('input', (e) => {
        if (e.target.value && index < verificationInputs.length - 1) {
            verificationInputs[index + 1].focus();
        }
    });

    input.addEventListener('keydown', (e) => {
        if (e.key === 'Backspace' && !e.target.value && index > 0) {
            verificationInputs[index - 1].focus();
        }
    });
});


// Xử lý gửi lại mã
document.getElementById('resendCode').addEventListener('click', async (e) => {
    e.preventDefault();
    try {
        overlay.style.display = 'flex';
        // Gọi API gửi lại mã
        const response = await fetch('/api/resend-code', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username: document.getElementById('recoveryUsername').value
            })
        });

        const data = await response.json();

        if (response.ok) {
            showNotification('Đã gửi lại mã xác nhận', 'success');
        } else {
            showNotification(data.content || 'Không thể gửi lại mã', 'error');
        }
    } catch (error) {
        showNotification('Đã có lỗi xảy ra', 'error');
    } finally {
        overlay.style.display = 'none';
    }
});

document.getElementById('theme-switch').addEventListener('click', () => {
    const html = document.documentElement;
    const currentTheme = html.getAttribute('data-bs-theme');
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    html.setAttribute('data-bs-theme', newTheme);
});