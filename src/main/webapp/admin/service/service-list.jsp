<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Service Management - Admin</title>

        <!-- CSS -->
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
            .service-table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }
            .service-table thead {
                background: white;
                font-weight: bold;
                font-size: 16px;
            }
            .service-table th, .service-table td {
                padding: 15px;
                border-bottom: 1px solid #e1e1e1;
                vertical-align: middle;
            }
            .service-table tbody tr:hover {
                background-color: #f1f1f1;
            }
            .service-table .service-img {
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
                max-width: 1200px;
            }

            .alert {
                padding: 15px 20px;
                border-radius: 10px;
                font-size: 16px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
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
        </style>
    </head>

    <body class="admin-panel">
        <c:if test="${role == 1}">
        <jsp:include page="../../components/adminSidebar.jsp" />
    </c:if>
    <c:if test="${role == 4}">
        <jsp:include page="../../components/staffSidebar.jsp" />   
    </c:if>s

        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="container-fluid">
                <div class="alert-container">
                    <!-- ALERT MESSAGES -->
                    <c:if test="${param.msg == 'created' || param.msg == 'updated' || param.msg == 'deleted'}">
                        <div class="alert alert-success" id="successMessage">
                            <strong>Success!</strong>
                            <c:choose>
                                <c:when test="${param.msg == 'created'}"> Service created successfully. </c:when>
                                <c:when test="${param.msg == 'updated'}"> Service updated successfully. </c:when>
                                <c:when test="${param.msg == 'deleted'}"> Service deleted successfully. </c:when>
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
                <form action="${pageContext.request.contextPath}/admin/service" method="get" style="margin-bottom: 20px;">
                    <div style="display: flex; gap: 10px;">
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="Search services..."
                               style="flex:1; padding:12px; border:1px solid #ccc; border-radius:8px;">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
                        <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary"><i class="fas fa-sync"></i> Reset</a>
                    </div>
                </form>

                <!-- MAIN TABLE -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>Service Management</h5>
                        <a href="${pageContext.request.contextPath}/admin/service/create" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New Service
                        </a>
                    </div>
                    <div class="card-body">
                        <table class="service-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Price ($)</th>
                                    <th>Estimate Time</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${empty services}">
                                    <tr>
                                        <td colspan="7">
                                            <div class="alert alert-warning">No services found matching your search.</div>
                                        </td>
                                    </tr>
                                </c:if>
                                <c:forEach var="service" items="${services}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty service.serviceImg}">
                                                    <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" alt="${service.serviceName}" class="service-img">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/asset/img/services/default-service.png" alt="Default Service" class="service-img">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>${service.serviceName}</td>
                                        <td>${service.serviceDescription}</td>
                                        <td>$<fmt:formatNumber value="${service.servicePrice}" type="currency" currencySymbol=""/></td>
                                        <td>${service.estimateTime}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/service/detail?id=${service.serviceId}" class="btn btn-sm btn-info"><i class="fas fa-eye"></i></a>
                                            <a href="${pageContext.request.contextPath}/admin/service/edit?id=${service.serviceId}" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i></a>
                                            <a href="${pageContext.request.contextPath}/admin/service/delete?id=${service.serviceId}" onclick="return confirm('Are you sure you want to delete this service?')" class="btn btn-sm btn-danger"><i class="fas fa-trash"></i></a>
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
