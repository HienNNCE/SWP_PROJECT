<%-- 
    Document   : checkout
    Created on : May 28, 2025, 11:45:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Checkout - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .checkout-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .checkout-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
            }
            
            @media (max-width: 992px) {
                .checkout-wrapper {
                    grid-template-columns: 1fr;
                }
            }
            
            .checkout-steps {
                display: flex;
                margin-bottom: 30px;
                position: relative;
            }
            
            .checkout-steps::after {
                content: "";
                position: absolute;
                top: 25px;
                left: 0;
                right: 0;
                height: 2px;
                background-color: #eee;
                z-index: 1;
            }
            
            .checkout-step {
                flex: 1;
                text-align: center;
                position: relative;
                z-index: 2;
            }
            
            .step-number {
                width: 50px;
                height: 50px;
                margin: 0 auto 10px;
                border-radius: 50%;
                background-color: #f8f9fa;
                border: 2px solid #eee;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                color: #777;
                transition: all 0.3s;
            }
            
            .step-label {
                font-size: 14px;
                color: #777;
                font-weight: 500;
            }
            
            .checkout-step.active .step-number {
                background-color: var(--primary-color);
                border-color: var(--primary-color);
                color: white;
            }
            
            .checkout-step.active .step-label {
                color: var(--primary-color);
                font-weight: 600;
            }
            
            .checkout-step.completed .step-number {
                background-color: var(--success-color);
                border-color: var(--success-color);
                color: white;
            }
            
            .checkout-step.completed .step-number::after {
                content: "✓";
            }
            
            .checkout-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                padding: 25px;
                margin-bottom: 30px;
            }
            
            .checkout-card-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                color: #333;
            }
            
            .form-section {
                margin-bottom: 30px;
            }
            
            .form-section:last-child {
                margin-bottom: 0;
            }
            
            .form-section-title {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 15px;
                color: #333;
            }
            
            .form-row {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
                margin-bottom: 15px;
            }
            
            @media (max-width: 768px) {
                .form-row {
                    grid-template-columns: 1fr;
                }
            }
            
            .form-group {
                margin-bottom: 15px;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #555;
            }
            
            .form-control {
                display: block;
                width: 100%;
                padding: 12px 15px;
                font-size: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: border-color 0.3s;
            }
            
            .form-control:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.15);
            }
            
            .form-check {
                display: flex;
                align-items: center;
                margin-bottom: 10px;
            }
            
            .form-check-input {
                margin-right: 10px;
                width: 18px;
                height: 18px;
            }
            
            .form-check-label {
                font-weight: 500;
                color: #333;
            }
            
            .address-list {
                margin-bottom: 20px;
            }
            
            .address-card {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid #eee;
                transition: all 0.3s;
                position: relative;
            }
            
            .address-card.selected {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.1);
            }
            
            .address-radio {
                position: absolute;
                top: 15px;
                right: 15px;
            }
            
            .address-radio input[type="radio"] {
                width: 18px;
                height: 18px;
            }
            
            .address-details h4 {
                font-size: 16px;
                margin: 0 0 10px;
                padding-right: 30px;
            }
            
            .address-details p {
                margin: 0;
                color: #555;
                font-size: 14px;
                line-height: 1.5;
            }
            
            .add-address-btn {
                display: block;
                width: 100%;
                padding: 12px;
                text-align: center;
                background-color: #f8f9fa;
                border: 2px dashed #ddd;
                border-radius: 8px;
                color: #555;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .add-address-btn:hover {
                background-color: #f0f0f0;
                border-color: #ccc;
            }
            
            .payment-methods {
                margin-bottom: 20px;
            }
            
            .payment-method {
                display: flex;
                align-items: center;
                padding: 15px;
                border: 1px solid #eee;
                border-radius: 8px;
                margin-bottom: 15px;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .payment-method:hover {
                background-color: #f8f9fa;
            }
            
            .payment-method.selected {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.1);
            }
            
            .payment-method-radio {
                margin-right: 15px;
            }
            
            .payment-method-radio input[type="radio"] {
                width: 18px;
                height: 18px;
            }
            
            .payment-method-icon {
                font-size: 20px;
                margin-right: 15px;
                width: 30px;
                text-align: center;
                color: #333;
            }
            
            .payment-method-details {
                flex: 1;
            }
            
            .payment-method-title {
                font-weight: 600;
                color: #333;
                margin: 0 0 5px;
            }
            
            .payment-method-description {
                font-size: 14px;
                color: #777;
                margin: 0;
            }
            
            .credit-card-form {
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #eee;
                display: none;
            }
            
            .credit-card-form.active {
                display: block;
            }
            
            .card-icons {
                display: flex;
                gap: 10px;
                margin-bottom: 15px;
            }
            
            .card-icon {
                font-size: 24px;
            }
            
            .summary-card {
                position: sticky;
                top: 20px;
            }
            
            .order-items {
                margin-bottom: 20px;
            }
            
            .order-item {
                display: flex;
                gap: 15px;
                padding: 15px 0;
                border-bottom: 1px solid #eee;
            }
            
            .order-item:last-child {
                border-bottom: none;
            }
            
            .item-image {
                width: 80px;
                height: 60px;
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
            }
            
            .item-name {
                font-size: 16px;
                font-weight: 500;
                margin-bottom: 5px;
            }
            
            .item-brand {
                font-size: 14px;
                color: #777;
                margin-bottom: 5px;
            }
            
            .item-price {
                font-weight: 600;
                color: #333;
            }
            
            .order-summary {
                margin-top: 20px;
                border-top: 1px solid #eee;
                padding-top: 20px;
            }
            
            .summary-row {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 14px;
            }
            
            .summary-row.total {
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px solid #eee;
                font-size: 18px;
                font-weight: 700;
            }
            
            .summary-row.total .summary-value {
                color: var(--primary-color);
            }
            
            .coupon-form {
                display: flex;
                gap: 10px;
                margin-top: 20px;
                border-top: 1px solid #eee;
                padding-top: 20px;
            }
            
            .coupon-input {
                flex: 1;
                padding: 10px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
            }
            
            .apply-coupon {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                white-space: nowrap;
            }
            
            .apply-coupon:hover {
                background-color: var(--secondary-color);
            }
            
            .checkout-actions {
                display: flex;
                justify-content: space-between;
                margin-top: 30px;
            }
            
            .back-btn {
                padding: 12px 25px;
                background-color: #f8f9fa;
                color: #333;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .back-btn:hover {
                background-color: #f0f0f0;
            }
            
            .continue-btn {
                padding: 12px 25px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 5px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .continue-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .terms-check {
                margin: 20px 0;
            }
            
            /* Order Complete Section */
            .order-complete {
                text-align: center;
            }
            
            .order-complete-icon {
                width: 80px;
                height: 80px;
                background-color: var(--success-color);
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 40px;
                margin: 0 auto 20px;
            }
            
            .order-complete-title {
                font-size: 24px;
                font-weight: 700;
                color: var(--success-color);
                margin-bottom: 15px;
            }
            
            .order-complete-message {
                font-size: 16px;
                color: #555;
                margin-bottom: 30px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .order-details-box {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
                text-align: left;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .detail-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 16px;
            }
            
            .detail-label {
                color: #777;
            }
            
            .detail-value {
                font-weight: 600;
                color: #333;
            }
            
            .action-buttons {
                display: flex;
                gap: 20px;
                justify-content: center;
                margin-top: 30px;
            }
            
            .view-order-btn {
                padding: 12px 25px;
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 5px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s;
            }
            
            .view-order-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .continue-shopping-btn {
                padding: 12px 25px;
                background-color: #f8f9fa;
                color: #333;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-weight: 600;
                text-decoration: none;
                transition: all 0.3s;
            }
            
            .continue-shopping-btn:hover {
                background-color: #f0f0f0;
            }
            
            /* Additional responsive styles */
            @media (max-width: 576px) {
                .checkout-steps {
                    flex-wrap: wrap;
                    gap: 15px;
                }
                
                .checkout-step {
                    flex: none;
                    width: calc(50% - 8px);
                }
                
                .checkout-actions {
                    flex-direction: column;
                    gap: 15px;
                }
                
                .back-btn,
                .continue-btn {
                    width: 100%;
                    justify-content: center;
                }
                
                .action-buttons {
                    flex-direction: column;
                }
                
                .view-order-btn,
                .continue-shopping-btn {
                    width: 100%;
                    text-align: center;
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
                <h1>Checkout</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="cart">Cart</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Checkout</span>
                </div>
            </div>
        </section>

        <!-- Checkout Section -->
        <section class="checkout-section">
            <div class="container">
                <!-- Checkout Steps -->
                <div class="checkout-steps">
                    <div class="checkout-step completed">
                        <div class="step-number">1</div>
                        <div class="step-label">Shopping Cart</div>
                    </div>
                    <div class="checkout-step active">
                        <div class="step-number">2</div>
                        <div class="step-label">Checkout</div>
                    </div>
                    <div class="checkout-step">
                        <div class="step-number">3</div>
                        <div class="step-label">Order Complete</div>
                    </div>
                </div>
                
                <!-- Checkout Content -->
                <div id="checkout-content">
                    <div class="checkout-wrapper">
                        <div class="checkout-form">
                            <!-- Shipping Information -->
                            <div class="checkout-card">
                                <h2 class="checkout-card-title">Shipping Information</h2>
                                <div class="form-section">
                                    <h3 class="form-section-title">Select Shipping Address</h3>
                                    <div class="address-list">
                                        <!-- Default Address -->
                                        <div class="address-card selected">
                                            <div class="address-radio">
                                                <input type="radio" name="shipping_address" id="address-1" value="1" checked>
                                            </div>
                                            <div class="address-details">
                                                <h4>Home Address <span class="badge primary-badge">Default</span></h4>
                                                <p>John Doe<br>
                                                123 Main Street<br>
                                                Apt 4B<br>
                                                New York, NY 10001<br>
                                                United States<br>
                                                Phone: (555) 123-4567</p>
                                            </div>
                                        </div>
                                        
                                        <!-- Secondary Address -->
                                        <div class="address-card">
                                            <div class="address-radio">
                                                <input type="radio" name="shipping_address" id="address-2" value="2">
                                            </div>
                                            <div class="address-details">
                                                <h4>Office Address</h4>
                                                <p>John Doe<br>
                                                456 Business Ave<br>
                                                Suite 200<br>
                                                New York, NY 10018<br>
                                                United States<br>
                                                Phone: (555) 987-6543</p>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <button class="add-address-btn">
                                        <i class="fas fa-plus"></i> Add New Address
                                    </button>
                                </div>
                                
                                <div class="form-section">
                                    <h3 class="form-section-title">Shipping Method</h3>
                                    <div class="form-check">
                                        <input type="radio" name="shipping_method" id="shipping-standard" class="form-check-input" checked>
                                        <label for="shipping-standard" class="form-check-label">Standard Shipping (Free) - 7-10 business days</label>
                                    </div>
                                    <div class="form-check">
                                        <input type="radio" name="shipping_method" id="shipping-express" class="form-check-input">
                                        <label for="shipping-express" class="form-check-label">Express Shipping ($25.00) - 2-3 business days</label>
                                    </div>
                                    <div class="form-check">
                                        <input type="radio" name="shipping_method" id="shipping-priority" class="form-check-input">
                                        <label for="shipping-priority" class="form-check-label">Priority Shipping ($50.00) - Next business day</label>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Payment Information -->
                            <div class="checkout-card">
                                <h2 class="checkout-card-title">Payment Information</h2>
                                <div class="payment-methods">
                                    <!-- Credit Card Payment -->
                                    <div class="payment-method selected">
                                        <div class="payment-method-radio">
                                            <input type="radio" name="payment_method" id="payment-credit-card" value="credit_card" checked>
                                        </div>
                                        <div class="payment-method-icon">
                                            <i class="fas fa-credit-card"></i>
                                        </div>
                                        <div class="payment-method-details">
                                            <h4 class="payment-method-title">Credit / Debit Card</h4>
                                            <p class="payment-method-description">Pay with your credit or debit card</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Credit Card Form -->
                                    <div class="credit-card-form active">
                                        <div class="card-icons">
                                            <i class="fab fa-cc-visa card-icon"></i>
                                            <i class="fab fa-cc-mastercard card-icon"></i>
                                            <i class="fab fa-cc-amex card-icon"></i>
                                            <i class="fab fa-cc-discover card-icon"></i>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="card_number">Card Number</label>
                                                <input type="text" id="card_number" class="form-control" placeholder="1234 5678 9012 3456">
                                            </div>
                                            <div class="form-group">
                                                <label for="card_name">Name on Card</label>
                                                <input type="text" id="card_name" class="form-control" placeholder="John Doe">
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="card_expiry">Expiration Date</label>
                                                <input type="text" id="card_expiry" class="form-control" placeholder="MM/YY">
                                            </div>
                                            <div class="form-group">
                                                <label for="card_cvv">CVV</label>
                                                <input type="text" id="card_cvv" class="form-control" placeholder="123">
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- PayPal Payment -->
                                    <div class="payment-method">
                                        <div class="payment-method-radio">
                                            <input type="radio" name="payment_method" id="payment-paypal" value="paypal">
                                        </div>
                                        <div class="payment-method-icon">
                                            <i class="fab fa-paypal"></i>
                                        </div>
                                        <div class="payment-method-details">
                                            <h4 class="payment-method-title">PayPal</h4>
                                            <p class="payment-method-description">Pay with your PayPal account</p>
                                        </div>
                                    </div>
                                    
                                    <!-- Bank Transfer Payment -->
                                    <div class="payment-method">
                                        <div class="payment-method-radio">
                                            <input type="radio" name="payment_method" id="payment-bank-transfer" value="bank_transfer">
                                        </div>
                                        <div class="payment-method-icon">
                                            <i class="fas fa-university"></i>
                                        </div>
                                        <div class="payment-method-details">
                                            <h4 class="payment-method-title">Bank Transfer</h4>
                                            <p class="payment-method-description">Pay directly from your bank account</p>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="terms-check">
                                    <div class="form-check">
                                        <input type="checkbox" id="terms" class="form-check-input">
                                        <label for="terms" class="form-check-label">I agree to the <a href="#">Terms and Conditions</a> and <a href="#">Privacy Policy</a></label>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="checkout-actions">
                                <a href="cart" class="back-btn"><i class="fas fa-arrow-left"></i> Back to Cart</a>
                                <button id="place-order-btn" class="continue-btn">Place Order <i class="fas fa-arrow-right"></i></button>
                            </div>
                        </div>
                        
                        <div class="order-summary-container">
                            <div class="checkout-card summary-card">
                                <h2 class="checkout-card-title">Order Summary</h2>
                                <div class="order-items">
                                    <div class="order-item">
                                        <div class="item-image">
                                            <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                        </div>
                                        <div class="item-details">
                                            <div class="item-name">Chevrolet CamFó Explorer</div>
                                            <div class="item-brand">Chevrolet</div>
                                            <div class="item-price">$120,000.00</div>
                                        </div>
                                    </div>
                                    <div class="order-item">
                                        <div class="item-image">
                                            <img src="asset/img/cars/alfa-romeo.png" alt="Nissan Alfa Romeo">
                                        </div>
                                        <div class="item-details">
                                            <div class="item-name">Nissan Alfa Romeo</div>
                                            <div class="item-brand">Nissan</div>
                                            <div class="item-price">$180,000.00</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="order-summary">
                                    <div class="summary-row">
                                        <span class="summary-label">Subtotal</span>
                                        <span class="summary-value">$300,000.00</span>
                                    </div>
                                    <div class="summary-row">
                                        <span class="summary-label">Shipping</span>
                                        <span class="summary-value">$0.00</span>
                                    </div>
                                    <div class="summary-row">
                                        <span class="summary-label">Tax (10%)</span>
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
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Order Complete (Hidden by Default) -->
                <div id="order-complete" style="display: none;">
                    <div class="checkout-card">
                        <div class="order-complete">
                            <div class="order-complete-icon">
                                <i class="fas fa-check"></i>
                            </div>
                            <h2 class="order-complete-title">Your Order Has Been Placed Successfully!</h2>
                            <p class="order-complete-message">Thank you for your purchase. Your order has been received and is now being processed. You will receive an order confirmation email shortly with the expected delivery date.</p>
                            
                            <div class="order-details-box">
                                <div class="detail-item">
                                    <span class="detail-label">Order Number:</span>
                                    <span class="detail-value">#ORD123456</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Order Date:</span>
                                    <span class="detail-value">May 28, 2025</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Payment Method:</span>
                                    <span class="detail-value">Credit Card (Visa ending in 1234)</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">Total Amount:</span>
                                    <span class="detail-value">$330,000.00</span>
                                </div>
                            </div>
                            
                            <div class="action-buttons">
                                <a href="order-history" class="view-order-btn">View Your Orders</a>
                                <a href="car/list" class="continue-shopping-btn">Continue Shopping</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Address card selection
                const addressCards = document.querySelectorAll('.address-card');
                const addressRadios = document.querySelectorAll('input[name="shipping_address"]');
                
                addressCards.forEach((card, index) => {
                    card.addEventListener('click', function() {
                        // Remove selected class from all cards
                        addressCards.forEach(c => c.classList.remove('selected'));
                        // Add selected class to clicked card
                        card.classList.add('selected');
                        // Check the corresponding radio button
                        addressRadios[index].checked = true;
                    });
                });
                
                // Payment method selection
                const paymentMethods = document.querySelectorAll('.payment-method');
                const paymentRadios = document.querySelectorAll('input[name="payment_method"]');
                const creditCardForm = document.querySelector('.credit-card-form');
                
                paymentMethods.forEach((method, index) => {
                    method.addEventListener('click', function() {
                        // Remove selected class from all methods
                        paymentMethods.forEach(m => m.classList.remove('selected'));
                        // Add selected class to clicked method
                        method.classList.add('selected');
                        // Check the corresponding radio button
                        paymentRadios[index].checked = true;
                        
                        // Show/hide credit card form
                        if (paymentRadios[index].value === 'credit_card') {
                            creditCardForm.classList.add('active');
                        } else {
                            creditCardForm.classList.remove('active');
                        }
                    });
                });
                
                // Add new address button
                const addAddressBtn = document.querySelector('.add-address-btn');
                if (addAddressBtn) {
                    addAddressBtn.addEventListener('click', function() {
                        // Here you would typically show an address form
                        // For this demo, just show an alert
                        alert('Address form would appear here');
                    });
                }
                
                // Apply coupon button
                const applyCouponBtn = document.querySelector('.apply-coupon');
                if (applyCouponBtn) {
                    applyCouponBtn.addEventListener('click', function() {
                        const couponInput = document.querySelector('.coupon-input');
                        const couponCode = couponInput.value.trim();
                        
                        if (!couponCode) {
                            alert('Please enter a coupon code');
                            return;
                        }
                        
                        // Here you would typically validate the coupon with the server
                        // For this demo, just show an alert
                        alert('Coupon applied successfully!');
                    });
                }
                
                // Place order button
                const placeOrderBtn = document.getElementById('place-order-btn');
                if (placeOrderBtn) {
                    placeOrderBtn.addEventListener('click', function() {
                        // Validate form fields
                        const termsCheckbox = document.getElementById('terms');
                        if (!termsCheckbox.checked) {
                            alert('Please accept the terms and conditions');
                            return;
                        }
                        
                        // If using credit card, validate card details
                        const paymentMethod = document.querySelector('input[name="payment_method"]:checked').value;
                        if (paymentMethod === 'credit_card') {
                            const cardNumber = document.getElementById('card_number').value.trim();
                            const cardName = document.getElementById('card_name').value.trim();
                            const cardExpiry = document.getElementById('card_expiry').value.trim();
                            const cardCvv = document.getElementById('card_cvv').value.trim();
                            
                            if (!cardNumber || !cardName || !cardExpiry || !cardCvv) {
                                alert('Please fill in all card details');
                                return;
                            }
                        }
                        
                        // Show order complete section
                        document.getElementById('checkout-content').style.display = 'none';
                        document.getElementById('order-complete').style.display = 'block';
                        
                        // Update checkout steps
                        document.querySelector('.checkout-step.active').classList.remove('active');
                        document.querySelector('.checkout-step.active').classList.add('completed');
                        document.querySelectorAll('.checkout-step')[2].classList.add('active');
                        
                        // Scroll to top
                        window.scrollTo({
                            top: 0,
                            behavior: 'smooth'
                        });
                    });
                }
            });
        </script>
    </body>
</html> 