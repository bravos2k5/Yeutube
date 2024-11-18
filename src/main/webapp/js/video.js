import {showAlert} from "./popup.js";

function openSharePopup() {

    let isLogin = document.getElementById('isLogin').value;
    if(isLogin === 'false') {
        showAlert('warning','Chưa đăng nhập','Bạn cần đăng nhập để chia sẻ');
        return;
    }

    document.getElementById('sharePopup').style.display = 'flex';
    document.body.style.overflow = 'hidden';
}

function closeSharePopup() {
    document.getElementById('sharePopup').style.display = 'none';
    document.body.style.overflow = 'auto';
}

// Xử lý email chips
const emailInput = document.getElementById('emailInput');
const emailChips = document.getElementById('emailChips');
const emailList = document.getElementById('emailList');
let emails = [];

emailInput.addEventListener('keydown', function (e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        const email = this.value.trim();
        if (validateEmail(email)) {
            addEmailChip(email);
            this.value = '';
            emailList.textContent = '';
        } else {
            emailList.textContent = 'Email không hợp lệ';
        }
    }
});

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function removeEmail(email) {
    emails = emails.filter(e => e !== email);
    renderEmailChips();
}

function addEmailChip(email) {
    if (!emails.includes(email)) {
        console.log(email);
        emails.push(email);
        const chip = document.createElement('div');
        chip.className = 'email-chip';
        chip.innerHTML = `
            ${email}
            <span class="remove-email">
                <i class="material-icons">close</i>
            </span>
        `;
        const removeIcon = chip.querySelector('.remove-email');
        removeIcon.addEventListener('click', function () {
            removeEmail(email);
        });
        emailChips.insertBefore(chip, emailInput);
    } else {
        showAlert('warning', 'Cảnh báo', 'Email đã tồn tại');
    }
}

function renderEmailChips() {
    const chips = emailChips.querySelectorAll('.email-chip');
    chips.forEach(chip => chip.remove());
    emails.forEach(email => addEmailChip(email));
}

document.getElementById('shareForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const message = document.getElementById('message').value;
    const shareData = {
        videoId: document.getElementById('video-id').innerHTML,
        emails: emails,
        message: message
    };

    fetch('/api/private/share', {
        method: "POST",
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(shareData)
    }).then(response => {
        if (!response.ok) {
            showAlert('error', 'Lỗi server', 'Không thể kết nối đến máy chủ, hãy thử lại sau! :((');
            return Promise.reject(new Error('Máy chủ không phản hồi'));
        }
        return response.json();
    }).then(data => {
       if(data.status === 0) {
           showAlert('success','Thành công', 'Chia sẻ thành công rồi, 2h đêm code như cờ hó');
       }
    });

    closeSharePopup();
    this.reset();
    emails = [];
    renderEmailChips();
});

document.addEventListener("DOMContentLoaded", function () {
    const button = document.getElementById("btnShare");
    button.addEventListener("click", openSharePopup);
});


document.addEventListener("DOMContentLoaded", function () {
    const button = document.getElementById("btnClose1");
    button.addEventListener("click", closeSharePopup);
});

document.addEventListener("DOMContentLoaded", function () {
    const button = document.getElementById("btnClose2");
    button.addEventListener("click", closeSharePopup);
});

window.removeEmail = function (email) {
    emails = emails.filter(e => e !== email);
    renderEmailChips();
};

// Like - Unlike



document.addEventListener('DOMContentLoaded', () => {

    const likeBtn = document.getElementById('likeBtn');
    const likeCount = document.getElementById('likeCount');
    const videoId = document.getElementById('video-id').textContent;
    const isLogin = document.getElementById('isLogin').value === 'true';

    const fetchData = async (url, options = {}) => {
        try {
            const response = await fetch(url, options);
            return await response.json();
        } catch (error) {
            console.error('Error during fetch operation:', error);
            return null;
        }
    };

    likeBtn.addEventListener('click', async () => {

        if (!isLogin) {
            showAlert('warning','Chưa đăng nhập','Bạn cần đăng nhập để Like');
            return;
        }

        fetch(`/api/private/like?videoId=${videoId}`,{
            method: "POST",
            headers: {
                'Content-Type': 'application/json'
            }
        }).then(response => {
            if(!response.ok) {
                return Promise.reject(new Error('Máy chủ không phản hồi'));
            }
            return response.json();
        }).then(data => {
            const isLiked = data.liked;
            likeBtn.classList.toggle('liked', isLiked);
            likeBtn.querySelector('.like-icon').textContent = isLiked ? 'thumb_up' : 'thumb_up_off_alt';
            likeCount.textContent = data.countLike;
        });
    });
});

