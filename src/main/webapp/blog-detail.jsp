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
            padding-top: 120px;
            padding-bottom: 60px;
        }

        .blog-img {
            width: 100%;
            height: auto;
            border-radius: 15px;
            object-fit: cover;
        }

        .blog-title {
            font-size: 2rem;
            font-weight: bold;
        }

        .blog-content {
            font-size: 1.1rem;
            line-height: 1.8;
            margin-top: 15px;
        }

        .back-link {
            margin-top: 25px;
        }

        @media (max-width: 768px) {
            .blog-img {
                height: 250px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/components/navbar.jsp" />

<div class="container blog-section">
    <div class="row g-4 align-items-start">
        <!-- Left side: Image -->
        <div class="col-md-5">
            <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" alt="${blog.title}" class="blog-img">
        </div>

        <!-- Right side: Title, content -->
        <div class="col-md-7">
            <h1 class="blog-title">${blog.title}</h1>
            <p class="text-muted mb-2">
                Published on <fmt:formatDate value="${publishedDate}" pattern="dd/MM/yyyy" />
            </p>

            <div class="blog-content">
                ${blog.content}
            </div>

            <div class="back-link">
                <a href="${pageContext.request.contextPath}/blog" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Blog List
                </a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/components/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
