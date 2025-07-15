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
        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="container-fluid">
                <div class="alert-container">
                    <!-- ALERT MESSAGES -->
                    <c:if test="${param.msg == 'created' || param.msg == 'updated' || param.msg == 'deleted'}">
                        <div class="alert alert-success" id="successMessage">
                            <strong>Success!</strong>
                            <c:choose>
                                <c:when test="${param.msg == 'created'}"> User created successfully. </c:when>
                                <c:when test="${param.msg == 'updated'}"> User updated successfully. </c:when>
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

                <!-- SEARCH FORM -->
                <form action="${pageContext.request.contextPath}/admin/users" method="get" style="margin-bottom: 20px;">
                    <div style="display: flex; gap: 10px;">
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="Search users..."
                               style="flex:1; padding:12px; border:1px solid #ccc; border-radius:8px;">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary"><i class="fas fa-sync"></i> Reset</a>
                    </div>
                </form>

                <!-- MAIN TABLE -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>User Management</h5>
                        <a href="${pageContext.request.contextPath}/admin/users/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New User
                        </a>
                    </div>
                    <div class="card-body">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Fullname</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="8">
                                            <div class="alert alert-warning">No users found matching your search.</div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:forEach var="user" items="${users}" varStatus="loop">
                                    <tr>
                                        <td>${user.userId}</td>
                                        <td>${user.fullName}</td>
                                        <td>${user.userName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <span class="badge bg-info">
                                                <c:choose>
                                                    <c:when test="${user.roleId == 1}">Admin</c:when>
                                                    <c:when test="${user.roleId == 2}">Customer</c:when>
                                                    
                                                    <c:when test="${user.roleId == 4}">Staff</c:when>
                                                    <c:otherwise>Staff</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge ${user.userStatus == 'Active' ? 'status-active' : 'status-banned'}">
                                                ${user.userStatus}
                                            </span>
                                        </td>
                                        <td style="display: flex; justify-content: center; align-items: center; gap: 10px">
                                            <a href="${pageContext.request.contextPath}/admin/users/edit?id=${user.userId}" 
                                               class="btn btn-sm btn-warning" title="Edit">
                                                <i class="fas fa-edit"></i>
                                            </a>

                                            <form action="${pageContext.request.contextPath}/admin/users/toggle-status" method="post" class="d-inline">
                                                <input type="hidden" name="userId" value="${user.userId}" />
                                                <button type="submit" class="btn btn-sm ${user.userStatus == 'Active' ? 'btn-danger' : 'btn-success'}"
                                                        onclick="return confirm('Are you sure you want to ${user.userStatus == 'Active' ? 'ban' : 'unban'} this user?')" 
                                                        title="${user.userStatus == 'Active' ? 'Ban' : 'Unban'} User">
                                                    <i class="fas ${user.userStatus == 'Active' ? 'fa-ban' : 'fa-check'}"></i>
                                                </button>
                                            </form>
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
                                            <a class="page-link" href="?page=${i}&size=5&keyword=${keyword}">${i}</a>
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
    <script>
        window.onload = function () {
            const successMsg = document.getElementById("successMessage");
            if (successMsg) {
                setTimeout(() => {
                    successMsg.style.display = "none";
                }, 3000);  // ẩn sau 3 giây
            }
        };
    </script>
</html>
