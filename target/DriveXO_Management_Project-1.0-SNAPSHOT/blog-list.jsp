<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blog Posts - DriverXO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
        }

        .blog-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 15px;
            border-top-right-radius: 15px;
        }

        .blog-footer {
            background: transparent;
            border-top: none;
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp" />

<div class="container" style="padding-top: 100px">
    <h2 class="mb-4 text-center">Latest Blog Posts</h2>

    <div class="row g-4">
        <c:forEach var="blog" items="${blogs}">
            <div class="col-md-4 col-lg-3">
                <div class="card h-100">
                    <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" class="blog-img" alt="${blog.title}">
                    <div class="card-body">
                        <h5 class="card-title">${blog.title}</h5>
                        <p class="card-text text-muted">
                            <fmt:formatDate value="${blog.publishedAt}" pattern="dd/MM/yyyy" />
                        </p>
                        <p class="card-text">${blog.summary}</p>
                    </div>
                    <div class="card-footer blog-footer d-flex justify-content-center">
                        <a href="${pageContext.request.contextPath}/blog/detail?id=${blog.id}" class="btn btn-outline-primary w-100">
                            <i class="fas fa-book-open"></i> Read More
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty blogs}">
            <div class="alert alert-warning text-center mt-4">No blog posts available.</div>
        </c:if>
    </div>
</div>

<jsp:include page="/components/footer.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
