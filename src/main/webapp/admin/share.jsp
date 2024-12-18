<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="main-content">
    <div class="content-header">
        <h1>Thống kê chia sẻ</h1>
    </div>

    <div class="stats-container">
        <div class="stat-card">
            <div class="stat-title">Tổng số chia sẻ</div>
            <div class="stat-value">${all}</div>
        </div>
        <div class="stat-card">
            <div class="stat-title">Chia sẻ hôm nay</div>
            <div class="stat-value">${today}</div>
        </div>
    </div>

    <form method="GET" class="search-box" action="${pageContext.request.contextPath}/admin/shares">
        <input name="search" type="text" class="search-input" placeholder="Tìm kiếm theo tiêu đề video mệt v">
        <button class="btn btn-info">
            <i class="material-icons">search</i>
        </button>
    </form>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Tên người dùng</th>
                <th>Tiêu đề</th>
                <th>Email</th>
                <th>Ngày chia sẻ</th>
            </tr>
            </thead>
            <tbody>
            <jsp:useBean id="shares" scope="request" type="java.util.List<com.bravos.yeutube.model.Share>"/>
            <c:forEach var="share" items="${shares}">
                <tr>
                    <td>${share.user.id}</td>
                    <td>${share.video.title}</td>
                    <td>${share.email}</td>
                    <td>${share.sharedDate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <jsp:useBean id="pageList" scope="request" type="java.util.List<java.lang.Long>"/>
    <c:if test="${pageList.size() > 1}">
        <form method="GET" class="pagination" action="${pageContext.request.contextPath}/admin/users">
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
