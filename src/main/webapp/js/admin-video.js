import {addEventButton, hideLoading, showAlert, showLoading} from "./library.js";

const thumbnail = document.getElementById('thumbnail');
const thumbnailImg = document.getElementById('thumbnailImg');

thumbnail.addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            thumbnailImg.src = e.target.result;
        };
        reader.readAsDataURL(file);
    }
});

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
            hideLoading();
            if(data.status === 1) {
                showAlert("error", "Lỗi", data.message);
            }
            else {
                document.getElementById('video-title').value = data.title;
                document.getElementById('description').value = data.description;
                document.getElementById('thumbnailImg').src = data.src;
            }
        });

    } else {
        showAlert("warning","Cảnh báo","Link youtube không hợp lệ");
    }
}

async function createVideo(createRequest, hasCustomThumbnail, form) {
    showLoading();

    if (hasCustomThumbnail) {
        createRequest.thumbnail = '';
    }

    try {
        const response = await fetch("/api/admin/video/create", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(createRequest)
        });

        if (response.ok) {
            const data = await response.json();
            document.getElementById('videoId').value = data.content;

            if (data.status === 0 && hasCustomThumbnail) {
                const uploadResponse = await fetch('/api/admin/upload-thumbnail', {
                    method: 'POST',
                    body: new FormData(form)
                });

                if (!uploadResponse.ok) {
                    showAlert('error', 'Thông báo', 'Lỗi upload hình ảnh');
                    return;
                } else {
                    const imgData = await uploadResponse.json();
                    if (imgData.status !== 0) {
                        showAlert('error', 'Lỗi', 'Lỗi upload hình ảnh lên server');
                    }
                }
            }

            showAlert(data.status === 0 ? 'success' : 'error', 'Thông báo', data.message);

            setTimeout(function () {
                window.location.href = `/admin/videos/update?id=${data.content}`;
            }, 2000);

        } else {
            showAlert('error', 'Lỗi', 'Có lỗi xảy ra, không biết lỗi gì');
        }
    } catch (error) {
        showAlert('error', 'Lỗi', 'Có lỗi xảy ra trong quá trình tạo video');
    } finally {
        hideLoading();
    }
}

try {
    document.getElementById('create-form').addEventListener('submit', async function (e) {
        e.preventDefault();

        let createRequest = {
            youtubeUrl: document.getElementById('youtube-url').value,
            title: document.getElementById('video-title').value,
            description: document.getElementById('description').value,
            thumbnail: thumbnailImg.src,
            active: document.getElementById('status').value === 'public'
        };

        const hasCustomThumbnail = thumbnail.value !== '';

        await createVideo(createRequest, hasCustomThumbnail, this);
    });
} catch {
    console.log('update-form')
}

async function updateVideo(updateRequest, hasNewThumbnail, form) {
    showLoading();

    if (hasNewThumbnail) {
        updateRequest.thumbnail = '';
    }

    try {
        const response = await fetch("/api/admin/video/update", {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updateRequest)
        });

        if (response.ok) {
            const data = await response.json();

            if (data.status === 0 && hasNewThumbnail) {
                const uploadResponse = await fetch('/api/admin/upload-thumbnail', {
                    method: 'POST',
                    body: new FormData(form)
                });

                if (!uploadResponse.ok) {
                    showAlert('error', 'Thông báo', 'Lỗi upload hình ảnh');
                    return;
                } else {
                    const imgData = await uploadResponse.json();
                    if (imgData.status !== 0) {
                        showAlert('error', 'Lỗi', 'Lỗi upload hình ảnh lên server');
                    }
                }
            }

            showAlert(data.status === 0 ? 'success' : 'error', 'Thông báo', data.message);

        } else {
            showAlert('error', 'Lỗi', 'Có lỗi xảy ra, không biết lỗi gì');
        }
    } catch (error) {
        showAlert('error', 'Lỗi', 'Có lỗi xảy ra trong quá trình cập nhật video');
    } finally {
        hideLoading();
    }
}

try {
    document.getElementById('edit-form').addEventListener('submit', async function (e) {
        e.preventDefault();

        let updateRequest = {
            youtubeUrl: document.getElementById('youtube-url').value,
            videoId: document.getElementById('videoId').value,
            title: document.getElementById('video-title').value,
            description: document.getElementById('description').value,
            thumbnail: thumbnailImg.src,
            active: document.getElementById('status').value === 'public'
        }

        const hasNewThumbnail = thumbnail.value !== '';

        await updateVideo(updateRequest,hasNewThumbnail,this);

    });
} catch {
    console.log('create-form')
}

function returnBack() {
    window.location.href = document.referrer;
}


addEventButton('verifyBtn',getYoutubeData);
addEventButton('btnBack',returnBack);