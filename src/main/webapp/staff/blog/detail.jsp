<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Blog Detail</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .detail-card {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 30px;
        }

        .detail-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .detail-img {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .detail-info {
            font-size: 16px;
            line-height: 1.6;
        }

        .detail-info strong {
            display: inline-block;
            width: 100px;
            color: #333;
        }

        .btn-area {
            margin-top: 30px;
            text-align: center;
        }

        .btn-area .btn {
            margin: 0 10px;
        }
    </style>
</head>
<body class="admin-panel">
<jsp:include page="/components/staffSidebar.jsp" />
<div class="main-content">
    <jsp:include page="/components/dashboardHeader.jsp" />

    <div class="container">
        <div class="detail-card">
            <div class="detail-header">
                <h3>Blog Detail</h3>
                <span class="text-muted">
                    Published: <fmt:formatDate value="${publishedDate}" pattern="dd/MM/yyyy" />
                </span>
            </div>

            <img src="${pageContext.request.contextPath}/asset/img/blog/${blog.image}" alt="${blog.title}" class="detail-img" />

            <div class="detail-info">
                <p><strong>Title:</strong></br>${blog.title}</p>
                <p><strong>Summary:</strong></br> ${blog.summary}</p>
                <p><strong>Content:</strong></br>${blog.content}</p>
            </div>

            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/staff/blog" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
                <a href="${pageContext.request.contextPath}/staff/blog/edit?id=${blog.id}" class="btn btn-warning">
                    <i class="fas fa-edit"></i> Edit Blog
                </a>
            </div>
        </div>
    </div>

    <jsp:include page="/components/dashboardFooter.jsp" />
</div>
</body>
</html>
