<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="users-header">
        <h1>Quản lý người dùng</h1>
        <form class="search-bar" method="GET" action="${pageContext.request.contextPath}/admin/users">
            <select name="option">
                <option ${param.get("option") == "username" ? "selected" : ""} value="username">ID (username)</option>
                <option ${param.get("option") == "keyword" ? "selected" : ""} value="keyword">Full name / Email</option>
            </select>
            <input value="${search}" name="search" type="text" placeholder="Tìm kiếm người dùng...">
            <button class="btn btn-primary">
                <i class="material-icons">search</i>
            </button>
        </form>
    </div>

    <div class="users-table">
        <table>
            <thead>
            <tr>
                <th>Username</th>
                <th>Họ và tên</th>
                <th>Email</th>
                <th>Vai trò</th>
                <th>Thao tác</th>
            </tr>
            </thead>
            <tbody>
            <jsp:useBean id="userList" scope="request" type="java.util.List<com.bravos.yeutube.model.User>"/>
            <c:if test="${userList.size() != 0}">
                <c:forEach var="userItem" items="${userList}">
                    <tr>
                        <td>${userItem.id}</td>
                        <td>${userItem.fullName}</td>
                        <td>${userItem.email}</td>
                        <td>${userItem.admin ? "Admin" : "User"}</td>
                        <td>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/users/update?id=${userItem.id}">
                                    <button class="btn btn-edit">
                                        <i class="material-icons">edit</i>
                                    </button>
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
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