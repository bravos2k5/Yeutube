<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YouTube - Quên Mật Khẩu</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popup.css">
</head>
<body>
<div id="theme-switch" class="theme-switch">
    <i class="fas fa-moon"></i>
</div>
<div class="notification-container" id="notificationContainer"></div>
<div class="container auth-container">
    <div class="auth-card animate-card">
        <div class="text-center mb-4">
            <svg class="logo"
                 xmlns="http://www.w3.org/2000/svg" id="yt-ringo2-svg_yt16" width="93" height="20"
                 viewBox="0 0 93 20"
                 focusable="false" aria-hidden="true"
                 style="pointer-events: none; display: inherit; width: 100%; height: 100%;">
                <g>
                    <path
                            d="M14.4848 20C14.4848 20 23.5695 20 25.8229 19.4C27.0917 19.06 28.0459 18.08 28.3808 16.87C29 14.65 29 9.98 29 9.98C29 9.98 29 5.34 28.3808 3.14C28.0459 1.9 27.0917 0.94 25.8229 0.61C23.5695 0 14.4848 0 14.4848 0C14.4848 0 5.42037 0 3.17711 0.61C1.9286 0.94 0.954148 1.9 0.59888 3.14C0 5.34 0 9.98 0 9.98C0 9.98 0 14.65 0.59888 16.87C0.954148 18.08 1.9286 19.06 3.17711 19.4C5.42037 20 14.4848 20 14.4848 20Z"
                            fill="#FF0033"></path>
                    <path d="M19 10L11.5 5.75V14.25L19 10Z" fill="white"></path>
                </g>
                <g id="youtube-paths_yt16">
                    <path
                            d="M37.1384 18.8999V13.4399L40.6084 2.09994H38.0184L36.6984 7.24994C36.3984 8.42994 36.1284 9.65994 35.9284 10.7999H35.7684C35.6584 9.79994 35.3384 8.48994 35.0184 7.22994L33.7384 2.09994H31.1484L34.5684 13.4399V18.8999H37.1384Z">
                    </path>
                    <path
                            d="M44.1003 6.29994C41.0703 6.29994 40.0303 8.04994 40.0303 11.8199V13.6099C40.0303 16.9899 40.6803 19.1099 44.0403 19.1099C47.3503 19.1099 48.0603 17.0899 48.0603 13.6099V11.8199C48.0603 8.44994 47.3803 6.29994 44.1003 6.29994ZM45.3903 14.7199C45.3903 16.3599 45.1003 17.3899 44.0503 17.3899C43.0203 17.3899 42.7303 16.3499 42.7303 14.7199V10.6799C42.7303 9.27994 42.9303 8.02994 44.0503 8.02994C45.2303 8.02994 45.3903 9.34994 45.3903 10.6799V14.7199Z">
                    </path>
                    <path
                            d="M52.2713 19.0899C53.7313 19.0899 54.6413 18.4799 55.3913 17.3799H55.5013L55.6113 18.8999H57.6012V6.53994H54.9613V16.4699C54.6812 16.9599 54.0312 17.3199 53.4212 17.3199C52.6512 17.3199 52.4113 16.7099 52.4113 15.6899V6.53994H49.7812V15.8099C49.7812 17.8199 50.3613 19.0899 52.2713 19.0899Z">
                    </path>
                    <path d="M62.8261 18.8999V4.14994H65.8661V2.09994H57.1761V4.14994H60.2161V18.8999H62.8261Z"></path>
                    <path
                            d="M67.8728 19.0899C69.3328 19.0899 70.2428 18.4799 70.9928 17.3799H71.1028L71.2128 18.8999H73.2028V6.53994H70.5628V16.4699C70.2828 16.9599 69.6328 17.3199 69.0228 17.3199C68.2528 17.3199 68.0128 16.7099 68.0128 15.6899V6.53994H65.3828V15.8099C65.3828 17.8199 65.9628 19.0899 67.8728 19.0899Z">
                    </path>
                    <path
                            d="M80.6744 6.26994C79.3944 6.26994 78.4744 6.82994 77.8644 7.73994H77.7344C77.8144 6.53994 77.8744 5.51994 77.8744 4.70994V1.43994H75.3244L75.3144 12.1799L75.3244 18.8999H77.5444L77.7344 17.6999H77.8044C78.3944 18.5099 79.3044 19.0199 80.5144 19.0199C82.5244 19.0199 83.3844 17.2899 83.3844 13.6099V11.6999C83.3844 8.25994 82.9944 6.26994 80.6744 6.26994ZM80.7644 13.6099C80.7644 15.9099 80.4244 17.2799 79.3544 17.2799C78.8544 17.2799 78.1644 17.0399 77.8544 16.5899V9.23994C78.1244 8.53994 78.7244 8.02994 79.3944 8.02994C80.4744 8.02994 80.7644 9.33994 80.7644 11.7299V13.6099Z">
                    </path>
                    <path
                            d="M92.6517 11.4999C92.6517 8.51994 92.3517 6.30994 88.9217 6.30994C85.6917 6.30994 84.9717 8.45994 84.9717 11.6199V13.7899C84.9717 16.8699 85.6317 19.1099 88.8417 19.1099C91.3817 19.1099 92.6917 17.8399 92.5417 15.3799L90.2917 15.2599C90.2617 16.7799 89.9117 17.3999 88.9017 17.3999C87.6317 17.3999 87.5717 16.1899 87.5717 14.3899V13.5499H92.6517V11.4999ZM88.8617 7.96994C90.0817 7.96994 90.1717 9.11994 90.1717 11.0699V12.0799H87.5717V11.0699C87.5717 9.13994 87.6517 7.96994 88.8617 7.96994Z">
                    </path>
                </g>
            </svg>
        </div>

        <h4 class="text-center mb-4">Khôi phục mật khẩu</h4>

        <!-- Bước 1: Nhập tên tài khoản -->
        <div id="step1" class="forgot-password-step">
            <p class="text-center mb-4">Nhập tên tài khoản của bạn</p>
            <form id="usernameForm">
                <div class="mb-3">
                    <input type="text" class="form-control" id="recoveryUsername" placeholder="Tên tài khoản">
                </div>
                <button type="button" id="btnCheckUsername" class="btn btn-primary mb-3">Tiếp tục</button>
                <div class="text-center">
                    <a href="login.jsp" class="text-decoration-none" style="color: var(--primary-color)">Quay lại đăng nhập</a>
                </div>
            </form>
        </div>

        <!-- Bước 2: Xác nhận email và nhận mã -->
        <div id="step2" class="forgot-password-step" style="display: none;">
            <p class="text-center mb-4">Mã xác nhận đã được gửi về <span id="userEmail" class="fw-bold"></span></p>
            <div class="verification-code mb-4">
                <input type="text" maxlength="1" class="verification-input">
                <input type="text" maxlength="1" class="verification-input">
                <input type="text" maxlength="1" class="verification-input">
                <input type="text" maxlength="1" class="verification-input">
                <input type="text" maxlength="1" class="verification-input">
                <input type="text" maxlength="1" class="verification-input">
            </div>
            <p class="text-center text-muted mb-3">
                Không nhận được mã? <a href="#" id="resendCode" style="color: var(--primary-color)">Gửi lại</a>
            </p>
            <button type="button" id="btnVerifyCode" class="btn btn-primary">Xác nhận</button>
        </div>

        <!-- Bước 3: Đặt mật khẩu mới -->
        <div id="step3" class="forgot-password-step" style="display: none;">
            <p class="text-center mb-4">Đặt mật khẩu mới</p>
            <form id="newPasswordForm">
                <div class="mb-3">
                    <input type="password" class="form-control" id="newPassword" placeholder="Mật khẩu mới">
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="confirmNewPassword" placeholder="Xác nhận mật khẩu mới">
                </div>
                <button type="button" id="btnResetPassword" class="btn btn-primary">Đặt lại mật khẩu</button>
            </form>
        </div>
    </div>
