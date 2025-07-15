<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Blog Management - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .container-fluid { margin-top: 20px; }
        .card { border-radius: 10px; box-shadow: 0 0 15px rgba(0,0,0,0.1); }
        .card-header { color: white; border-radius: 10px 10px 0 0; padding: 20px; }
        .card-header h5 { margin: 0; font-size: 20px; font-weight: bold; color: black; }
        .btn-primary { background: black; border: none; }
        .admin-table { width: 100%; border-collapse: collapse; text-align: center; }
        .admin-table thead { background: white; font-weight: bold; font-size: 16px; }
        .admin-table th, .admin-table td { padding: 15px; border-bottom: 1px solid #e1e1e1; vertical-align: middle; }
        .admin-table tbody tr:hover { background-color: #f1f1f1; }
        img.blog-img { width: 80px; height: 60px; object-fit: cover; border-radius: 5px; }
        .btn-sm { margin: 2px; font-size: 14px; border-radius: 6px; }
        .alert-container { margin: 20px auto; max-width: 1200px; }
        .alert { padding: 15px 20px; border-radius: 10px; font-size: 16px; box-shadow: 0 0 15px rgba(0,0,0,0.1); position: relative; }
        .alert-success { background-color: #d4edda; color: #155724; border: 2px solid #c3e6cb; }
        .alert-error { background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .close-btn { position: absolute; top: 8px; right: 15px; color: #000; font-size: 20px; cursor: pointer; }
    </style>
</head>
<body class="admin-panel">

<jsp:include page="/components/adminSidebar.jsp" />
<div class="main-content">
    <jsp:include page="/components/dashboardHeader.jsp" />

    <div class="container-fluid">

        <!-- ALERT -->
        <div class="alert-container">
            <c:if test="${param.msg == 'created' || param.msg == 'updated' || param.msg == 'deleted'}">
                <div class="alert alert-success" id="successMessage">
                    <strong>Success!</strong>
                    <c:choose>
                        <c:when test="${param.msg == 'created'}"> Blog created successfully. </c:when>
                        <c:when test="${param.msg == 'updated'}"> Blog updated successfully. </c:when>
                        <c:when test="${param.msg == 'deleted'}"> Blog deleted successfully. </c:when>
                    </c:choose>
                </div>
            </c:if>
            <c:if test="${param.error != null}">
                <div class="alert alert-error">
                    <span class="close-btn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                    <strong>Error!</strong> ${param.error}
                </div>
            </c:if>
        </div>

        <!-- SEARCH -->
        <form action="${pageContext.request.contextPath}/admin/blog" method="get" style="margin-bottom: 20px;">
            <div style="display: flex; gap: 10px;">
                <input type="text" name="keyword" value="${param.keyword}" placeholder="Search blog title..."
                       style="flex:1; padding:12px; border:1px solid #ccc; border-radius:8px;">
                <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
                <a href="${pageContext.request.contextPath}/admin/blog" class="btn btn-secondary"><i class="fas fa-sync"></i> Reset</a>
            </div>
        </form>

        <!-- TABLE -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5>Blog Management</h5>
                <a href="${pageContext.request.contextPath}/admin/blog/create" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Create New Blog
                </a>
            </div>
            <div class="card-body">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Title</th>
                            <th>Published At</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty blogs}">
                            <tr>
                                <td colspan="5">
                                    <div class="alert alert-warning">No blog posts found.</div>
                                </td>
                            </tr>
                        </c:if>
                        <c:forEach var="blog" items="${blogs}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>
                                    <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" class="blog-img" alt="${blog.title}">
                                </td>
                                <td>${blog.title}</td>
                                <td><fmt:formatDate value="${blog.publishedDate}" pattern="dd/MM/yyyy"/></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/admin/blog/detail?id=${blog.id}" class="btn btn-sm btn-info"><i class="fas fa-eye"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/blog/edit?id=${blog.id}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i></a>
                                    <a href="${pageContext.request.contextPath}/admin/blog/delete?id=${blog.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this blog?')"><i class="fas fa-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <jsp:include page="/components/dashboardFooter.jsp" />
</div>

<script>
    window.onload = function () {
        const successMsg = document.getElementById("successMessage");
        if (successMsg) {
            setTimeout(() => {
                successMsg.style.display = "none";
            }, 3000);
        }
    };
</script>
</body>
</html>
