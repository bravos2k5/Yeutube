<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-content">
    <div class="content-header">
        <h1>Quản lý Video</h1>
        <button class="btn btn-primary">
            <i class="material-icons">add</i>
            Đăng video mới
        </button>
    </div>

    <div class="search-box">
        <form style="display: flex; width: 100%" action="${pageContext.request.contextPath}/admin/videos">
            <input name="search" type="text" class="search-input" placeholder="Tìm kiếm video..." style="flex: 1; box-sizing: border-box;">
            <button class="btn btn-primary">
                <i class="material-icons">search</i>
                Tìm kiếm
            </button>
        </form>
    </div>


    <div class="video-grid">

        <jsp:useBean id="videoList" scope="request" type="java.util.List<com.bravos.yeutube.model.Video>"/>
        <c:forEach var="video" items="${videoList}">
            <div class="video-card">
                <img src="${video.poster}" alt="Video thumbnail" class="video-thumbnail">
                <div class="video-info">
                    <h3 class="video-title">${video.title}</h3>
                    <div class="video-stats">
                        <span>${video.views} lượt xem</span>
                        <span>${video.createdTime.toLocalDate()}</span>
                    </div>
                    <span class="status-badge status-${video.active ? "public" : "private"}">${video.active ? "Công khai" : "Không công khai"}</span>
                    <div class="video-actions">
                        <button class="action-btn" title="Chỉnh sửa">
                            <i class="material-icons">edit</i>
                        </button>
                        <button class="action-btn" title="Xóa">
                            <i class="material-icons">delete</i>
                        </button>
                    </div>
                </div>
            </div>
        </c:forEach>


    </div>
</div>