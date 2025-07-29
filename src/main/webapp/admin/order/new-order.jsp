<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Management - Admin</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .custom-select {
                width: 100%;
                padding: 10px 12px;
                border-radius: 12px;
                border: 1px solid #ccc;
                appearance: none;
                background-color: #f9f9f9;
                font-size: 16px;
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
                transition: border-color 0.3s, box-shadow 0.3s;
                outline: none;
                background-image: url("data:image/svg+xml;utf8,<svg fill='%23666' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px 16px;
            }

            .custom-select:focus {
                border-color: #4CAF50;
                box-shadow: 0 0 3px rgba(76, 175, 80, 0.5);
                background-color: #fff;
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
            }

            .modal-content {
                background: white;
                padding: 20px 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                width: 300px;
                position: relative;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 20px;
                cursor: pointer;
            }

            .btn-save {
                padding: 8px 16px;
                background-color: #4CAF50;
                border: none;
                border-radius: 8px;
                color: white;
                cursor: pointer;
            }

            .btn-save:hover {
                background-color: #45a049;
            }

            body {
                background: #f5f7fa;
                font-family: 'Segoe UI', Arial, sans-serif;
                margin: 0;
                padding: 0;
            }
            .order-list-section {
                padding: 60px 0;
            }
            .container {
                max-width: 1100px;
                margin: 0 auto;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 5px 24px rgba(0,0,0,0.08);
                padding: 40px 30px;
            }
            .page-title {
                font-size: 32px;
                font-weight: 700;
                color: #072eb0;
                margin-bottom: 30px;
                letter-spacing: 1px;
            }
            .order-table {
                width: 100%;
                border-collapse: collapse;
                background: #fff;
            }
            .order-table th, .order-table td {
                padding: 16px 12px;
                text-align: left;
            }
            .order-table th {
                background: #f0f4fa;
                color: #072eb0;
                font-size: 16px;
                font-weight: 600;
                border-bottom: 2px solid #e6eaf3;
            }
            .order-table tr {
                border-bottom: 1px solid #e6eaf3;
            }
            .order-table tr:last-child {
                border-bottom: none;
            }
            .order-table td {
                font-size: 15px;
                color: #333;
            }
            .order-status {
                display: inline-block;
                padding: 7px 18px;
                border-radius: 30px;
                font-weight: 600;
                font-size: 14px;
            }
            .status-processing {
                background: #ffe9cc;
                color: #ff8c00;
            }
            .status-shipped {
                background: #cce5ff;
                color: #0066cc;
            }
            .status-delivered {
                background: #d1e7dd;
                color: #0a5c36;
            }
            .status-cancelled {
                background: #f8d7da;
                color: #b02a37;
            }
            
            .action-links a:last-child {
                margin-right: 0;
            }
            .action-links a:hover {
                color: #ff8c00;
            }
            @media (max-width: 900px) {
                .container {
                    padding: 20px 5px;
                }
                .order-table th, .order-table td {
                    padding: 10px 6px;
                }
            }
            @media (max-width: 600px) {
                .container {
                    padding: 10px 2px;
                }
                .page-title {
                    font-size: 22px;
                }
                .order-table th, .order-table td {
                    font-size: 13px;
                    padding: 7px 2px;
                }
            }
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
                    <c:if test="${param.error != null}">
                        <div class="alert alert-error">
                            <span class="close-btn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                            <strong>Error!</strong> ${param.error}
                        </div>
                    </c:if>
                </div>

                <!-- SEARCH FORM -->
                <form action="${pageContext.request.contextPath}/OrderManagementServlet" method="get" style="margin-bottom: 20px;">
                <%-- <a type='hidden' name='action' value='search'> --%>
                    <%-- <div style="display: flex; gap: 10px;">
                        <input type="text" name="keyword" value="${param.keyword}" placeholder="Search parts..."
                               style="flex:1; padding:12px; border:1px solid #ccc; border-radius:8px;">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Search</button>
                        <a href="${pageContext.request.contextPath}/OrderManagementServlet" class="btn btn-secondary"><i class="fas fa-sync"></i> Reset</a>
                    </div> --%>
                </form>

                <!-- MAIN TABLE -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h5>Order Management</h5>
                    </div>
                    <div class="card-body">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>User ID</th>
                                    <th>Price</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                    <th>Payment ID</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td>${order.userId}</td>
                                    <td>$${order.orderPrice}</td>
                                    <td>
                                        <span class="order-status 
                                              <c:choose>
                                                  <c:when test="${order.orderStatus eq 'Processing'}">status-processing</c:when>
                                                  <c:when test="${order.orderStatus eq 'Shipped'}">status-shipped</c:when>
                                                  <c:when test="${order.orderStatus eq 'Delivered'}">status-delivered</c:when>
                                                  <c:when test="${order.orderStatus eq 'Cancelled'}">status-cancelled</c:when>
                                              </c:choose>
                                              ">
                                            ${order.orderStatus}
                                        </span>
                                    </td>
                                <td><fmt:formatDate value="${order.getOrderDate()}" pattern="yyyy-MM-dd HH:mm"/></td>
                                <td>${order.paymentId}</td>
                                <td class="action-links">
                                    <a href="OrderManagementServlet?action=view&id=${order.orderId}"><i class="fas fa-eye"></i></a>
                                    <a href="#" class="btn btn-sm btn-warning" 
                                       data-id="${order.orderId}" 
                                       data-status="${order.orderStatus}">
                                        <i class="fas fa-edit"></i>
                                    </a>                            
                                    <a href="OrderManagementServlet?action=delete&id=${order.orderId}" onclick="return confirm('Delete?')" class="btn btn-sm btn-danger"><i class="fas fa-ban"></i></a>
                                </td>
                                </tr>
                            </c:forEach>
                            <!-- Edit Status Modal -->
                            <div id="editModal" class="modal-overlay" style="display: none;">
                                <div class="modal-content">
                                    <span class="close-btn">&times;</span>
                                    <form action="OrderManagementServlet" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" id="modalOrderId">
                                        <label for="statusSelect">Select Order Status:</label>
                                        <select name="status" id="statusSelect" class="custom-select" required>
                                            <option value="Processing">Processing</option>
                                            <option value="Shipped">Shipped</option>
                                            <option value="Delivered">Delivered</option>
                                            <option value="Cancelled">Cancelled</option>
                                        </select>
                                        <br><br>
                                        <button type="submit" class="btn-save">Update</button>
                                    </form>
                                </div>
                            </div>
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
        document.querySelectorAll('.edit-btn').forEach(btn => {
            btn.addEventListener('click', function (e) {
                e.preventDefault();
                const orderId = this.dataset.id;
                const status = this.dataset.status;

                document.getElementById('modalOrderId').value = orderId;
                document.getElementById('statusSelect').value = status;

                document.getElementById('editModal').style.display = 'flex';
            });
        });

        document.querySelector('.close-btn').addEventListener('click', () => {
            document.getElementById('editModal').style.display = 'none';
        });

        window.addEventListener('click', (e) => {
            const modal = document.getElementById('editModal');
            if (e.target === modal) {
                modal.style.display = 'none';
            }
        });
    </script>
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
