<%-- 
    Document   : order-detail
    Created on : May 28, 2025, 1:15:00 PM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Detail - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .order-detail-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .order-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                padding: 25px;
                margin-bottom: 30px;
            }
            
            .order-header {
                display: flex;
                justify-content: space-between;
                margin-bottom: 25px;
                padding-bottom: 20px;
                border-bottom: 1px solid #eee;
                flex-wrap: wrap;
                gap: 20px;
            }
            
            .order-title {
                font-size: 20px;
                font-weight: 600;
                color: #333;
                margin: 0;
            }
            
            .order-id {
                display: block;
                color: var(--primary-color);
                font-weight: 600;
                font-size: 16px;
                margin-top: 5px;
            }
            
            .order-status {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .status-label {
                display: inline-block;
                padding: 8px 15px;
                border-radius: 30px;
                font-weight: 600;
                font-size: 14px;
            }
            
            .status-processing {
                background-color: #ffe9cc;
                color: #ff8c00;
            }
            
            .status-shipped {
                background-color: #cce5ff;
                color: #0066cc;
            }
            
            .status-delivered {
                background-color: #d1e7dd;
                color: #0a5c36;
            }
            
            .status-cancelled {
                background-color: #f8d7da;
                color: #b02a37;
            }
            
            .order-actions {
                display: flex;
                gap: 10px;
            }
            
            .btn {
                padding: 10px 20px;
                font-size: 14px;
                font-weight: 600;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: #fff;
                border: none;
            }
            
            .btn-primary:hover {
                background-color: var(--secondary-color);
            }
            
            .btn-outline {
                background-color: transparent;
                color: #555;
                border: 1px solid #ddd;
            }
            
            .btn-outline:hover {
                background-color: #f8f9fa;
                border-color: #ccc;
            }
            
            .btn-danger {
                background-color: #dc3545;
                color: white;
                border: none;
            }
            
            .btn-danger:hover {
                background-color: #bb2d3b;
            }
            
            .order-info-section {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                margin-bottom: 30px;
            }
            
            @media (max-width: 992px) {
                .order-info-section {
                    grid-template-columns: 1fr 1fr;
                }
            }
            
            @media (max-width: 768px) {
                .order-info-section {
                    grid-template-columns: 1fr;
                }
            }
            
            .info-box {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 15px;
            }
            
            .info-box h3 {
                font-size: 16px;
                color: #555;
                margin: 0 0 10px;
                font-weight: 600;
            }
            
            .info-detail {
                margin: 0;
                line-height: 1.6;
                color: #333;
            }
            
            .tracking-info {
                background-color: #f0f9ff;
                border-left: 4px solid #0d6efd;
                padding: 15px;
                border-radius: 5px;
                margin-bottom: 30px;
            }
            
            .tracking-number {
                font-weight: 600;
                color: #0d6efd;
            }
            
            .tracking-link {
                color: #0d6efd;
                text-decoration: none;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 5px;
                margin-left: 15px;
            }
            
            .tracking-link:hover {
                text-decoration: underline;
            }
            
            .tracking-status {
                font-style: italic;
                color: #6c757d;
                margin: 8px 0 0;
            }
            
            .section-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 0 0 15px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }
            
            .order-items {
                margin-bottom: 30px;
            }
            
            .order-item {
                display: flex;
                gap: 15px;
                padding: 20px 0;
                border-bottom: 1px solid #eee;
            }
            
            .order-item:last-child {
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
                font-size: 16px;
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
            
            .item-price {
                font-weight: 600;
                color: #333;
                margin: 5px 0 0;
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
            
            .order-summary {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-top: 20px;
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
                border-top: 1px solid #ddd;
                font-size: 18px;
                font-weight: 700;
            }
            
            .summary-row.total .summary-value {
                color: var(--primary-color);
            }
            
            .payment-info {
                margin-top: 30px;
            }
            
            .payment-method {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 15px;
            }
            
            .payment-icon {
                font-size: 20px;
                color: #333;
                width: 24px;
            }
            
            .method-name {
                font-weight: 600;
                color: #333;
            }
            
            .card-info {
                color: #6c757d;
            }
            
            /* Timeline styles */
            .timeline {
                position: relative;
                margin: 30px 0;
                padding-left: 30px;
            }
            
            .timeline::before {
                content: '';
                position: absolute;
                top: 5px;
                bottom: 5px;
                left: 4px;
                width: 2px;
                background-color: #ddd;
            }
            
            .timeline-item {
                position: relative;
                padding-bottom: 25px;
            }
            
            .timeline-item:last-child {
                padding-bottom: 0;
            }
            
            .timeline-dot {
                position: absolute;
                left: -30px;
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background-color: #ccc;
            }
            
            .timeline-item.active .timeline-dot {
                background-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.2);
            }
            
            .timeline-item.completed .timeline-dot {
                background-color: #28a745;
                box-shadow: 0 0 0 3px rgba(40, 167, 69, 0.2);
            }
            
            .timeline-content {
                padding-left: 5px;
            }
            
            .timeline-time {
                font-size: 13px;
                color: #6c757d;
                margin-bottom: 5px;
            }
            
            .timeline-title {
                font-size: 16px;
                font-weight: 600;
                color: #333;
                margin: 0 0 5px;
            }
            
            .timeline-item.active .timeline-title {
                color: var(--primary-color);
            }
            
            .timeline-item.completed .timeline-title {
                color: #28a745;
            }
            
            .timeline-desc {
                font-size: 14px;
                color: #666;
                margin: 0;
            }
            
            /* Cancel Modal */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                overflow: auto;
            }
            
            .modal-content {
                background-color: #fff;
                margin: 100px auto;
                width: 90%;
                max-width: 500px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                animation: modalFadeIn 0.3s;
            }
            
            @keyframes modalFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .modal-header {
                padding: 20px;
                border-bottom: 1px solid #eee;
            }
            
            .modal-title {
                font-size: 20px;
                font-weight: 600;
                color: #333;
                margin: 0;
            }
            
            .close-modal {
                position: absolute;
                top: 15px;
                right: 15px;
                font-size: 24px;
                color: #999;
                background: none;
                border: none;
                cursor: pointer;
            }
            
            .modal-body {
                padding: 20px;
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
            
            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                border-top: 1px solid #eee;
                text-align: right;
            }
            
            .modal-footer .btn {
                margin-left: 10px;
            }
            
            .text-muted {
                color: #6c757d;
            }
            
            /* Media queries */
            @media (max-width: 768px) {
                .order-header {
                    flex-direction: column;
                }
                
                .order-actions {
                    width: 100%;
                    justify-content: space-between;
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
                <h1>Order Details</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="profile">My Account</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="order-history">Order History</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Order #ORD123456</span>
                </div>
            </div>
        </section>

        <!-- Order Detail Section -->
        <section class="order-detail-section">
            <div class="container">
                <div class="order-card">
                    <div class="order-header">
                        <div>
                            <h2 class="order-title">Order Details <span class="order-id">#ORD123456</span></h2>
                            <p class="text-muted">Placed on May 25, 2025 at 10:30 AM</p>
                        </div>
                        
                        <div class="order-status">
                            <span class="status-label status-processing">Processing</span>
                            <div class="order-actions">
                                <a href="#" class="btn btn-outline" id="trackOrderBtn"><i class="fas fa-truck"></i> Track Order</a>
                                <button class="btn btn-danger" id="cancelOrderBtn"><i class="fas fa-times"></i> Cancel Order</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Information -->
                    <div class="order-info-section">
                        <div class="info-box">
                            <h3>Shipping Address</h3>
                            <p class="info-detail">
                                John Doe<br>
                                123 Main Street<br>
                                Apt 4B<br>
                                New York, NY 10001<br>
                                United States<br>
                                Phone: (555) 123-4567
                            </p>
                        </div>
                        
                        <div class="info-box">
                            <h3>Shipping Method</h3>
                            <p class="info-detail">
                                Standard Shipping<br>
                                Estimated Delivery: June 1 - June 3, 2025
                            </p>
                        </div>
                        
                        <div class="info-box">
                            <h3>Billing Information</h3>
                            <p class="info-detail">
                                John Doe<br>
                                123 Main Street<br>
                                Apt 4B<br>
                                New York, NY 10001<br>
                                United States
                            </p>
                        </div>
                    </div>
                    
                    <!-- Tracking Information -->
                    <div class="tracking-info">
                        <p>
                            <span class="tracking-number">Tracking Number: DX9876543210</span>
                            <a href="#" class="tracking-link">Track <i class="fas fa-external-link-alt"></i></a>
                        </p>
                        <p class="tracking-status">Last Update: Package has left our warehouse and is on its way to the carrier.</p>
                    </div>
                    
                    <!-- Order Items -->
                    <div class="order-items">
                        <h3 class="section-title">Ordered Items</h3>
                        
                        <div class="order-item">
                            <div class="item-image">
                                <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                            </div>
                            <div class="item-details">
                                <a href="car/detail?id=1" class="item-name">Chevrolet CamFó Explorer</a>
                                <p class="item-brand">Chevrolet</p>
                                <p class="item-price">$120,000.00</p>
                                <div class="item-meta">
                                    <span class="meta-item">Color: <span>Silver Metallic</span></span>
                                    <span class="meta-item">Interior: <span>Black Leather</span></span>
                                    <span class="meta-item">Year: <span>2025</span></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="order-item">
                            <div class="item-image">
                                <img src="asset/img/cars/alfa-romeo.png" alt="Nissan Alfa Romeo">
                            </div>
                            <div class="item-details">
                                <a href="car/detail?id=2" class="item-name">Nissan Alfa Romeo</a>
                                <p class="item-brand">Nissan</p>
                                <p class="item-price">$180,000.00</p>
                                <div class="item-meta">
                                    <span class="meta-item">Color: <span>Deep Blue</span></span>
                                    <span class="meta-item">Interior: <span>Beige Leather</span></span>
                                    <span class="meta-item">Year: <span>2024</span></span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order Summary -->
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
                    </div>
                    
                    <!-- Payment Information -->
                    <div class="payment-info">
                        <h3 class="section-title">Payment Information</h3>
                        <div class="payment-method">
                            <span class="payment-icon"><i class="fas fa-credit-card"></i></span>
                            <div>
                                <span class="method-name">Visa</span>
                                <span class="card-info">**** **** **** 1234</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order Timeline -->
                    <div class="order-timeline">
                        <h3 class="section-title">Order Status</h3>
                        <div class="timeline">
                            <div class="timeline-item completed">
                                <div class="timeline-dot"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time">May 25, 2025 - 10:30 AM</div>
                                    <h4 class="timeline-title">Order Placed</h4>
                                    <p class="timeline-desc">Your order has been received and is being processed.</p>
                                </div>
                            </div>
                            
                            <div class="timeline-item completed">
                                <div class="timeline-dot"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time">May 25, 2025 - 2:45 PM</div>
                                    <h4 class="timeline-title">Payment Confirmed</h4>
                                    <p class="timeline-desc">Your payment has been successfully processed.</p>
                                </div>
                            </div>
                            
                            <div class="timeline-item active">
                                <div class="timeline-dot"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time">May 27, 2025 - 9:15 AM</div>
                                    <h4 class="timeline-title">Processing</h4>
                                    <p class="timeline-desc">Your order is being prepared for shipment.</p>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-dot"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time">Expected: May 29, 2025</div>
                                    <h4 class="timeline-title">Shipped</h4>
                                    <p class="timeline-desc">Your vehicle will be on its way to you.</p>
                                </div>
                            </div>
                            
                            <div class="timeline-item">
                                <div class="timeline-dot"></div>
                                <div class="timeline-content">
                                    <div class="timeline-time">Expected: June 1-3, 2025</div>
                                    <h4 class="timeline-title">Delivered</h4>
                                    <p class="timeline-desc">Your vehicle will be delivered to your shipping address.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Back to Orders Link -->
                    <div style="margin-top: 30px; text-align: center;">
                        <a href="order-history" class="btn btn-outline" style="margin-right: 15px;"><i class="fas fa-arrow-left"></i> Back to Order History</a>
                        <a href="feedback" class="btn btn-primary">Leave Feedback</a>
                    </div>
                    
                    <!-- Help Section -->
                    <div class="help-section" style="margin-top: 30px; text-align: center;">
                        <p>Need help with your order? <a href="feedback" style="color: var(--primary-color); font-weight: 600;">Contact Support</a> or call us at <span style="font-weight: 600;">(555) 987-6543</span></p>
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Cancel Order Modal -->
        <div class="modal" id="cancelOrderModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Cancel Order</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to cancel this order? This action cannot be undone.</p>
                    <div class="form-group">
                        <label for="cancel_reason">Reason for Cancellation</label>
                        <select id="cancel_reason" class="form-control">
                            <option value="">-- Select a reason --</option>
                            <option value="changed_mind">Changed my mind</option>
                            <option value="found_better_price">Found a better price elsewhere</option>
                            <option value="ordered_by_mistake">Ordered by mistake</option>
                            <option value="delivery_too_long">Estimated delivery time is too long</option>
                            <option value="other">Other</option>
                        </select>
                    </div>
                    <div class="form-group" id="other_reason_group" style="display: none;">
                        <label for="other_reason">Please specify</label>
                        <textarea id="other_reason" class="form-control" placeholder="Please provide details..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-outline close-btn">No, Keep Order</button>
                    <button class="btn btn-danger" id="confirmCancelBtn">Yes, Cancel Order</button>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Cancel Order Modal
                const cancelOrderBtn = document.getElementById('cancelOrderBtn');
                const cancelOrderModal = document.getElementById('cancelOrderModal');
                const closeModalBtns = document.querySelectorAll('.close-modal, .close-btn');
                const confirmCancelBtn = document.getElementById('confirmCancelBtn');
                const cancelReasonSelect = document.getElementById('cancel_reason');
                const otherReasonGroup = document.getElementById('other_reason_group');
                
                // Show cancel modal
                if (cancelOrderBtn) {
                    cancelOrderBtn.addEventListener('click', function() {
                        if (cancelOrderModal) {
                            cancelOrderModal.style.display = 'block';
                        }
                    });
                }
                
                // Close modal
                closeModalBtns.forEach(button => {
                    button.addEventListener('click', function() {
                        if (cancelOrderModal) {
                            cancelOrderModal.style.display = 'none';
                        }
                    });
                });
                
                // Close modal when clicking outside
                window.addEventListener('click', function(e) {
                    if (e.target === cancelOrderModal) {
                        cancelOrderModal.style.display = 'none';
                    }
                });
                
                // Show/hide other reason field
                if (cancelReasonSelect) {
                    cancelReasonSelect.addEventListener('change', function() {
                        if (this.value === 'other') {
                            otherReasonGroup.style.display = 'block';
                        } else {
                            otherReasonGroup.style.display = 'none';
                        }
                    });
                }
                
                // Confirm cancel order
                if (confirmCancelBtn) {
                    confirmCancelBtn.addEventListener('click', function() {
                        const reason = cancelReasonSelect.value;
                        
                        if (!reason) {
                            alert('Please select a reason for cancellation');
                            return;
                        }
                        
                        if (reason === 'other') {
                            const otherReason = document.getElementById('other_reason').value.trim();
                            if (!otherReason) {
                                alert('Please specify your reason for cancellation');
                                return;
                            }
                        }
                        
                        // Here you would typically send a request to the server to cancel the order
                        // For this demo, just show a success message
                        alert('Your order has been cancelled successfully');
                        
                        // Update UI to reflect cancellation
                        const statusLabel = document.querySelector('.status-label');
                        if (statusLabel) {
                            statusLabel.className = 'status-label status-cancelled';
                            statusLabel.textContent = 'Cancelled';
                        }
                        
                        // Hide the cancel button
                        cancelOrderBtn.style.display = 'none';
                        
                        // Close the modal
                        cancelOrderModal.style.display = 'none';
                    });
                }
                
                // Track Order Button
                const trackOrderBtn = document.getElementById('trackOrderBtn');
                if (trackOrderBtn) {
                    trackOrderBtn.addEventListener('click', function(e) {
                        e.preventDefault();
                        // In a real app, this would take you to a tracking page
                        alert('This would redirect to a detailed tracking page in a real application');
                    });
                }
            });
        </script>
    </body>
</html> 