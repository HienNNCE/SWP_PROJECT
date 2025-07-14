<%-- 
    Document   : order-history
    Created on : May 28, 2025, 10:30:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order History - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .order-history-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .order-filter {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }
            
            .filter-group {
                display: flex;
                gap: 15px;
            }
            
            .filter-select {
                padding: 10px 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                color: #555;
                background-color: #fff;
            }
            
            .search-box {
                display: flex;
                align-items: center;
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 0 15px;
            }
            
            .search-box i {
                color: #777;
            }
            
            .search-input {
                border: none;
                padding: 10px;
                outline: none;
                width: 200px;
                font-size: 14px;
            }
            
            .order-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 20px;
                overflow: hidden;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            
            .order-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.12);
            }
            
            .order-header {
                padding: 20px;
                background-color: #f8f9fa;
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 1px solid #eee;
            }
            
            .order-id {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }
            
            .order-date {
                font-size: 14px;
                color: #777;
            }
            
            .order-status {
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 500;
                text-transform: uppercase;
            }
            
            .status-completed {
                background-color: #e3f8e3;
                color: #28a745;
            }
            
            .status-processing {
                background-color: #e0f4ff;
                color: #007bff;
            }
            
            .status-shipped {
                background-color: #e0f2ff;
                color: #17a2b8;
            }
            
            .status-cancelled {
                background-color: #ffe0e0;
                color: #dc3545;
            }
            
            .order-body {
                padding: 20px;
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
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 5px;
                margin-top: 20px;
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                gap: 10px;
            }
            
            .summary-item {
                display: flex;
                flex-direction: column;
            }
            
            .summary-label {
                font-size: 12px;
                color: #777;
                margin-bottom: 5px;
            }
            
            .summary-value {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }
            
            .summary-total {
                color: var(--primary-color);
            }
            
            .order-actions {
                margin-top: 20px;
                display: flex;
                gap: 10px;
            }
            
            .order-btn {
                padding: 10px 15px;
                font-size: 14px;
                font-weight: 500;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .view-details-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .view-details-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .track-order-btn {
                background-color: #fff;
                color: var(--primary-color);
                border: 1px solid var(--primary-color);
            }
            
            .track-order-btn:hover {
                background-color: rgba(7,46,176,0.05);
            }
            
            .cancel-order-btn {
                background-color: #fff;
                color: #dc3545;
                border: 1px solid #dc3545;
            }
            
            .cancel-order-btn:hover {
                background-color: #fff7f7;
            }
            
            .empty-orders {
                text-align: center;
                padding: 60px 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
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
            
            .shop-now-btn {
                display: inline-block;
                padding: 12px 30px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            
            .shop-now-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .pagination {
                display: flex;
                justify-content: center;
                gap: 5px;
                margin-top: 40px;
            }
            
            .pagination a {
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 5px;
                background-color: #fff;
                color: #555;
                font-weight: 500;
                text-decoration: none;
                transition: all 0.3s;
                border: 1px solid #ddd;
            }
            
            .pagination a:hover {
                background-color: #f8f9fa;
            }
            
            .pagination a.active {
                background-color: var(--primary-color);
                color: white;
                border-color: var(--primary-color);
            }
            
            /* Modal Styles */
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
                margin: 50px auto;
                width: 100%;
                max-width: 800px;
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
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .modal-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--primary-color);
                margin: 0;
            }
            
            .close-modal {
                background: none;
                border: none;
                font-size: 22px;
                color: #999;
                cursor: pointer;
            }
            
            .modal-body {
                padding: 20px;
            }
            
            .order-timeline {
                position: relative;
                padding-left: 30px;
                margin-bottom: 30px;
            }
            
            .timeline-item {
                position: relative;
                padding-bottom: 30px;
            }
            
            .timeline-item:last-child {
                padding-bottom: 0;
            }
            
            .timeline-item::before {
                content: "";
                position: absolute;
                left: -30px;
                top: 0;
                width: 16px;
                height: 16px;
                border-radius: 50%;
                background-color: var(--primary-color);
                z-index: 1;
            }
            
            .timeline-item::after {
                content: "";
                position: absolute;
                left: -23px;
                top: 16px;
                bottom: 0;
                width: 2px;
                background-color: #ddd;
            }
            
            .timeline-item:last-child::after {
                display: none;
            }
            
            .timeline-date {
                font-size: 14px;
                color: #777;
                margin-bottom: 5px;
            }
            
            .timeline-status {
                font-size: 16px;
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
            }
            
            .timeline-description {
                font-size: 14px;
                color: #555;
            }
            
            /* Add more responsive styles */
            @media (max-width: 768px) {
                .order-filter {
                    flex-direction: column;
                    gap: 15px;
                    align-items: stretch;
                }
                
                .filter-group {
                    flex-wrap: wrap;
                }
                
                .order-header {
                    flex-direction: column;
                    gap: 10px;
                    align-items: flex-start;
                }
                
                .order-actions {
                    flex-wrap: wrap;
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
                <h1>Order History</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="profile">My Account</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Order History</span>
                </div>
            </div>
        </section>

        <!-- Order History Section -->
        <section class="order-history-section">
            <div class="container">
                <div class="order-filter">
                    <div class="filter-group">
                        <select class="filter-select">
                            <option value="all">All Orders</option>
                            <option value="completed">Completed</option>
                            <option value="processing">Processing</option>
                            <option value="shipped">Shipped</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                        <select class="filter-select">
                            <option value="recent">Most Recent</option>
                            <option value="oldest">Oldest First</option>
                            <option value="highest">Highest Amount</option>
                            <option value="lowest">Lowest Amount</option>
                        </select>
                        <select class="filter-select">
                            <option value="all-time">All Time</option>
                            <option value="30days">Last 30 Days</option>
                            <option value="6months">Last 6 Months</option>
                            <option value="year">Last Year</option>
                        </select>
                    </div>
                    <div class="search-box">
                        <i class="fas fa-search"></i>
                        <input type="text" class="search-input" placeholder="Search orders...">
                    </div>
                </div>
                
                <c:if test="${empty orderList}">
                    <div class="empty-orders">
                        <i class="fas fa-shopping-bag empty-icon"></i>
                        <h2 class="empty-message">You haven't placed any orders yet</h2>
                        <p>Explore our collection of premium vehicles and start shopping</p>
                        <a href="car/list" class="shop-now-btn">Shop Now</a>
                    </div>
                </c:if>
                
                <c:if test="${not empty orderList}">
                    <!-- For demo purposes, showing static order examples since orderList is not provided -->
                    <!-- Order 1 -->
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-id">Order #ORD12345</div>
                            <div class="order-date">June 2, 2025</div>
                            <div class="order-status status-completed">Completed</div>
                        </div>
                        <div class="order-body">
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
                            </div>
                            <div class="order-summary">
                                <div class="summary-item">
                                    <span class="summary-label">Subtotal</span>
                                    <span class="summary-value">$120,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Tax</span>
                                    <span class="summary-value">$12,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Shipping</span>
                                    <span class="summary-value">$0.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Total</span>
                                    <span class="summary-value summary-total">$132,000.00</span>
                                </div>
                            </div>
                            <div class="order-actions">
                                <button class="order-btn view-details-btn" data-id="ORD12345">View Details</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order 2 -->
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-id">Order #ORD12348</div>
                            <div class="order-date">May 25, 2025</div>
                            <div class="order-status status-shipped">Shipped</div>
                        </div>
                        <div class="order-body">
                            <div class="order-items">
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
                                <div class="summary-item">
                                    <span class="summary-label">Subtotal</span>
                                    <span class="summary-value">$180,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Tax</span>
                                    <span class="summary-value">$18,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Shipping</span>
                                    <span class="summary-value">$0.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Total</span>
                                    <span class="summary-value summary-total">$198,000.00</span>
                                </div>
                            </div>
                            <div class="order-actions">
                                <button class="order-btn view-details-btn" data-id="ORD12348">View Details</button>
                                <button class="order-btn track-order-btn">Track Shipment</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Order 3 -->
                    <div class="order-card">
                        <div class="order-header">
                            <div class="order-id">Order #ORD12350</div>
                            <div class="order-date">May 18, 2025</div>
                            <div class="order-status status-processing">Processing</div>
                        </div>
                        <div class="order-body">
                            <div class="order-items">
                                <div class="order-item">
                                    <div class="item-image">
                                        <img src="asset/img/cars/atra-benz-black.png" alt="Hyundai Altra Benz C-Class">
                                    </div>
                                    <div class="item-details">
                                        <div class="item-name">Hyundai Altra Benz C-Class</div>
                                        <div class="item-brand">Hyundai</div>
                                        <div class="item-price">$3,000.00</div>
                                    </div>
                                </div>
                            </div>
                            <div class="order-summary">
                                <div class="summary-item">
                                    <span class="summary-label">Subtotal</span>
                                    <span class="summary-value">$3,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Tax</span>
                                    <span class="summary-value">$300.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Shipping</span>
                                    <span class="summary-value">$0.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Total</span>
                                    <span class="summary-value summary-total">$3,300.00</span>
                                </div>
                            </div>
                            <div class="order-actions">
                                <button class="order-btn view-details-btn" data-id="ORD12350">View Details</button>
                                <button class="order-btn cancel-order-btn">Cancel Order</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="pagination">
                        <a href="#" class="active">1</a>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#"><i class="fas fa-angle-right"></i></a>
                    </div>
                </c:if>
            </div>
        </section>
        
        <!-- Order Details Modal -->
        <div class="modal" id="orderDetailsModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Order Details</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- Content will be loaded dynamically -->
                    <div class="order-details-content">
                        <div class="order-id-section">
                            <h3>Order #ORD12345</h3>
                            <div class="order-meta">
                                <span>Placed on June 2, 2025</span>
                                <span class="order-status status-completed">Completed</span>
                            </div>
                        </div>
                        
                        <div class="order-section">
                            <h4>Items</h4>
                            <div class="order-items">
                                <div class="order-item">
                                    <div class="item-image">
                                        <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                    </div>
                                    <div class="item-details">
                                        <div class="item-name">Chevrolet CamFó Explorer</div>
                                        <div class="item-brand">Chevrolet</div>
                                        <div class="item-price">$120,000.00</div>
                                        <div class="item-specs">2019 Model | Gasoline | Automatic</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="order-section">
                            <h4>Order Timeline</h4>
                            <div class="order-timeline">
                                <div class="timeline-item">
                                    <div class="timeline-date">June 5, 2025 - 10:30 AM</div>
                                    <div class="timeline-status">Delivered</div>
                                    <div class="timeline-description">Your order has been delivered.</div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-date">June 4, 2025 - 08:15 AM</div>
                                    <div class="timeline-status">Out for Delivery</div>
                                    <div class="timeline-description">Your order is out for delivery.</div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-date">June 3, 2025 - 02:45 PM</div>
                                    <div class="timeline-status">Shipped</div>
                                    <div class="timeline-description">Your order has been shipped.</div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-date">June 2, 2025 - 11:20 AM</div>
                                    <div class="timeline-status">Processing</div>
                                    <div class="timeline-description">Your order is being processed.</div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-date">June 2, 2025 - 10:45 AM</div>
                                    <div class="timeline-status">Order Placed</div>
                                    <div class="timeline-description">Your order has been placed successfully.</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="order-section">
                            <h4>Shipping Address</h4>
                            <p>
                                John Doe<br>
                                123 Main Street<br>
                                Apt 4B<br>
                                New York, NY 10001<br>
                                United States<br>
                                Phone: (555) 123-4567
                            </p>
                        </div>
                        
                        <div class="order-section">
                            <h4>Payment Information</h4>
                            <p>
                                Payment Method: Credit Card<br>
                                Card: Visa ending in 4242<br>
                                Status: Payment completed
                            </p>
                        </div>
                        
                        <div class="order-section">
                            <h4>Order Summary</h4>
                            <div class="order-summary">
                                <div class="summary-item">
                                    <span class="summary-label">Subtotal</span>
                                    <span class="summary-value">$120,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Tax</span>
                                    <span class="summary-value">$12,000.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Shipping</span>
                                    <span class="summary-value">$0.00</span>
                                </div>
                                <div class="summary-item">
                                    <span class="summary-label">Total</span>
                                    <span class="summary-value summary-total">$132,000.00</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // View Order Details
                const viewDetailsBtns = document.querySelectorAll('.view-details-btn');
                const orderDetailsModal = document.getElementById('orderDetailsModal');
                const closeModalBtn = document.querySelector('.close-modal');
                
                viewDetailsBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        const orderId = this.getAttribute('data-id');
                        // Here you would typically fetch order details from the server
                        // For this demo, we'll just show the modal with pre-loaded content
                        orderDetailsModal.style.display = 'block';
                    });
                });
                
                // Close modal
                if (closeModalBtn) {
                    closeModalBtn.addEventListener('click', function() {
                        orderDetailsModal.style.display = 'none';
                    });
                }
                
                // Close modal when clicking outside
                window.addEventListener('click', function(e) {
                    if (e.target === orderDetailsModal) {
                        orderDetailsModal.style.display = 'none';
                    }
                });
                
                // Track Order button
                const trackOrderBtns = document.querySelectorAll('.track-order-btn');
                trackOrderBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // For demo purposes, just show an alert
                        alert('Tracking information would be displayed here');
                    });
                });
                
                // Cancel Order button
                const cancelOrderBtns = document.querySelectorAll('.cancel-order-btn');
                cancelOrderBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // For demo purposes, just show a confirmation dialog
                        if (confirm('Are you sure you want to cancel this order?')) {
                            alert('Order cancellation request submitted');
                        }
                    });
                });
                
                // Filter functionality
                const filterSelects = document.querySelectorAll('.filter-select');
                filterSelects.forEach(select => {
                    select.addEventListener('change', function() {
                        // For demo purposes, just log the filter changes
                        console.log('Filter changed:', this.value);
                        // In a real app, this would filter the orders list
                    });
                });
                
                // Search functionality
                const searchInput = document.querySelector('.search-input');
                if (searchInput) {
                    searchInput.addEventListener('keyup', function(e) {
                        if (e.key === 'Enter') {
                            // For demo purposes, just log the search term
                            console.log('Searching for:', this.value);
                            // In a real app, this would filter the orders list
                        }
                    });
                }
            });
        </script>
    </body>
</html> 