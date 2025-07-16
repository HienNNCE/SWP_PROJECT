<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>${blog.title} - DriverXO Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .blog-section {
                padding-top: 100px;
                padding-bottom: 60px;
            }
            .blog-img {
                width: 100%;
                height: auto;
                border-radius: 15px;
                object-fit: cover;
                margin-bottom: 20px;
            }
            .blog-title {
                font-size: 2rem;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .blog-content {
                font-size: 1.05rem;
                line-height: 1.6;
                white-space: pre-line;
            }
            .back-link {
                margin-top: 25px;
            }
            .sidebar {
                border-left: 2px solid #ddd;
                padding-left: 20px;
            }
            .latest-post-card {
                border: 1px solid #ddd;
                border-radius: 10px;
                overflow: hidden;
            }

            .latest-post-card img {
                height: 130px;
                object-fit: cover;
                border-top-left-radius: 0.25rem;
                border-top-right-radius: 0.25rem;
            }

            .latest-post-card .card-body {
                padding: 1rem;
            }
            .latest-post-card .card-title {
                margin-bottom: 0.5rem;
                font-weight: 600;
            }
            .latest-post-card .card-text {
                font-size: 0.85rem;
                margin-bottom: 0.75rem;
            }
            @media (max-width: 768px) {
                .sidebar {
                    border-left: none;
                    padding-left: 0;
                    border-top: 1px solid #ddd;
                    padding-top: 20px;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="/components/navbar.jsp" />

        <div class="container blog-section">
            <div class="row g-4 align-items-start">
                <!-- Left: Main Blog Content -->
                <div class="col-md-8">
                    <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" alt="${blog.title}" class="blog-img">

                    <h1 class="blog-title">${blog.title}</h1>
                    <p class="text-muted mb-2">
                        Published on <fmt:formatDate value="${blog.publishedDate}" pattern="dd/MM/yyyy" />
                    </p>

                    <div class="blog-content">
                        <c:out value="${blog.content}" />
                    </div>

                    <div class="back-link mt-4">
                        <a href="${pageContext.request.contextPath}/blog" class="btn btn-outline-secondary">
                            <i class="fas fa-arrow-left"></i> Back to Blog Posts
                        </a>
                    </div>
                </div>

                <!-- Right: Sidebar Latest Posts -->
                <div class="col-md-4 sidebar">
                    <h4 class="fw-bold mb-3">Latest Posts</h4>
                    <c:forEach var="item" items="${latestBlogs}">
                        <div class="card mb-3 shadow-sm latest-post-card">
                            <img src="${pageContext.request.contextPath}/asset/img/blog/${item.image}" class="card-img-top" alt="${item.title}">
                            <div class="card-body">
                                <h6 class="card-title">${item.title}</h6>
                                <p class="card-text text-muted">
                                    <fmt:formatDate value="${item.publishedDate}" pattern="dd/MM/yyyy" />
                                </p>
                                <a href="${pageContext.request.contextPath}/blog/detail?id=${item.id}" class="btn btn-sm btn-dark">Read more</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <jsp:include page="/components/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
