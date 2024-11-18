<jsp:useBean id="currentPage" scope="request" type="java.lang.Integer"/>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<main class="main-content">
    <div class="video-grid">
        <jsp:useBean id="videoList" scope="request" type="java.util.List<com.bravos.yeutube.model.Video>"/>
        <c:if test="${videoList.size() == 0}">
            <h3>Không có video nào cả</h3>
        </c:if>
        <c:forEach var="video" items="${videoList}">
            <a style="text-decoration: none; color: inherit" href="${pageContext.request.contextPath}/video?id=${video.id}">
                <div class="video-card">
                    <img class="thumbnail" src="${video.poster}" alt="${video.title}">
                    <div class="video-details">
                        <img class="channel-avatar" src="https://yt3.ggpht.com/1nS_SybaXEKYC1U1RKpQ4GOjaL2Z-JqFnutYx3B487xVGyHmn-cztARbgVYnR20gd-Jlkhv1=s600-c-k-c0x00ffffff-no-rj-rp-mo"
                             alt="avatar">
                        <div class="video-info">
                            <div class="video-title">${video.title}</div>
                            <div class="channel-name">Youtube</div>
                            <div class="video-stats">${video.views} lượt xem • ${video.timeAgo}</div>
                        </div>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

    <div class="pagination">
        <form method="GET" action="${pageContext.request.contextPath}${type}" class="d-inline">
            <c:if test="${type == '/search' }">
                <input name="keyword" type="hidden" value="${keyword}">
            </c:if>
            <ul class="pagination justify-content-center">
                <c:if test="${currentPage > 1}">
                    <li class="page-item">
                        <button type="submit" name="page" value="1" class="page-link" title="First page">First</button>
                    </li>
                    <li class="page-item">
                        <button type="submit" name="page" value="${currentPage - 1}" class="page-link" title="Previous page">Previous</button>
                    </li>
                </c:if>

                <c:forEach var="page" items="${pageList}">
                    <li class="page-item ${page == currentPage ? 'active' : ''}">
                        <button type="submit" name="page" value="${page}" class="page-link">${page}</button>
                    </li>
                </c:forEach>

                <c:if test="${currentPage < maxPage}">
                    <li class="page-item">
                        <button type="submit" name="page" value="${currentPage + 1}" class="page-link" title="Next page">Next</button>
                    </li>
                    <li class="page-item">
                        <button type="submit" name="page" value="${maxPage}" class="page-link" title="Last page">Last</button>
                    </li>
                </c:if>
            </ul>
        </form>
    </div>
</main>