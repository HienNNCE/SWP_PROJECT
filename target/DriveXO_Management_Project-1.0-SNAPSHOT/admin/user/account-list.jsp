<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Management</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            .status-badge {
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 0.85em;
            }
            .status-active {
                background-color: #d4edda;
                color: #155724;
            }
            .status-banned {
                background-color: #f8d7da;
                color: #721c24;
            }
            .action-btn {
                width: 35px;
                height: 35px;
                padding: 0;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            .search-box {
                max-width: 300px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid py-4">

            <!-- Header Section -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Account Management</h2>
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="fas fa-plus"></i> Add New User
                </button>
            </div>

            <!-- Alert Messages -->
            <c:if test="${not empty sessionScope.message}">
                <div class="alert alert-${sessionScope.messageType} alert-dismissible fade show" role="alert">
                    ${sessionScope.message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% session.removeAttribute("message"); %>
                <% session.removeAttribute("messageType");%>
            </c:if>

            <!-- Search and Filter Section -->
            <div class="card mb-4">
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/admin/accounts/search" method="GET" class="row g-3">
                        <div class="col-md-4">
                            <div class="input-group search-box">
                                <input type="text" class="form-control" name="keyword" placeholder="Search users..." value="${param.keyword}">
                                <button class="btn btn-outline-secondary" type="submit">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
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
                                <c:forEach items="${users}" var="user">
                                    <tr>
                                        <td>${user.userId}</td>
                                        <td>${user.userName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.phone}</td>
                                        <td>${user.address}</td>
                                        <td>
                                            <span class="badge bg-info">
                                                <c:choose>
                                                    <c:when test="${user.roleId == 1}">
                                                        Admin
                                                    </c:when>
                                                    <c:when test="${user.roleId == 2}">
                                                        Customer
                                                    </c:when>
                                                    <c:otherwise>
                                                        Staff
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>

                                        </td>
                                        <td>
                                            <span class="status-badge ${user.userStatus == 'Active' ? 'status-active' : 'status-banned'}">
                                                ${user.userStatus}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="btn-group">
                                                <a href="${pageContext.request.contextPath}/admin/accounts/edit?id=${user.userId}" 
                                                   class="btn btn-primary action-btn" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <form action="${pageContext.request.contextPath}/admin/accounts/toggle-status" 
                                                      method="POST" class="d-inline">
                                                    <input type="hidden" name="userId" value="${user.userId}">
                                                    <button type="submit" 
                                                            class="btn ${user.userStatus == 'Active' ? 'btn-danger' : 'btn-success'} action-btn"
                                                            title="${user.userStatus == 'Active' ? 'Ban User' : 'Unban User'}">
                                                        <i class="fas ${user.userStatus == 'Active' ? 'fa-ban' : 'fa-check'}"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/accounts/add" method="POST">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Username</label>
                                <input type="text" class="form-control" name="userName" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Phone</label>
                                <input type="tel" class="form-control" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Address</label>
                                <input type="text" class="form-control" name="address" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="roleId" required>
                                    <option value="2">Customer</option>
                                    <option value="4">Staff</option>          
                                    <!--                                    <option value="1">Admin</option>-->
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Auto-hide alerts after 5 seconds
            window.setTimeout(function () {
                document.querySelectorAll('.alert').forEach(function (alert) {
                    new bootstrap.Alert(alert).close();
                });
            }, 5000);
        </script>
    </body>
</html> 