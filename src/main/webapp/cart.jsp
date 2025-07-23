<%-- 
    Document   : cart
    Created on : May 28, 2025, 2:30:00 PM
    Author     : giahuy
    Redesigned on : June 19, 2025
--%>

<%@page import="Model.Cart"%>
<%@page import="java.util.List"%>
<%@page import="DAO.CartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart - DriverXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            flex: 1 0 auto;
        }
        footer {
            flex-shrink: 0;
        }
        .cart-header {
            text-align: center;
            margin: 60px 0 30px 0;
        }
        .cart-title {
            font-size: 32px;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }
        .cart-subtitle {
            font-size: 13px;
            color: #777;
            font-weight: 300;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }
        .cart-section {
            max-width: 1280px;
            margin: 0 auto 30px auto;
            padding: 0 15px;
        }
        .cart-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 30px;
            align-items: start;
            background: #fcfcfc;
            border: 1px solid #f0f0f0;
            border-radius: 4px;
            padding: 30px 40px;
        }
        .cart-items-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .cart-item-card {
            border: 1px solid #eee;
            border-radius: 2px;
            background: #fff;
            display: grid;
            grid-template-columns: 120px 1fr 120px;
            gap: 18px;
            align-items: center;
            padding: 18px 16px;
            transition: border-color 0.2s;
        }
        .cart-item-card:hover {
            border-color: #000;
        }
        .cart-item-img {
            width: 100%;
            height: 90px;
            object-fit: contain;
            background: #f8f8f8;
            border-radius: 2px;
        }
        .cart-item-details {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .cart-item-name {
            font-size: 15px;
            font-weight: 500;
            color: #000;
            margin-bottom: 2px;
            text-decoration: none;
        }
        .cart-item-meta {
            font-size: 12px;
            color: #666;
        }
        .cart-item-price {
            font-size: 15px;
            font-weight: 600;
            color: #000;
        }
        .cart-item-stock {
            font-size: 12px;
            color: #888;
        }
        .cart-item-controls {
            display: flex;
            flex-direction: column;
            gap: 10px;
            align-items: flex-end;
        }
        .quantity-control {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }
        .quantity-btn {
            width: 30px;
            height: 30px;
            background: #fff;
            border: none;
            color: #333;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
        }
        .quantity-btn:disabled {
            background: #eee;
            color: #bbb;
            cursor: not-allowed;
        }
        .quantity-input {
            width: 40px;
            height: 30px;
            border: none;
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            text-align: center;
            font-size: 13px;
            color: #333;
            background: #fff;
        }
        .remove-item-btn {
            background: none;
            border: none;
            color: #666;
            font-size: 12px;
            cursor: pointer;
            padding: 0;
        }
        .remove-item-btn:hover {
            color: #000;
        }
        .cart-summary {
            background: #fff;
            border-radius: 8px;
            border: 1px solid #eee;
            padding: 24px 20px;
            position: sticky;
            top: 20px;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }
        .summary-title {
            font-size: 14px;
            font-weight: 500;
            color: #333;
            margin-bottom: 10px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #666;
            margin-bottom: 6px;
        }
        .summary-row.total {
            font-size: 15px;
            font-weight: 600;
            color: #000;
            margin-top: 10px;
            padding-top: 10px;
            border-top: 1px solid #eee;
        }
        .checkout-btn, .continue-shopping-btn {
            width: 100%;
            height: 40px;
            border: none;
            font-size: 13px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .checkout-btn {
            background: #000;
            color: #fff;
            margin-bottom: 10px;
        }
        .checkout-btn:hover {
            background: #333;
        }
        .continue-shopping-btn {
            background: #fff;
            border: 1px solid #ddd;
            color: #333;
        }
        .continue-shopping-btn:hover {
            border-color: #000;
            color: #000;
        }
        .cart-empty {
            text-align: center;
            padding: 60px 0;
            color: #888;
            font-size: 18px;
        }
        @media (max-width: 1200px) {
            .cart-grid {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 768px) {
            .cart-grid {
                grid-template-columns: 1fr;
                padding: 20px 10px;
            }
            .cart-item-card {
                grid-template-columns: 80px 1fr;
                gap: 10px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="container" style="padding-top:100px;">
    <div class="cart-header">
        <h1 class="cart-title">Your Cart</h1>
        <p class="cart-subtitle">Review and manage your selected parts.</p>
    </div>
    <section class="cart-section">
        <c:if test="${not empty partList}">
            <div class="cart-grid">
                <div>
                    <div class="cart-items-list">
                        <c:forEach var="item" items="${partList}">
                            <div class="cart-item-card">
                                <div>
                                    <img src="${pageContext.request.contextPath}/asset/img/parts/${item.partImg}" class="cart-item-img" alt="${item.partName}">
                                </div>
                                <div class="cart-item-details">
                                    <a class="cart-item-name" href="${pageContext.request.contextPath}/part/detail?id=${item.partId}">${item.partName}</a>
                                    <div class="cart-item-meta">${item.partBrand} • ${item.carModel}</div>
                                    <div class="cart-item-price">
                                        <fmt:formatNumber value="${item.partPrice}" type="currency" currencySymbol="$"/>
                                    </div>
                                    <div class="cart-item-stock">
                                        Stock: ${item.partStock}
                                    </div>
                                </div>
                                <div class="cart-item-controls">
                                    <form method="post" action="cart" style="display:inline;">
                                        <input type="hidden" name="partId" value="${item.partId}">
                                        <input type="hidden" name="action" value="decrease">
                                        <button type="submit" class="quantity-btn">-</button>
                                    </form>
                                    <input type="text" class="quantity-input" value="${item.quantityInCart}" readonly>
                                    <form method="post" action="cart" style="display:inline;">
                                        <input type="hidden" name="partId" value="${item.partId}">
                                        <input type="hidden" name="action" value="increase">
                                        <button type="submit" class="quantity-btn" <c:if test="${item.partStock <= 0}">disabled</c:if>>+</button>
                                    </form>
                                    <form method="post" action="cart" style="display:inline;">
                                        <input type="hidden" name="partId" value="${item.partId}">
                                        <input type="hidden" name="action" value="remove">
                                        <button type="submit" class="remove-item-btn">Remove</button>
                                    </form>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div>
                    <div class="cart-summary">
                        <div class="summary-title">Order Summary</div>
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span><fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="$"/></span>
                        </div>
                        <div class="summary-row total">
                            <span>Total</span>
                            <span><fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="$"/></span>
                        </div>
                        <form method="get" action="checkout" style="margin-bottom:10px;">
                            <button type="submit" class="checkout-btn">Proceed to Checkout</button>
                        </form>
                        <a href="${pageContext.request.contextPath}/parts" class="continue-shopping-btn">Continue Shopping</a>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${empty partList}">
            <div class="cart-empty">
                <i class="fas fa-shopping-cart empty-icon" style="font-size:36px;"></i>
                <div>Your cart is empty.</div>
                <a href="${pageContext.request.contextPath}/parts" class="continue-shopping-btn" style="margin-top:20px;max-width:200px;">Shop Now</a>
            </div>
        </c:if>
    </section>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html>