<%-- 
    Document   : order
    Created on : Jun 10, 2025, 1:43:59 AM
    Author     : Alienware
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
    <head>
        <title>Order Management</title>
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
            .action-links a {
                margin-right: 10px;
                text-decoration: none;
                color: #072eb0;
                font-weight: 500;
                transition: color 0.2s;
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
        </style>
    </head>
    <body>
        <section class="order-list-section">
            <div class="container">
                <div class="page-title"><i class="fas fa-shopping-cart"></i> Order List</div>
                <table class="order-table">
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Date</th>
                        <th>Payment ID</th>
                        <th>Action</th>
                    </tr>
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
                            <td>
                        <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm"/>
                        </td>
                        <td>${order.paymentId}</td>
                        <td class="action-links">
                            <a href="OrderManagementServlet?action=view&id=${order.orderId}"><i class="fas fa-eye"></i> View</a>
                            <a href="#" class="edit-btn" 
                               data-id="${order.orderId}" 
                               data-status="${order.orderStatus}">
                                <i class="fas fa-edit"></i> Edit
                            </a>                            
                            <a href="OrderManagementServlet?action=delete&id=${order.orderId}" onclick="return confirm('Delete?')"><i class="fas fa-trash"></i> Delete</a>
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
            </div>
        </section>

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

    </body>
</html>
