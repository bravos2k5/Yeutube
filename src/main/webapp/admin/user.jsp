<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="users-header">
        <h1>Quản lý người dùng</h1>
        <div class="search-bar">
            <form method="GET" action="${pageContext.request.contextPath}/admin/users">
                <input name="search" type="text" placeholder="Tìm kiếm người dùng...">
                <button class="btn btn-primary">
                    Search
                </button>
            </form>
        </div>
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
            <c:forEach var="userItem" items="${userList}">
                <tr>
                    <td>${userItem.id}</td>
                    <td>${userItem.fullName}</td>
                    <td>${userItem.email}</td>
                    <td>${userItem.admin ? "Admin" : "User"}</td>
                    <td>
                        <div class="action-buttons">
                            <button class="btn btn-edit">
                                <i class="material-icons">edit</i>
                            </button>
                            <button class="btn btn-delete">
                                <i class="material-icons">delete</i>
                            </button>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="pagination">
        <button class="page-btn">
            <i class="material-icons">chevron_left</i>
        </button>
        <button class="page-btn active">1</button>
        <button class="page-btn">2</button>
        <button class="page-btn">3</button>
        <button class="page-btn">
            <i class="material-icons">chevron_right</i>
        </button>
    </div>
</div>