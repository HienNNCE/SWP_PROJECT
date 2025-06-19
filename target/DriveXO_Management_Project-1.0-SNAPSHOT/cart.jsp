<%-- 
    Document   : cart
    Created on : May 28, 2025, 2:30:00 PM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Cart - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .cart-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .cart-wrapper {
                display: grid;
                grid-template-columns: 3fr 1fr;
                gap: 30px;
            }
            
            @media (max-width: 992px) {
                .cart-wrapper {
                    grid-template-columns: 1fr;
                }
            }
            
            .cart-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                padding: 25px;
                margin-bottom: 30px;
            }
            
            .cart-card-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                color: #333;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .title-with-count {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .item-count {
                background-color: var(--primary-color);
                color: white;
                font-size: 14px;
                width: 24px;
                height: 24px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            
            .clear-cart {
                color: #dc3545;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                background: none;
                border: none;
            }
            
            .clear-cart:hover {
                text-decoration: underline;
            }
            
            .cart-empty {
                text-align: center;
                padding: 60px 20px;
            }
            
            .empty-icon {
                font-size: 80px;
                color: #ddd;
                margin-bottom: 20px;
            }
            
            .empty-message {
                font-size: 24px;
                color: #666;
                margin-bottom: 30px;
            }
            
            .continue-shopping {
                display: inline-block;
                padding: 12px 30px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            
            .continue-shopping:hover {
                background-color: var(--secondary-color);
            }
            
            .cart-items {
                margin-bottom: 20px;
            }
            
            .cart-item {
                display: flex;
                gap: 20px;
                padding: 20px 0;
                border-bottom: 1px solid #eee;
                position: relative;
            }
            
            .cart-item:last-child {
                border-bottom: none;
            }
            
            .item-image {
                width: 120px;
                height: 90px;
                border-radius: 5px;
                overflow: hidden;
                background-color: #f8f9fa;
            }
            
            .item-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .item-details {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 5px;
            }
            
            .item-name {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 0;
                text-decoration: none;
            }
            
            .item-name:hover {
                color: var(--primary-color);
            }
            
            .item-brand {
                color: #6c757d;
                font-size: 14px;
                margin: 0;
            }
            
            .item-meta {
                margin-top: 10px;
                display: flex;
                gap: 15px;
            }
            
            .meta-item {
                display: block;
                font-size: 13px;
                color: #6c757d;
            }
            
            .meta-item span {
                font-weight: 600;
            }
            
            .item-price {
                font-weight: 700;
                font-size: 18px;
                color: var(--primary-color);
                margin-top: auto;
            }
            
            .item-controls {
                display: flex;
                align-items: center;
                gap: 15px;
                flex-direction: column;
                justify-content: center;
            }
            
            .quantity-control {
                display: flex;
                align-items: center;
                border: 1px solid #ddd;
                border-radius: 4px;
                overflow: hidden;
            }
            
            .quantity-btn {
                width: 30px;
                height: 30px;
                border: none;
                background-color: #f8f9fa;
                color: #555;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 0;
            }
            
            .quantity-btn:hover {
                background-color: #e9ecef;
            }
            
            .quantity-input {
                width: 40px;
                height: 30px;
                border: none;
                text-align: center;
                font-size: 14px;
                font-weight: 600;
                color: #333;
            }
            
            .remove-item {
                color: #dc3545;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s;
                text-align: center;
                padding: 5px 0;
            }
            
            .remove-item:hover {
                text-decoration: underline;
            }
            
            .cart-summary {
                position: sticky;
                top: 20px;
            }
            
            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 15px;
                font-size: 16px;
            }
            
            .summary-row.total {
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #eee;
                font-size: 20px;
                font-weight: 700;
            }
            
            .summary-row.total .summary-value {
                color: var(--primary-color);
            }
            
            .checkout-btn {
                display: block;
                width: 100%;
                padding: 15px;
                background-color: var(--primary-color);
                color: white;
                text-align: center;
                border: none;
                border-radius: 5px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s;
                margin-top: 20px;
            }
            
            .checkout-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .continue-shopping-btn {
                display: block;
                width: 100%;
                padding: 15px;
                background-color: transparent;
                color: #333;
                text-align: center;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-weight: 600;
                font-size: 16px;
                cursor: pointer;
                transition: all 0.3s;
                margin-top: 15px;
                text-decoration: none;
            }
            
            .continue-shopping-btn:hover {
                background-color: #f8f9fa;
            }
            
            .coupon-form {
                display: flex;
                gap: 10px;
                margin-top: 20px;
            }
            
            .coupon-input {
                flex: 1;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
            }
            
            .apply-coupon {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 12px 15px;
                border-radius: 5px;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s;
                white-space: nowrap;
            }
            
            .apply-coupon:hover {
                background-color: var(--secondary-color);
            }
            
            .promotion-code {
                margin-top: 25px;
                background-color: #f8f9fa;
                border: 1px dashed #ccc;
                padding: 15px;
                border-radius: 5px;
                position: relative;
            }
            
            .promotion-title {
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .promotion-title i {
                color: var(--primary-color);
            }
            
            .promotion-code p {
                margin: 0;
                font-size: 14px;
                color: #555;
            }
            
            .similar-products {
                margin-top: 40px;
            }
            
            .similar-products-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                color: #333;
            }
            
            .product-cards {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 20px;
            }
            
            .product-card {
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                transition: transform 0.3s, box-shadow 0.3s;
            }
            
            .product-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 15px rgba(0,0,0,0.1);
            }
            
            .product-image {
                height: 180px;
                overflow: hidden;
            }
            
            .product-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s;
            }
            
            .product-card:hover .product-image img {
                transform: scale(1.05);
            }
            
            .product-content {
                padding: 15px;
            }
            
            .product-title {
                font-weight: 600;
                color: #333;
                margin: 0 0 5px;
                font-size: 16px;
                text-decoration: none;
            }
            
            .product-title:hover {
                color: var(--primary-color);
            }
            
            .product-brand {
                color: #6c757d;
                font-size: 13px;
                margin-bottom: 10px;
            }
            
            .product-price {
                color: var(--primary-color);
                font-weight: 700;
                font-size: 16px;
                margin: 0;
            }
            
            @media (max-width: 768px) {
                .cart-item {
                    flex-direction: column;
                    gap: 15px;
            }
            
                .item-image {
                    width: 100%;
                    height: 180px;
                }
                
                .item-controls {
                    flex-direction: row;
                    justify-content: space-between;
                    width: 100%;
                }
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <h1>Your Shopping Cart</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Cart</span>
                </div>
            </div>
        </section>

        <!-- Cart Section -->
        <section class="cart-section">
            <div class="container">
                <!-- Check if cart is empty -->
                <c:if test="${empty cartItems}">
                    <div class="cart-card">
                        <div class="cart-empty">
                            <i class="fas fa-shopping-cart empty-icon"></i>
                            <h2 class="empty-message">Your cart is empty</h2>
                            <p>Looks like you haven't added any vehicles to your cart yet.</p>
                            <a href="car/list" class="continue-shopping">Continue Shopping</a>
                        </div>
                    </div>
                </c:if>
                
                <!-- If cart is not empty -->
                <c:if test="${not empty cartItems}">
                    <div class="cart-wrapper">
                        <div class="cart-content">
                            <div class="cart-card">
                                <div class="cart-card-title">
                                    <div class="title-with-count">
                                        <span>Shopping Cart</span>
                                        <span class="item-count">2</span>
                                    </div>
                                    <button class="clear-cart">Clear Cart</button>
                                </div>
                                
                                <div class="cart-items">
                                    <!-- Cart Item 1 -->
                                                <div class="cart-item">
                                        <div class="item-image">
                                                        <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                                    </div>
                                                    <div class="item-details">
                                            <a href="car/detail?id=1" class="item-name">Chevrolet CamFó Explorer</a>
                                            <p class="item-brand">Chevrolet</p>
                                            <div class="item-meta">
                                                <span class="meta-item">Color: <span>Silver Metallic</span></span>
                                                <span class="meta-item">Interior: <span>Black Leather</span></span>
                                                <span class="meta-item">Year: <span>2025</span></span>
                                            </div>
                                            <div class="item-price">$120,000.00</div>
                                        </div>
                                        <div class="item-controls">
                                            <div class="quantity-control">
                                                <button class="quantity-btn decrease-qty"><i class="fas fa-minus"></i></button>
                                                <input type="text" value="1" class="quantity-input" readonly>
                                                <button class="quantity-btn increase-qty"><i class="fas fa-plus"></i></button>
                                            </div>
                                            <div class="remove-item">
                                                <i class="fas fa-trash"></i> Remove
                                                    </div>
                                                </div>
                                                </div>
                                    
                                    <!-- Cart Item 2 -->
                                                <div class="cart-item">
                                        <div class="item-image">
                                                        <img src="asset/img/cars/alfa-romeo.png" alt="Nissan Alfa Romeo">
                                                    </div>
                                                    <div class="item-details">
                                            <a href="car/detail?id=2" class="item-name">Nissan Alfa Romeo</a>
                                            <p class="item-brand">Nissan</p>
                                            <div class="item-meta">
                                                <span class="meta-item">Color: <span>Deep Blue</span></span>
                                                <span class="meta-item">Interior: <span>Beige Leather</span></span>
                                                <span class="meta-item">Year: <span>2024</span></span>
                                            </div>
                                            <div class="item-price">$180,000.00</div>
                                        </div>
                                        <div class="item-controls">
                                            <div class="quantity-control">
                                                <button class="quantity-btn decrease-qty"><i class="fas fa-minus"></i></button>
                                                <input type="text" value="1" class="quantity-input" readonly>
                                                <button class="quantity-btn increase-qty"><i class="fas fa-plus"></i></button>
                                            </div>
                                            <div class="remove-item">
                                                <i class="fas fa-trash"></i> Remove
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Similar Products -->
                            <div class="similar-products">
                                <h3 class="similar-products-title">You May Also Like</h3>
                                <div class="product-cards">
                                    <!-- Product 1 -->
                                    <div class="product-card">
                                        <div class="product-image">
                                            <img src="asset/img/cars/corvette-z51.png" alt="Honda Shevrolet Corvette Z51">
                                        </div>
                                        <div class="product-content">
                                            <a href="car/detail?id=3" class="product-title">Honda Shevrolet Corvette Z51</a>
                                            <div class="product-brand">Honda</div>
                                            <div class="product-price">$90,000.00</div>
                                        </div>
                                    </div>
                                    
                                    <!-- Product 2 -->
                                    <div class="product-card">
                                        <div class="product-image">
                                            <img src="asset/img/cars/bmw-portofino.png" alt="BMW Camé Ferrari Portofino">
                                        </div>
                                        <div class="product-content">
                                            <a href="car/detail?id=4" class="product-title">BMW Camé Ferrari Portofino</a>
                                            <div class="product-brand">BMW</div>
                                            <div class="product-price">$150,000.00</div>
                                                    </div>
                                                </div>
                                    
                                    <!-- Product 3 -->
                                    <div class="product-card">
                                        <div class="product-image">
                                            <img src="asset/img/cars/atra-benz-black.png" alt="Hyundai Altra Benz C-Class">
                                        </div>
                                        <div class="product-content">
                                            <a href="car/detail?id=5" class="product-title">Hyundai Altra Benz C-Class</a>
                                            <div class="product-brand">Hyundai</div>
                                            <div class="product-price">$75,000.00</div>
                                        </div>
                                                </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Cart Summary -->
                        <div class="cart-summary-container">
                            <div class="cart-card cart-summary">
                                <h3 class="cart-card-title">Order Summary</h3>
                                <div class="summary-details">
                                <div class="summary-row">
                                        <span class="summary-label">Subtotal (2 items)</span>
                                        <span class="summary-value">$300,000.00</span>
                                </div>
                                <div class="summary-row">
                                        <span class="summary-label">Shipping</span>
                                        <span class="summary-value">Free</span>
                                </div>
                                <div class="summary-row">
                                        <span class="summary-label">Estimated Tax</span>
                                        <span class="summary-value">$30,000.00</span>
                                </div>
                                <div class="summary-row total">
                                        <span class="summary-label">Total</span>
                                        <span class="summary-value">$330,000.00</span>
                                    </div>
                                </div>
                                
                                <div class="coupon-form">
                                    <input type="text" class="coupon-input" placeholder="Enter coupon code">
                                        <button class="apply-coupon">Apply</button>
                                </div>
                                
                                <div class="promotion-code">
                                    <div class="promotion-title">
                                        <i class="fas fa-tag"></i> Available Promotions
                                    </div>
                                    <p>Use code <strong>NEWUSER10</strong> for 10% off your first purchase</p>
                                </div>
                                
                                <a href="checkout" class="checkout-btn">Proceed to Checkout</a>
                                <a href="car/list" class="continue-shopping-btn">Continue Shopping</a>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Quantity control functionality
                const decreaseBtns = document.querySelectorAll('.decrease-qty');
                const increaseBtns = document.querySelectorAll('.increase-qty');
                const quantityInputs = document.querySelectorAll('.quantity-input');
                const removeItemBtns = document.querySelectorAll('.remove-item');
                const clearCartBtn = document.querySelector('.clear-cart');
                const applyCouponBtn = document.querySelector('.apply-coupon');
                
                // Decrease quantity
                decreaseBtns.forEach((btn, index) => {
                    btn.addEventListener('click', function() {
                        let currentValue = parseInt(quantityInputs[index].value);
                        if (currentValue > 1) {
                            quantityInputs[index].value = currentValue - 1;
                            updateCart();
                        }
                    });
                });
                
                // Increase quantity
                increaseBtns.forEach((btn, index) => {
                    btn.addEventListener('click', function() {
                        let currentValue = parseInt(quantityInputs[index].value);
                        quantityInputs[index].value = currentValue + 1;
                        updateCart();
                    });
                });
                
                // Remove item
                removeItemBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        if (confirm('Are you sure you want to remove this item from your cart?')) {
                            this.closest('.cart-item').remove();
                            updateCart();
                            
                            // Check if cart is empty after removal
                            const remainingItems = document.querySelectorAll('.cart-item');
                            if (remainingItems.length === 0) {
                                window.location.reload(); // Reload to show empty cart state
                            }
                        }
                    });
                });
                
                // Clear cart
                if (clearCartBtn) {
                    clearCartBtn.addEventListener('click', function() {
                        if (confirm('Are you sure you want to clear your entire cart?')) {
                            window.location.reload(); // In a real app, you would send a request to clear the cart
                        }
                    });
                }
                
                // Apply coupon
                if (applyCouponBtn) {
                    applyCouponBtn.addEventListener('click', function() {
                        const couponInput = document.querySelector('.coupon-input');
                        const couponCode = couponInput.value.trim();
                        
                        if (!couponCode) {
                            alert('Please enter a coupon code');
                            return;
                        }
                        
                        // In a real app, you would validate the coupon with the server
                        if (couponCode.toUpperCase() === 'NEWUSER10') {
                            alert('Coupon applied successfully! You got 10% off.');
                            // Update the summary (this would be handled by the server in a real app)
                            document.querySelector('.summary-row.total .summary-value').textContent = '$297,000.00';
                        } else {
                            alert('Invalid coupon code');
                        }
                    });
                }
                
                // Update cart function (would typically send updates to the server)
                function updateCart() {
                    console.log('Cart updated');
                    // In a real app, you would make an AJAX request to update the cart on the server
                }
            });
        </script>
    </body>
</html> 