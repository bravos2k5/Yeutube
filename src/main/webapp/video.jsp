<jsp:useBean id="video" scope="request" type="com.bravos.yeutube.model.Video"/>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<main class="main-content">
    <div class="primary">
        <div id="video-id" hidden="hidden">${video.id}</div>
        <div class="video-container">
            <iframe id="videoPlayer"
                    src="https://www.youtube.com/embed/${video.youtubeId}?autoplay=1"
                    title="YouTube video player" frameborder="0"
                    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                    referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
        </div>
        <div class="video-info">
            <h1 class="video-title">${video.title}</h1>
            <div class="video-stats">
                <div><span id="views">${video.views}</span> lượt xem • ${time}</div>
                <div class="likes-container">
                    <button class="action-btn like-btn" id="btnLike">
                        <i class="material-icons like-icon">${isLiked ? 'thumb_up' : 'thumb_up_off_alt'}</i>
                        <span id="likeCount">${like}</span>
                    </button>
                    <button class="action-btn share-btn" id="btnOpenShare">
                        <i class="material-icons">share</i>
                        <span>Chia sẻ</span>
                    </button>
                </div>
            </div>
            <div class="description" style="padding: 12px; border-radius: 12px;">
                <div style="font-weight: 500; margin-bottom: 8px;">Mô tả</div>
                <div style="margin-bottom: 8px">Thời gian đăng: ${video.createdTime}</div>
                <jsp:useBean id="description" scope="request" type="java.util.List<java.lang.String>"/>
                <c:forEach var="des" items="${description}">
                    <div>${des}</div>
                </c:forEach>
                <div>${video.description}</div>
            </div>
        </div>
    </div>

    <div class="secondary">
        <h3>Xem gần đây</h3>
        <div class="suggestion-list">
            <jsp:useBean id="recentViewsList" scope="request" type="java.util.List<com.bravos.yeutube.model.Video>"/>
            <c:forEach var="rVideo" items="${recentViewsList}">
                <a style="text-decoration: none; color: inherit" href="${pageContext.request.contextPath}/video?id=${rVideo.id}">
                    <div class="suggestion-card">
                        <img src="${rVideo.poster}" class="suggestion-thumbnail" alt="Thumbnail">
                        <div class="suggestion-info">
                            <div class="suggestion-title">${rVideo.title}</div>
                            <div class="suggestion-channel">Youtube</div>
                            <div class="suggestion-stats">${rVideo.views} lượt xem • ${rVideo.timeAgo}</div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</main>

<input type="hidden" id="isLogin" value="${user != null}">

<div class="popup-overlay" id="sharePopup">
    <div class="popup-content">
        <div class="popup-header">
            <h2>Chia sẻ video</h2>
            <button id="btnClose1" class="close-btn">
                <i class="material-icons">close</i>
            </button>
        </div>
        <form class="share-form" id="shareForm">

            <div class="form-group">
                <label for="emails">Email người nhận:</label>
                <div class="email-chips" id="emailChips">
                    <input type="text" id="emailInput" placeholder="Nhập email và nhấn Enter">
                </div>
                <div class="email-list" id="emailList"></div>
            </div>

            <div class="form-group">
                <label for="message">Lời nhắn:</label>
                <textarea id="message" rows="4" placeholder="Nhập lời nhắn của bạn"></textarea>
            </div>

            <div class="form-actions">
                <button id="btnClose2" type="button" class="btn btn-secondary">Hủy</button>
                <button id="btnShare" type="button" class="btn btn-primary">Chia sẻ</button>
            </div>

        </form>
    </div>
</div>

<script type="module" src="${pageContext.request.contextPath}/js/video.js"></script>
