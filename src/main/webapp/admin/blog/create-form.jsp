<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
    <head>
        <title>Create Blog</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .form-group {
                margin-bottom: 20px;
            }
            .form-control {
                width: 100%;
                padding: 8px 12px;
                border: 1px solid #444;
                border-radius: 6px;
            }
            label {
                font-weight: 600;
                margin-bottom: 6px;
                display: block;
            }
        </style>
    </head>
    <body class="admin-panel">
        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="card p-4">
                <h2 class="mb-4">Create New Blog</h2>
                <form action="${pageContext.request.contextPath}/admin/blog/create" method="post" enctype="multipart/form-data">

                    <div class="form-group">
                        <label>Title:</label>
                        <input type="text" class="form-control" name="title" value="${oldBlog.title}" />
                        <c:if test="${errors.title != null}">
                            <div class="text-danger mt-1">${errors.title}</div>
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Summary:</label>
                        <textarea name="summary" class="form-control" rows="3">${oldBlog.summary}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Content:</label>
                        <textarea name="content" class="form-control" rows="5">${oldBlog.content}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Image:</label>
                        <input type="file" name="image" class="form-control" onchange="previewImage(event)" />
                        <img id="imgPreview" style="display:none; width: 200px; margin-top: 10px; border-radius: 8px;" />
                    </div>

                    <div class="form-group mt-4" style="display: flex; justify-content: center; gap: 16px;">
                        <button type="submit" class="btn btn-outline-dark px-4">
                            <i class="fas fa-save"></i> Create
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/blog" class="btn btn-outline-dark px-4">
                            <i class="fas fa-arrow-left"></i> Back
                        </a>
                    </div>

                </form>
            </div>

            <jsp:include page="/components/dashboardFooter.jsp" />
        </div>

        <script>
            function previewImage(event) {
                const reader = new FileReader();
                reader.onload = function () {
                    const img = document.getElementById('imgPreview');
                    img.src = reader.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </body>
</html>
