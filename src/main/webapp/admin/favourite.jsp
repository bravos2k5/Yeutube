<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<div class="main-content">
    <div class="content-header">
        <h1>Quản lý Favourite</h1>
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
                    <td>
                        <button class="btn btn-danger">
                            <i class="material-icons">delete</i>
                        </button>
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

<script>
    document.querySelectorAll('.btn-danger').forEach(button => {
        button.addEventListener('click', function() {
            if(confirm('Bạn có chắc chắn muốn xóa mục này?')) {
                console.log('Đã xóa');
            }
        });
    });

    document.querySelector('.btn-info').addEventListener('click', function() {
        const searchTerm = document.querySelector('.search-input').value;
        console.log('Tìm kiếm:', searchTerm);
    });

    document.querySelectorAll('.page-btn').forEach(button => {
        button.addEventListener('click', function() {
            document.querySelectorAll('.page-btn').forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
        });
    });
</script>