</div>

<div id="overlay" class="overlay">
    <div class="loading-spinner"></div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script type="module">
    // Xử lý chuyển đổi giữa các bước
    const step1 = document.getElementById('step1');
    const step2 = document.getElementById('step2');
    const step3 = document.getElementById('step3');
    const userEmail = document.getElementById('userEmail');
    const overlay = document.getElementById('overlay');

    // Xử lý nút kiểm tra username
    document.getElementById('btnCheckUsername').addEventListener('click', async () => {
        const username = document.getElementById('recoveryUsername').value.trim();
        if (!username) {
            showNotification('Vui lòng nhập tên tài khoản', 'error');
            return;
        }

        try {
            overlay.style.display = 'flex';
            const response = await fetch('/api/auth/check-username', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ username })
            });

            const data = await response.json();

            if (response.ok) {
                // Hiển thị email đã che giấu (ví dụ: j***@gmail.com)
                userEmail.textContent = data.maskedEmail;
                step1.style.display = 'none';
                step2.style.display = 'block';
            } else {
                showNotification(data.message || 'Tài khoản không tồn tại', 'error');
            }
        } catch (error) {
            showNotification('Đã có lỗi xảy ra', 'error');
        } finally {
            overlay.style.display = 'none';
        }
    });

    // Xử lý input mã xác nhận
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

    // Xử lý nút xác nhận mã
    document.getElementById('btnVerifyCode').addEventListener('click', async () => {
        const code = Array.from(verificationInputs).map(input => input.value).join('');
        if (code.length !== 6) {
            showNotification('Vui lòng nhập đủ mã xác nhận', 'error');
            return;
        }

        try {
            overlay.style.display = 'flex';
            // Gọi API xác thực mã
            const response = await fetch('/api/auth/verify-code', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: document.getElementById('recoveryUsername').value,
                    code
                })
            });

            const data = await response.json();

            if (response.ok) {
                step2.style.display = 'none';
                step3.style.display = 'block';
            } else {
                showNotification(data.message || 'Mã xác nhận không đúng', 'error');
            }
        } catch (error) {
            showNotification('Đã có lỗi xảy ra', 'error');
        } finally {
            overlay.style.display = 'none';
        }
    });

    // Xử lý đặt lại mật khẩu
    document.getElementById('btnResetPassword').addEventListener('click', async () => {
        const newPassword = document.getElementById('newPassword').value;
        const confirmPassword = document.getElementById('confirmNewPassword').value;

        if (!newPassword || !confirmPassword) {
            showNotification('Vui lòng nhập đầy đủ thông tin', 'error');
            return;
        }

        if (newPassword !== confirmPassword) {
            showNotification('Mật khẩu xác nhận không khớp', 'error');
            return;
        }

        try {
            overlay.style.display = 'flex';
            // Gọi API đặt lại mật khẩu
            const response = await fetch('/api/reset-password', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: document.getElementById('recoveryUsername').value,
                    newPassword
                })
            });

            const data = await response.json();

            if (response.ok) {
                showNotification('Đặt lại mật khẩu thành công', 'success');
                setTimeout(() => {
                    window.location.href = 'login.jsp';
                }, 1500);
            } else {
                showNotification(data.message || 'Không thể đặt lại mật khẩu', 'error');
            }
        } catch (error) {
            showNotification('Đã có lỗi xảy ra', 'error');
        } finally {
            overlay.style.display = 'none';
        }
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
                showNotification(data.message || 'Không thể gửi lại mã', 'error');
            }
        } catch (error) {
            showNotification('Đã có lỗi xảy ra', 'error');
        } finally {
            overlay.style.display = 'none';
        }
    });

    // Hàm hiển thị thông báo
    function showNotification(message, type) {
        const container = document.getElementById('notificationContainer');
        const notification = document.createElement('div');
        notification.className = `notification ${type}`;
        notification.textContent = message;
        container.appendChild(notification);

        setTimeout(() => {
            notification.classList.add('fade-out');
            setTimeout(() => {
                notification.remove();
            }, 300);
        }, 3000);
    }

    // Theme switcher
    document.getElementById('theme-switch').addEventListener('click', () => {
        const html = document.documentElement;
        const currentTheme = html.getAttribute('data-bs-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        html.setAttribute('data-bs-theme', newTheme);
    });
</script>
</body>
</html>