<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="main-content">
    <div class="content-header">
        <h1>Quản lý Video</h1>
        <a style="text-decoration: none; color: inherit" href="${pageContext.request.contextPath}/admin/videos/create">
            <button class="btn btn-primary">
                <i class="material-icons">add</i>
                Đăng video mới
            </button>
        </a>
    </div>

    <form class="search-box" style="display: flex; width: 100%" action="${pageContext.request.contextPath}/admin/videos">
        <input name="search" type="text" class="search-input" placeholder="Tìm kiếm video..." style="flex: 1; box-sizing: border-box;">
        <button class="btn btn-primary">
            <i class="material-icons">search</i>
        </button>
    </form>


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
                        <a style="text-decoration: none;color: inherit" href="${pageContext.request.contextPath}/admin/videos/update?id=${video.id}">
                            <button class="action-btn" title="Chỉnh sửa">
                                <i class="material-icons">edit</i>
                            </button>
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>

    <jsp:useBean id="pageList" scope="request" type="java.util.List<java.lang.Long>"/>
    <c:if test="${pageList.size() > 1}">
        <form method="GET" class="pagination" action="${pageContext.request.contextPath}/admin/videos">
            <c:if test="${currentPage > 1}">
                <button name="page" value="1" class="page-btn">
                    <i class="material-icons">first_page</i>
                </button>
                <button name="page" value="${currentPage - 1}" class="page-btn">
                    <i class="material-icons">chevron_left</i>
                </button>
            </c:if>
            <c:forEach var="page" items="${pageList}">
                <button name="page" value="${page}" class="page-btn ${currentPage == page ? "active" : ""}">${page}</button>
            </c:forEach>
            <c:if test="${currentPage < maxPage}">
                <button name="page" value="${currentPage + 1}" class="page-btn">
                    <i class="material-icons">chevron_right</i>
                </button>
                <button name="page" value="${maxPage}" class="page-btn">
                    <i class="material-icons">last_page</i>
                </button>
            </c:if>
        </form>
    </c:if>

</div>