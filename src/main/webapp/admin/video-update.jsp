<%--<jsp:useBean id="video" scope="request" type="com.bravos.yeutube.model.Video"/>--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<div class="main-content">
    <div class="edit-header">
        <h1>Chỉnh sửa Video</h1>
        <a href="#" class="back-button">
            <i class="material-icons">arrow_back</i>
            Trở về
        </a>
    </div>

    <div class="edit-form">
        <form>
            <div class="form-group">
                <label for="youtube-url">Link Youtube</label>
                <div class="url-input-group">
                    <input type="text" id="youtube-url" class="form-control"
                           placeholder="Nhập link Youtube video">
                    <button id="verifyBtn" type="button" class="btn btn-verify">
                        <i class="material-icons">check</i>
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label>ID Video</label>
                <input type="text" class="form-control readonly-field" value="${video.id}" readonly>
            </div>

            <div class="form-group">
                <label for="video-title">Tiêu đề</label>
                <input type="text" id="video-title" class="form-control"
                       value="${video.title}">
            </div>

            <div class="form-group">
                <label for="description">Mô tả</label>
                <textarea id="description" class="form-control">${video.description}</textarea>
            </div>

            <div class="form-group">
                <label>Thumbnail</label>
                <div class="thumbnail-preview">
                    <img id="thumbnailImg" src="${video.poster}" alt="Thumbnail">
                </div>
                <input type="file" accept="image/*" id="thumbnail" hidden>
                <label style="color: white" for="thumbnail" class="btn btn-secondary">Thay đổi thumbnail (nên chọn ảnh chất lượng cao rõ nét, không bị vỡ</label>
            </div>

            <div class="video-info">
                <div class="form-group">
                    <label>Ngày tạo</label>
                    <input type="text" class="form-control readonly-field"
                           value="${video.createdTime}" readonly>
                </div>

                <div class="form-group">
                    <label>Lượt xem</label>
                    <input type="text" class="form-control readonly-field"
                           value="${video.views}" readonly>
                </div>

                <div class="form-group">
                    <label for="status">Trạng thái</label>
                    <select id="status" class="form-control">
                        <option value="public" ${video.active ? "selected" : ""}>Công khai</option>
                        <option value="unlisted" ${video.active ? "" : "selected"} >Không công khai</option>
                    </select>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                <button type="button" class="btn btn-secondary">Hủy</button>
            </div>
        </form>
    </div>
</div>

<script type="module" src="${pageContext.request.contextPath}/js/admin-video.js"></script>

