<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Management - Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
            }
            .container-fluid {
                margin-top: 20px;
            }
            .card {
                border-radius: 10px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }
            .card-header {
                color: white;
                border-radius: 10px 10px 0 0;
                padding: 20px;
            }
            .card-header h5 {
                margin: 0;
                font-size: 20px;
                font-weight: bold;
                color: black;
            }
            .btn-primary {
                background: black;
                border: none;
            }
            .admin-table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }
            .admin-table thead {
                background: white;
                font-weight: bold;
                font-size: 16px;
            }
            .admin-table th, .admin-table td {
                padding: 15px;
                border-bottom: 1px solid #e1e1e1;
                vertical-align: middle;
            }
            .admin-table tbody tr:hover {
                background-color: #f1f1f1;
            }
            img.accessory-img {
                width: 100px;
                height: 100px;
                border-radius: 10px;
                box-shadow: 0 0 5px rgba(0,0,0,0.3);
            }
            .btn-sm {
                margin: 2px;
                font-size: 14px;
                border-radius: 6px;
            }
            .alert-container {
                margin: 20px auto;
                max-width: 1200px; /* giới hạn rộng giống card */
            }

            .alert {
                padding: 15px 20px;
                border-radius: 10px;  /* giống card */
                font-size: 16px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1); /* giống card */
                position: relative;
            }
            .alert-success {
                background-color: #d4edda;
                color: #155724;
                border: 2px solid #c3e6cb;
            }
            .alert-error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
            .close-btn {
                position: absolute;
                top: 8px;
                right: 15px;
                color: #000;
                font-size: 20px;
                cursor: pointer;
            }
            .status-badge {
                padding: 6px 12px;
                border-radius: 12px;
                font-size: 0.85rem;
                font-weight: bold;
            }
            .status-active {
                background-color: #d4edda;
                color: #155724;
            }
            .status-banned {
                background-color: #f8d7da;
                color: #721c24;
            }
        </style>
    </head>

    <body class="admin-panel">
        <c:if test="${role == 1}">
        <jsp:include page="../../components/adminSidebar.jsp" />
    </c:if>
    <c:if test="${role == 4}">
        <jsp:include page="../../components/staffSidebar.jsp" />   
    </c:if>
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="container-fluid">

                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>Comment Management</h5>
                    </div>
                    <div class="card-body">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>User ID</th>
                                    <th>Part ID</th>
                                    <th>Text</th>
                                    <th>Rating</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty commentList}">
                                    <tr>
                                        <td colspan="8">
                                            <div class="alert alert-warning">No comments found.</div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:forEach var="comment" items="${commentList}">
                                    <tr>
                                        <td>${comment.commentId}</td>
                                        <td>${comment.user.userId}</td>
                                        <td>${comment.part.partId}</td>
                                        <td>${comment.commentText}</td>
                                        <td>${comment.rating}</td>
                                        <td>
                                            <span class="status-badge ${comment.status == 'Active' ? 'status-active' : 'status-banned'}">
                                                ${comment.status}
                                            </span>
                                        </td>
                                        <td>${comment.date}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/comments?action=toggle-status&commentId=${comment.commentId}"
                                               onclick="return confirm('Are you sure you want to ${comment.status == 'Active' ? 'ban' : 'unban'} this comment?')"
                                               class="btn btn-sm ${comment.status == 'Active' ? 'btn-danger' : 'btn-success'}"
                                               title="${comment.status == 'Active' ? 'Ban' : 'Unban'} Comment"
                                               style="margin: 0 2px">
                                                <i class="fas ${comment.status == 'Active' ? 'fa-ban' : 'fa-check'}"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <div class="mt-3 d-flex justify-content-center" style="margin-top: 20px">
                            <nav>
                                <ul class="pagination">
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}&size=5">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>


            </div>

            <jsp:include page="/components/dashboardFooter.jsp" />
        </div>
    </body>
</html>
