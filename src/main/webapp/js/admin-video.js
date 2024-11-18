import {showAlert} from "./popup.js";

function showLoading() {
    document.getElementById("overlay").style.display = "flex";
}

function hideLoading() {
    document.getElementById("overlay").style.display = "none";
}

function getYoutubeData() {
    let request = {
        link: document.getElementById('youtube-url').value
    }
    if (request.link.includes('youtube.com/watch?v=') || request.link.includes('youtu.be/')) {
        showLoading();
        fetch('/api/public/youtube', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(request)
        }).then(response => {
            if(!response.ok) {
                hideLoading();
                showAlert("error", "Lỗi", "Máy chủ không phản hồi");
                return Promise.reject(new Error('Máy chủ không phản hồi'));
            }
            return response.json();
        }).then(data => {
            if(data.status === 1) {
                hideLoading();
                showAlert("error", "Lỗi", data.message);
            }
            else {
                document.getElementById('video-title').value = data.title;
                document.getElementById('description').value = data.description;
                document.getElementById('thumbnailImg').src = data.src;
                hideLoading();
            }
        });

    } else {
        showAlert("warning","Cảnh báo","Link youtube không hợp lệ");
    }
}

document.addEventListener("DOMContentLoaded", function() {
    const button = document.getElementById("verifyBtn");
    button.addEventListener("click", getYoutubeData);
});