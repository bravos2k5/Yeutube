function showNotification(type, title, message) {
    const container = document.getElementById('notificationContainer');

    // Tạo notification element
    const notification = document.createElement('div');
    notification.className = `notification ${type}`;

    // Icon cho từng loại thông báo
    const icons = {
        success: 'fas fa-check-circle',
        error: 'fas fa-times-circle',
        warning: 'fas fa-exclamation-circle',
        info: 'fas fa-info-circle'
    };

    notification.innerHTML = `
                <i class="${icons[type]}"></i>
                <div class="content">
                    <div class="title">${title}</div>
                    <div class="message">${message}</div>
                </div>
                <button class="close-btn" onclick="this.parentElement.remove()">
                    <i class="fas fa-times"></i>
                </button>
                <div class="progress">
                    <div class="progress-bar"></div>
                </div>
            `;

    container.appendChild(notification);

    setTimeout(() => {
        notification.remove();
    }, 3000);
}

export function showAlert(type, title, message) {
    showNotification(type, title, message);
}