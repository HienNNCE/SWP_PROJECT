<%-- 
    Document   : cart
    Created on : May 28, 2025, 2:30:00 PM
    Author     : giahuy
    Redesigned on : June 19, 2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Cart - DriverXO</title>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <!-- Google Fonts - Inter -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', sans-serif;
                margin: 0;
                padding: 0;
                background: #f8f8f8;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            /* Breadcrumb */
            .breadcrumb {
                padding: 20px 0;
                font-size: 13px;
                color: #666;
            }

            .breadcrumb a {
                color: #000;
                text-decoration: none;
                transition: color 0.2s;
            }

            .breadcrumb a:hover {
                color: #333;
            }

            .breadcrumb span {
                margin: 0 8px;
            }

            /* Cart Section */
            .cart-section {
                padding: 40px 0;
            }

            .cart-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .cart-title {
                font-size: 28px;
                font-weight: 500;
                margin: 0;
                color: #000;
            }

            .cart-subtitle {
                font-size: 14px;
                color: #666;
                margin-top: 8px;
            }

            /* Cart Wrapper */
            .cart-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 20px;
            }

            /* Cart Items */
            .cart-items-container {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 20px;
            }

            .cart-items-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .cart-items-title {
                font-size: 14px;
                font-weight: 500;
                color: #333;
            }

            .items-count {
                background: #000;
                color: #fff;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 12px;
                margin-left: 8px;
            }

            .clear-cart-btn {
                background: none;
                border: none;
                color: #666;
                font-size: 12px;
                cursor: pointer;
                transition: color 0.2s;
            }

            .clear-cart-btn:hover {
                color: #000;
            }

            /* Cart Item */
            .cart-item {
                display: grid;
                grid-template-columns: 100px 1fr auto;
                gap: 15px;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
            }

            .cart-item:last-child {
                border-bottom: none;
            }

            .item-image {
                width: 100px;
                height: 75px;
                overflow: hidden;
                border-radius: 4px;
            }

            .item-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s;
            }

            .cart-item:hover .item-image img {
                transform: scale(1.05);
            }

            .item-details {
                display: flex;
                flex-direction: column;
            }

            .item-name {
                font-size: 15px;
                font-weight: 500;
                color: #000;
                text-decoration: none;
                margin-bottom: 5px;
            }

            .item-name:hover {
                text-decoration: underline;
            }

            .item-brand {
                font-size: 12px;
                color: #666;
                text-transform: uppercase;
                margin-bottom: 8px;
            }

            .item-meta {
                display: flex;
                gap: 15px;
                font-size: 12px;
                color: #666;
            }

            .item-price {
                font-size: 14px;
                font-weight: 500;
                color: #000;
                margin-top: 8px;
            }

            .item-controls {
                display: flex;
                flex-direction: column;
                align-items: flex-end;
                gap: 10px;
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
            }

            .quantity-btn:hover {
                background: #f0f0f0;
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
            }

            .remove-item {
                background: none;
                border: none;
                color: #666;
                font-size: 12px;
                cursor: pointer;
            }

            .remove-item:hover {
                color: #000;
            }

            /* Cart Summary */
            .cart-summary {
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                padding: 20px;
                position: sticky;
                top: 20px;
            }

            .summary-title {
                font-size: 14px;
                font-weight: 500;
                color: #333;
                margin-bottom: 15px;
            }

            .summary-row {
                display: flex;
                justify-content: space-between;
                font-size: 13px;
                color: #666;
                margin-bottom: 10px;
            }

            .summary-row.total {
                font-size: 14px;
                font-weight: 600;
                color: #000;
                margin-top: 15px;
                padding-top: 10px;
                border-top: 1px solid #eee;
            }

            .coupon-form {
                display: flex;
                margin: 15px 0;
            }

            .coupon-input {
                flex: 1;
                height: 36px;
                border: 1px solid #ddd;
                border-right: none;
                padding: 0 10px;
                font-size: 13px;
                border-radius: 4px 0 0 4px;
            }

            .coupon-input:focus {
                outline: none;
                border-color: #000;
            }

            .apply-coupon {
                height: 36px;
                padding: 0 15px;
                border: 1px solid #000;
                background: #000;
                color: #fff;
                font-size: 12px;
                border-radius: 0 4px 4px 0;
                cursor: pointer;
            }

            .apply-coupon:hover {
                background: #333;
            }

            .checkout-btn, .continue-shopping {
                width: 100%;
                height: 40px;
                border: none;
                font-size: 13px;
                text-align: center;
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

            .continue-shopping {
                background: #fff;
                border: 1px solid #ddd;
                color: #333;
            }

            .continue-shopping:hover {
                border-color: #000;
                color: #000;
            }

            /* Cart Empty */
            .cart-empty {
                text-align: center;
                padding: 40px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .empty-icon {
                font-size: 36px;
                color: #ccc;
                margin-bottom: 20px;
            }

            .empty-message {
                font-size: 18px;
                font-weight: 500;
                color: #333;
                margin-bottom: 10px;
            }

            .empty-text {
                font-size: 13px;
                color: #666;
                margin-bottom: 20px;
            }

            .shop-now-btn {
                display: inline-block;
                padding: 10px 20px;
                background: #000;
                color: #fff;
                font-size: 13px;
                text-decoration: none;
                border-radius: 4px;
            }

            .shop-now-btn:hover {
                background: #333;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .cart-wrapper {
                    grid-template-columns: 1fr;
                }

                .cart-summary {
                    position: static;
                }
            }

            @media (max-width: 768px) {
                .cart-item {
                    grid-template-columns: 80px 1fr;
                    gap: 10px;
                }

                .item-controls {
                    grid-column: 1 / -1;
                    flex-direction: row;
                    justify-content: space-between;
                    margin-top: 10px;
                }
            }

            @media (max-width: 576px) {
                .cart-title {
                    font-size: 24px;
                }

                .cart-item {
                    grid-template-columns: 1fr;
                }

                .item-image {
                    width: 100%;
                    height: 150px;
                }
            }
        </style>
    </head>
    <body>
        <!-- Breadcrumb -->
        <div class="container">
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <span><i class="fas fa-angle-right"></i></span>
                <span>Cart</span>
            </div>
        </div>

        <!-- Cart Section -->
        <section class="cart-section">
            <div class="container">
                <div class="cart-header">
                    <h2 class="cart-title">Your Cart</h2>
                    <p class="cart-subtitle">Review your selected vehicles</p>
                </div>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="cart-empty">
                            <i class="fas fa-shopping-cart empty-icon"></i>
                            <h3 class="empty-message">Your Cart is Empty</h3>
                            <p class="empty-text">Explore our collection to find your perfect vehicle.</p>
                            <a href="${pageContext.request.contextPath}/car/list" class="shop-now-btn">Shop Now</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="cart-wrapper">
                            <!-- Cart Items -->
                            <div class="cart-items-container">
                                <div class="cart-items-header">
                                    <h3 class="cart-items-title">
                                        Cart Items <span class="items-count">${cartItems.size()}</span>
                                    </h3>
                                    <button class="clear-cart-btn">Clear Cart</button>
                                </div>

                                <div class="cart-items">
                                    <c:forEach var="item" items="${cartItems}">
                                        <div class="cart-item">
                                            <div class="item-image">
                                                <img src="${pageContext.request.contextPath}/asset/img/cars/${not empty item.car.carImg ? item.car.carImg : item.car.carBrand.toLowerCase().replaceAll(' ', '_').concat('_').concat(item.car.carName.toLowerCase().replaceAll(' ', '_')).concat('.webp')}" 
                                                     onerror="this.src='${pageContext.request.contextPath}/asset/img/cars/default-car.png'" 
                                                     alt="${item.car.carName}">
                                            </div>
                                            <div class="item-details">
                                                <a href="${pageContext.request.contextPath}/car/detail?id=${item.car.carId}" class="item-name">${item.car.carYear.getYear() + 1900} ${item.car.carName}</a>
                                                <div class="item-brand">${item.car.carBrand}</div>
                                                <div class="item-meta">
                                                    <span class="meta-item">Fuel: <span>${item.car.fuelType}</span></span>
                                                    <span class="meta-item">Odo: <span><fmt:formatNumber value="${item.car.carOdo}" pattern="#,###"/> mi</span></span>
                                                </div>
                                                <div class="item-price">$<fmt:formatNumber value="${item.car.carPrice * item.quantity}" pattern="#,###.00"/></div>
                                            </div>
                                            <div class="item-controls">
                                                <div class="quantity-control">
                                                    <button class="quantity-btn decrease-qty" data-id="${item.car.carId}"><i class="fas fa-minus"></i></button>
                                                    <input type="text" value="${item.quantity}" class="quantity-input" readonly>
                                                    <button class="quantity-btn increase-qty" data-id="${item.car.carId}"><i class="fas fa-plus"></i></button>
                                                </div>
                                                <button class="remove-item" data-id="${item.car.carId}">
                                                    <i class="fas fa-trash-alt"></i> Remove
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Order Summary -->
                            <div class="cart-summary">
                                <h3 class="summary-title">Order Summary</h3>
                                <div class="summary-row">
                                    <span class="summary-label">Subtotal (${cartItems.size()} items)</span>
                                    <span class="summary-value">$<fmt:formatNumber value="${cartItems.stream().sum(car -> car.car.carPrice * car.quantity)}" pattern="#,###.00"/></span>
                                </div>
                                <div class="summary-row">
                                    <span class="summary-label">Shipping</span>
                                    <span class="summary-value">Free</span>
                                </div>
                                <div class="summary-row">
                                    <span class="summary-label">Estimated Tax</span>
                                    <span class="summary-value">$<fmt:formatNumber value="${cartItems.stream().sum(car -> car.car.carPrice * car.quantity) * 0.1}" pattern="#,###.00"/></span>
                                </div>
                                <div class="summary-row total">
                                    <span class="summary-label">Total</span>
                                    <span class="summary-value">$<fmt:formatNumber value="${cartItems.stream().sum(car -> car.car.carPrice * car.quantity) * 1.1}" pattern="#,###.00"/></span>
                                </div>

                                <div class="coupon-form">
                                    <input type="text" class="coupon-input" placeholder="Coupon Code">
                                    <button class="apply-coupon">Apply</button>
                                </div>

                                <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">Proceed to Checkout</a>
                                <a href="${pageContext.request.contextPath}/car/list" class="continue-shopping">Continue Shopping</a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Quantity control
                document.querySelectorAll('.decrease-qty').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const input = this.nextElementSibling;
                        const carId = this.dataset.id;
                        let value = parseInt(input.value);
                        if (value > 1) {
                            input.value = value - 1;
                            updateCart(carId, value - 1);
                        }
                    });
                });

                document.querySelectorAll('.increase-qty').forEach(btn => {
                    btn.addEventListener('click', function() {
                        const input = this.previousElementSibling;
                        const carId = this.dataset.id;
                        let value = parseInt(input.value);
                        input.value = value + 1;
                        updateCart(carId, value + 1);
                    });
                });

                // Remove item
                document.querySelectorAll('.remove-item').forEach(btn => {
                    btn.addEventListener('click', function() {
                        if (confirm('Remove this item from your cart?')) {
                            const carId = this.dataset.id;
                            fetch(`${pageContext.request.contextPath}/cart/remove?id=${carId}`, { method: 'POST' })
                                .then(() => window.location.reload());
                        }
                    });
                });

                // Clear cart
                const clearCartBtn = document.querySelector('.clear-cart-btn');
                if (clearCartBtn) {
                    clearCartBtn.addEventListener('click', function() {
                        if (confirm('Clear your entire cart?')) {
                            fetch(`${pageContext.request.contextPath}/cart/clear`, { method: 'POST' })
                                .then(() => window.location.reload());
                        }
                    });
                }

                // Apply coupon
                const applyCouponBtn = document.querySelector('.apply-coupon');
                if (applyCouponBtn) {
                    applyCouponBtn.addEventListener('click', function() {
                        const couponInput = document.querySelector('.coupon-input');
                        const couponCode = couponInput.value.trim();
                        if (!couponCode) {
                            alert('Please enter a coupon code');
                            return;
                        }
                        // Simulate coupon application
                        if (couponCode.toUpperCase() === 'NEWUSER10') {
                            alert('Coupon applied: 10% off');
                            // Update total would go here
                        } else {
                            alert('Invalid coupon code');
                        }
                    });
                }

                // Update cart
                function updateCart(carId, quantity) {
                    fetch(`${pageContext.request.contextPath}/cart/update`, {
                        method: 'POST',
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: `id=${carId}&quantity=${quantity}`
                    }).then(() => window.location.reload());
                }
            });
        </script>
    </body>
</html>