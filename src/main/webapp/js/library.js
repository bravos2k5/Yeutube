const notificationDiv = document.createElement('div');
notificationDiv.className = 'notification-container';
notificationDiv.id = 'notificationContainer';
document.body.insertBefore(notificationDiv, document.body.firstChild);

function showNotification(type, title, message) {
    const container = document.getElementById('notificationContainer');

    const notification = document.createElement('div');
    notification.className = `notification ${type}`;

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
    }, 3500);
}

export function showAlert(type, title, message) {
    showNotification(type, title, message);
}

export function showLoading() {
    document.getElementById("overlay").style.display = "flex";
}

export function hideLoading() {
    document.getElementById("overlay").style.display = "none";
}

export function addEventButton(buttonId, event) {
    document.addEventListener("DOMContentLoaded", function () {
        const button = document.getElementById(buttonId);
        button.addEventListener("click", event);
    });
}