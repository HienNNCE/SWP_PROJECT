<%-- 
    Document   : order
    Created on : Jun 10, 2025, 1:43:59 AM
    Author     : Alienware
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Orders - DriveXO</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="asset/css/style.css">
    <link rel="stylesheet" href="asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .orders-header {
            text-align: center;
            margin: 60px 0 30px 0;
        }
        .orders-title {
            font-size: 2.1rem;
            font-weight: 400;
            letter-spacing: 1px;
            margin-bottom: 10px;
            color: #222;
            text-transform: none;
        }
        .orders-subtitle {
            font-size: 14px;
            color: #888;
            font-weight: 300;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }
        .orders-table-section {
            max-width: 1100px;
            margin: 0 auto 60px auto;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 18px rgba(0,0,0,0.06);
            padding: 40px 30px;
        }
        .orders-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 4px rgba(0,0,0,0.03);
        }
        .orders-table th, .orders-table td {
            padding: 16px 12px;
            text-align: left;
        }
        .orders-table th {
            background: #fafbfc;
            color: #222;
            font-size: 15px;
            font-weight: 500;
            border-bottom: 1px solid #f0f0f0;
        }
        .orders-table tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background 0.18s;
        }
        .orders-table tr:last-child {
            border-bottom: none;
        }
        .orders-table tr:hover {
            background: #f6f6f6;
        }
        .orders-table td {
            font-size: 15px;
            color: #333;
        }
        .order-status {
            display: inline-block;
            padding: 7px 18px;
            border-radius: 30px;
            font-weight: 500;
            font-size: 14px;
            background: #f3f3f3;
            color: #444;
            border: 1px solid #ededed;
        }
        .status-paid {
            color: #219150 !important;
            background: #eafaf1 !important;
            border: 1px solid #b6e5ce;
        }
        .status-processing,
        .status-shipped,
        .status-delivered,
        .status-cancelled {
            background: #f3f3f3 !important;
            color: #444 !important;
            border: 1px solid #ededed;
        }
        .cancel-btn {
            display: inline-block;
            padding: 6px 18px;
            border-radius: 20px;
            background: #fff;
            color: #b02a37;
            border: 1px solid #b02a37;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.18s, color 0.18s;
            margin-left: 4px;
        }
        .cancel-btn:hover {
            background: #b02a37;
            color: #fff;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #222;
            font-weight: 500;
            transition: color 0.2s;
        }
        .action-links a:last-child {
            margin-right: 0;
        }
        .action-links a:hover {
            color: #000;
        }
        @media (max-width: 900px) {
            .orders-table-section {
                padding: 20px 5px;
            }
            .orders-table th, .orders-table td {
                padding: 10px 6px;
            }
        }
        @media (max-width: 600px) {
            .orders-header {
                margin: 30px 0 18px 0;
            }
            .orders-title {
                font-size: 1.2rem;
            }
            .orders-table-section {
                padding: 10px 2px;
            }
            .orders-table th, .orders-table td {
                font-size: 13px;
                padding: 7px 2px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="container" style="padding-top:100px;">
    <div class="orders-header">
        <h1 class="orders-title"><i class="fas fa-shopping-cart"></i> My Orders</h1>
        <p class="orders-subtitle">View and track all your orders placed on DriveXO.</p>
    </div>
    <section class="orders-table-section">
        <table class="orders-table">
            <tr>
                <th>Order ID</th>
                <th>Price</th>
                <th>Status</th>
                <th>Date</th>
                <th>Action</th>
            </tr>
            <c:forEach var="order" items="${orders}">
                <tr>
                    <td>${order.orderId}</td>
                    <td>$${order.orderPrice}</td>
                    <td>
                        <span class="order-status 
                              <c:choose>
                                  <c:when test="${order.orderStatus eq 'Paid'}">status-paid</c:when>
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
                        <fmt:formatDate value="${order.getOrderDate()}" pattern="yyyy-MM-dd HH:mm"/>
                    </td>
                    <td class="action-links">
                        <a href="order?action=view&id=${order.orderId}"><i class="fas fa-eye"></i> View</a>
                        <c:if test="${order.orderStatus ne 'Cancelled'}">
                            <form method="post" action="order" style="display:inline;">
                                <input type="hidden" name="action" value="cancel" />
                                <input type="hidden" name="orderId" value="${order.orderId}" />
                                <button type="submit" class="cancel-btn" onclick="return confirm('Are you sure you want to cancel this order?');">Cancel</button>
                            </form>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty orders}">
                <tr>
                    <td colspan="5" style="text-align:center; color:#888; padding:60px 0; font-size:18px;">No orders found.</td>
                </tr>
            </c:if>
        </table>
    </section>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html>
