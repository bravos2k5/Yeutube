<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi" data-bs-theme="light">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YouTube - Đăng nhập/Đăng ký</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popup.css">
</head>
<body>
<div id="theme-switch" class="theme-switch">
    <i class="fas fa-moon"></i>
</div>

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

        <ul class="nav nav-tabs nav-fill">
            <li class="nav-item">
                <a class="nav-link active" data-bs-toggle="tab" href="#login">Đăng nhập</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-bs-toggle="tab" href="#register">Đăng ký</a>
            </li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="login">
                <form>
                    <div class="mb-3">
                        <input id="loginUsername" type="text" class="form-control" placeholder="Tên tài khoản">
                    </div>
                    <div class="mb-3">
                        <input id="loginPassword" type="password" class="form-control" placeholder="Mật khẩu">
                    </div>
                    <div class="mb-3 form-check">
                        <input type="checkbox" class="form-check-input" id="rememberMe">
                        <label class="form-check-label" for="rememberMe">Ghi nhớ đăng nhập</label>
                    </div>
                    <button id="btnLogin" type="button" class="btn btn-primary mb-3">Đăng nhập</button>
                    <div class="text-center">
                        <a href="#" class="text-decoration-none" style="color: var(--primary-color)">Quên mật khẩu?</a>
                    </div>
                </form>
            </div>
            <div class="tab-pane fade" id="register">
                <form id="registerForm">
                    <div class="mb-3">
                        <input id="registerUsername" type="text" class="form-control" placeholder="Tên tài khoản">
                    </div>
                    <div class="mb-3">
                        <input id="registerEmail" type="email" class="form-control" placeholder="Email">
                    </div>
                    <div class="mb-3">
                        <input id="registerPassword" type="password" class="form-control" placeholder="Mật khẩu">
                    </div>
                    <div class="mb-3">
                        <input id="registerRePassword" type="password" class="form-control"
                               placeholder="Xác nhận mật khẩu">

                    </div>
                    <div class="mb-3">
                        <div class="form-text">
                            Bằng cách đăng ký, bạn đồng ý với <a href="https://www.youtube.com/t/terms" style="color: var(--primary-color)">Điều khoản
                            dịch vụ</a> và <a href="https://www.youtube.com/howyoutubeworks/policies/community-guidelines/" style="color: var(--primary-color)">Chính sách bảo mật</a> của
                            chúng tôi
                        </div>
                    </div>
                    <button id="btnRegister" type="button" class="btn btn-primary">Tạo tài khoản
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="modal fade verification-modal" id="verificationModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title">Xác thực tài khoản</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <p>Chúng tôi đã gửi mã xác thực đến email của bạn</p>
                <div class="verification-code">
                    <input type="text" maxlength="1" class="verification-input">
                    <input type="text" maxlength="1" class="verification-input">
                    <input type="text" maxlength="1" class="verification-input">
                    <input type="text" maxlength="1" class="verification-input">
                    <input type="text" maxlength="1" class="verification-input">
                    <input type="text" maxlength="1" class="verification-input">
                </div>
                <p class="text-muted">Không nhận được mã? <a id="reSend" href="#" style="color: var(--primary-color)">Gửi lại</a></p>
            </div>
            <div class="modal-footer border-0">
                <button id="btnSendCode" type="button" class="btn btn-primary w-100">Xác nhận</button>
            </div>
        </div>
    </div>
</div>

<div id="overlay" class="overlay">
    <div class="loading-spinner"></div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.2/js/bootstrap.bundle.min.js"></script>
<script type="module" src="${pageContext.request.contextPath}/js/auth.js"></script>
</body>
</html>

