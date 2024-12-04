<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="content-header">
        <h1>Thống kê like</h1>
    </div>

    <form class="search-box" style="display: flex; width: 100%" method="GET"
          action="${pageContext.request.contextPath}/admin/likes">
        <input name="search" type="text" class="search-input" placeholder="Tìm kiếm...">
        <button type="submit" class="btn btn-info">
            <i class="material-icons">search</i>
        </button>
    </form>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Tiêu đề</th>
                <th>Số like</th>
                <th>Latest date</th>
                <th>First date</th>
            </tr>
            </thead>
            <tbody>

            <jsp:useBean id="likeStatistics" scope="request" type="java.util.List<com.bravos.yeutube.dto.LikeStatistic>"/>
            <c:forEach var="likeStatistic" items="${likeStatistics}">
                <tr>
                    <td>${likeStatistic.title}</td>
                    <td>${likeStatistic.likeCount}</td>
                    <td>${likeStatistic.latestDate}</td>
                    <td>${likeStatistic.firstDate}</td>
                </tr>
            </c:forEach>

            </tbody>
        </table>
    </div>

    <jsp:useBean id="pageList" scope="request" type="java.util.List<java.lang.Long>"/>
    <c:if test="${pageList.size() > 1}">
        <form method="GET" class="pagination" action="${pageContext.request.contextPath}/admin/likes">
            <c:if test="${currentPage > 1}">
                <button name="page" value="1" class="page-btn">
                    <i class="material-icons">first_page</i>
                </button>
                <button name="page" value="${currentPage - 1}" class="page-btn">
                    <i class="material-icons">chevron_left</i>
                </button>
            </c:if>
            <c:forEach var="page" items="${pageList}">
                <button name="page" value="${page}"
                        class="page-btn ${currentPage == page ? "active" : ""}">${page}</button>
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

