<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
    <head>
        <title>Edit Blog</title>
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
            .text-danger {
                color: red;
                font-size: 14px;
                margin-top: 4px;
            }

            .form-group.text-center {
                display: flex;
                justify-content: center;
            }

        </style>
    </head>
    <body class="admin-panel">
        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="card p-4">
                <h2 class="mb-4">Edit Blog</h2>
                <form action="${pageContext.request.contextPath}/admin/blog/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${blog.id}" />

                    <div class="form-group">
                        <label>Title:</label>
                        <input type="text" class="form-control" name="title" value="${blog.title}" />
                        <c:if test="${errors.title != null}">
                            <div class="text-danger">${errors.title}</div>
                        </c:if>
                    </div>

                    <div class="form-group">
                        <label>Summary:</label>
                        <textarea name="summary" class="form-control" rows="3">${blog.summary}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Content:</label>
                        <textarea name="content" class="form-control" rows="5">${blog.content}</textarea>
                    </div>

                    <div class="form-group">
                        <label>Current Image:</label>
                        <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" style="width: 200px; border-radius: 10px; margin-top: 5px;" />
                    </div>

                    <div class="form-group">
                        <label>Change Image (optional):</label>
                        <input type="file" name="image" class="form-control" onchange="previewImage(event)" />
                        <img id="imgPreview" style="display:none; width:200px; margin-top:10px; border-radius:10px;" />
                    </div>

                    <div class="form-group text-center mt-4">
                        <div style="display: inline-flex; gap: 12px;">
                            <button type="submit" class="btn btn-primary px-4">
                                <i class="fas fa-save"></i> Save
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/blog/detail?id=${blog.id}" class="btn btn-info px-4">
                                <i class="fas fa-eye"></i> Back to Detail
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/blog" class="btn btn-secondary px-4">
                                <i class="fas fa-list"></i> Back to List
                            </a>
                        </div>
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
