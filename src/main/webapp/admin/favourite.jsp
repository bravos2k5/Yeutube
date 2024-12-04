<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="content-header">
        <h1>Thống kê yêu thích</h1>
    </div>

    <form class="search-box" style="display: flex; width: 100%" method="GET" action="${pageContext.request.contextPath}/admin/favourites">
        <input name="search" type="text" class="search-input" placeholder="Tìm kiếm...">
        <button type="submit" class="btn btn-info">
            <i class="material-icons">search</i>
        </button>
    </form>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Video title</th>
                <th>Liked Date</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>

            <jsp:useBean id="favourites" scope="request" type="java.util.List<com.bravos.yeutube.model.Favourite>"/>
            <c:forEach var="favourite" items="${favourites}">
                <tr>
                    <td>${favourite.id}</td>
                    <td>${favourite.user.id}</td>
                    <td>${favourite.video.title}</td>
                    <td>${favourite.likedDate}</td>
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

