import {addEventButton, showAlert} from "./library.js";


let videoId = document.getElementById('video-id').innerHTML;

window.onload = function () {
    setTimeout(function () {
        updateViewCount();
    },5000);
};

function updateViewCount() {
    fetch('/api/public/update-view-count', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({videoId: videoId})
    }).then(response => {
        if (!response.ok) {
            console.log("Error update views");
        }
    });
}


const emailInput = document.getElementById('emailInput');
const emailChips = document.getElementById('emailChips');
const emailList = document.getElementById('emailList');
let emails = [];

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

function shareHandle() {
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
            showAlert('success','Thành công', 'Chia sẻ thành công rồi nha');
        }
    });

    closeSharePopup();
    this.reset();
    emails = [];
    renderEmailChips();
}

async function likeHandle() {
    const btnLike = document.getElementById('btnLike');
    const likeCount = document.getElementById('likeCount');
    const videoId = document.getElementById('video-id').textContent;
    const isLogin = document.getElementById('isLogin').value === 'true';

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
        btnLike.classList.toggle('liked', isLiked);
        btnLike.querySelector('.like-icon').textContent = isLiked ? 'thumb_up' : 'thumb_up_off_alt';
        likeCount.textContent = data.countLike;
    });
}

window.removeEmail = function (email) {
    emails = emails.filter(e => e !== email);
    renderEmailChips();
};

addEventButton('btnShare',shareHandle);
addEventButton('btnOpenShare',openSharePopup);
addEventButton('btnClose1',closeSharePopup);
addEventButton('btnClose2',closeSharePopup);
addEventButton('btnLike',likeHandle);



