<%-- 
    Document   : navbar
    Created on : May 25, 2025
    Author     : AI Assistant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%
    String uri = ((HttpServletRequest) request).getRequestURI();
%>
<header class="header">
    <div class="container">
        <div class="top-header">
            <div class="contact-info">
                <a href="mailto:Huyvgce181516@fpt.edu.vn"><i class="fas fa-envelope"></i> fpt@gmail.com</a>
                <a href="tel: +84 915456680"><i class="fas fa-phone"></i> 0915456680</a>
            </div>
            <div class="header-right">
                <div class="dropdown">
                    <button class="dropdown-btn">$ USD <i class="fas fa-chevron-down"></i></button>
                    <div class="dropdown-menu">
                        <a href="#">$ USD</a>
                        <a href="#">€ EUR</a>
                        <a href="#">£ GBP</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropdown-btn">English <i class="fas fa-chevron-down"></i></button>
                    <div class="dropdown-menu">
                        <a href="#">English</a>
                        <a href="#">French</a>
                        <a href="#">Spanish</a>
                        <a href="#">Vietnamese</a>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/auth/login" class="login-btn">Login</a>
            </div>
        </div>
        <div class="main-header">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/home">
                    <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo.png" alt="DriverXO">
                    <span>DriverXO</span>
                </a>
            </div>
            <nav class="main-nav">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home"
                           class="<%= uri.contains("/home") ? "active" : ""%>">Home</a></li>
                    <li class="has-dropdown">
                        <a href="${pageContext.request.contextPath}/car/list"
                           class="<%= uri.contains("/car") ? "active" : ""%>">
                            Cars <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="dropdown-menu">
                            <a href="${pageContext.request.contextPath}/car/list?type=sedan">Sedan</a>
                            <a href="${pageContext.request.contextPath}/car/list?type=suv">SUV</a>
                            <a href="${pageContext.request.contextPath}/car/list?type=sports">Sports</a>
                            <a href="${pageContext.request.contextPath}/car/list?type=luxury">Luxury</a>
                            <a href="${pageContext.request.contextPath}/car/list?brand=toyota">Toyota</a>
                            <a href="${pageContext.request.contextPath}/car/list?brand=honda">Honda</a>
                            <a href="${pageContext.request.contextPath}/car/list?brand=bmw">BMW</a>
                            <a href="${pageContext.request.contextPath}/car/list?brand=mercedes">Mercedes</a>
                        </div>
                    </li>
                    </li>
                    <li><a href="${pageContext.request.contextPath}/parts"
                           class="<%= uri.contains("/parts") ? "active" : ""%>">Parts</a></li>

                    <li><a href="${pageContext.request.contextPath}/repair-service"
                           class="<%= uri.contains("/repair-service") ? "active" : ""%>">Repair Service</a></li>

                    <li><a href="${pageContext.request.contextPath}/about-us"
                           class="<%= uri.contains("/about-us") ? "active" : ""%>">About Us</a></li>

                    <li><a href="${pageContext.request.contextPath}/blog"
                           class="<%= uri.contains("/blog") ? "active" : ""%>">Blog</a></li>
                </ul>
            </nav>
            <div class="header-actions">
                <a href="#" class="cart-btn" id="cartToggle"><i class="fas fa-shopping-cart"></i><span class="item-count">0</span></a>
                <a href="#" class="booking-btn" id="bookingToggle"><i class="fas fa-calendar-alt"></i><span class="booking-count">0</span></a>
            </div>
        </div>
    </div>
</header> 

<!-- Cart Sidebar -->
<div class="sidebar-overlay" id="cartOverlay"></div>
<div class="sidebar" id="cartSidebar">
    <div class="sidebar-header">
        <h3>Shopping Cart</h3>
        <button class="close-sidebar" id="closeCart"><i class="fas fa-times"></i></button>
    </div>
    <div class="sidebar-content">
        <div class="cart-items">
            <!-- Cart items will be dynamically loaded here -->
            <div class="empty-cart">
                <i class="fas fa-shopping-cart"></i>
                <p>Your cart is empty</p>
                <a href="${pageContext.request.contextPath}/car/list" class="browse-btn">Browse Cars</a>
            </div>
        </div>
    </div>
    <div class="sidebar-footer">
        <div class="cart-total">
            <span>Total:</span>
            <span class="total-amount">$0.00</span>
        </div>
        <a href="${pageContext.request.contextPath}/cart" class="view-cart-btn">View Cart</a>
        <a href="${pageContext.request.contextPath}/checkout" class="checkout-btn">Checkout</a>
    </div>
</div>

<!-- Booking Sidebar -->
<div class="sidebar-overlay" id="bookingOverlay"></div>
<div class="sidebar" id="bookingSidebar">
    <div class="sidebar-header">
        <h3>Your Bookings</h3>
        <button class="close-sidebar" id="closeBooking"><i class="fas fa-times"></i></button>
    </div>
    <div class="sidebar-content">
        <div class="booking-items">
            <!-- Booking items will be dynamically loaded here -->
            <div class="empty-bookings">
                <i class="fas fa-calendar-alt"></i>
                <p>You have no bookings</p>
                <a href="${pageContext.request.contextPath}/car/list" class="browse-btn">Book a Test Drive</a>
            </div>
        </div>
    </div>
    <div class="sidebar-footer">
        <a href="${pageContext.request.contextPath}/bookings" class="view-bookings-btn">View All Bookings</a>
    </div>
</div>

<style>
    /* Header Actions Styling */
    .header-actions {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .header-actions a {
        position: relative;
        font-size: 18px;
        color: var(--text-color);
        transition: color 0.3s;
    }

    .header-actions a:hover {
        color: var(--primary-color);
    }

    .header-actions .item-count,
    .header-actions .booking-count {
        position: absolute;
        top: -8px;
        right: -8px;
        background-color: var(--primary-color);
        color: white;
        font-size: 10px;
        width: 18px;
        height: 18px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* Sidebar Styling */
    .sidebar-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 999;
        visibility: hidden;
        opacity: 0;
        transition: opacity 0.3s, visibility 0.3s;
    }

    .sidebar {
        position: fixed;
        top: 0;
        right: -400px;
        width: 350px;
        height: 100%;
        background-color: white;
        box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
        z-index: 1000;
        transition: right 0.3s ease-in-out;
        display: flex;
        flex-direction: column;
    }

    .sidebar.active {
        right: 0;
    }

    .sidebar-overlay.active {
        visibility: visible;
        opacity: 1;
    }

    .sidebar-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 20px;
        border-bottom: 1px solid #eee;
    }

    .sidebar-header h3 {
        font-size: 18px;
        font-weight: 600;
        margin: 0;
        color: var(--primary-color);
    }

    .close-sidebar {
        background: none;
        border: none;
        font-size: 18px;
        cursor: pointer;
        color: #999;
        transition: color 0.3s;
    }

    .close-sidebar:hover {
        color: var(--primary-color);
    }

    .sidebar-content {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
    }

    .sidebar-footer {
        padding: 15px 20px;
        border-top: 1px solid #eee;
        background-color: #f8f9fa;
    }

    /* Cart Items Styling */
    .empty-cart,
    .empty-bookings {
        text-align: center;
        padding: 30px 0;
    }

    .empty-cart i,
    .empty-bookings i {
        font-size: 50px;
        color: #ddd;
        margin-bottom: 15px;
    }

    .empty-cart p,
    .empty-bookings p {
        color: #999;
        margin-bottom: 20px;
    }

    .browse-btn {
        display: inline-block;
        padding: 8px 16px;
        background-color: var(--primary-color);
        color: white;
        border-radius: 4px;
        text-decoration: none;
        transition: background-color 0.3s;
    }

    .browse-btn:hover {
        background-color: var(--secondary-color);
    }

    .cart-total {
        display: flex;
        justify-content: space-between;
        font-weight: 600;
        font-size: 16px;
        margin-bottom: 15px;
    }

    .view-cart-btn,
    .checkout-btn,
    .view-bookings-btn {
        display: block;
        padding: 10px;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        font-weight: 600;
        margin-bottom: 10px;
        transition: all 0.3s;
    }

    .view-cart-btn {
        background-color: #f8f9fa;
        color: var(--primary-color);
        border: 1px solid var(--primary-color);
    }

    .checkout-btn,
    .view-bookings-btn {
        background-color: var(--primary-color);
        color: white;
    }

    .view-cart-btn:hover {
        background-color: #eaeaea;
    }

    .checkout-btn:hover,
    .view-bookings-btn:hover {
        background-color: var(--secondary-color);
    }
    nav.main-nav a.active {
        color: var(--primary-color);
        font-weight: bold;
        border-bottom: 2px solid var(--primary-color);
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Cart sidebar toggle
        const cartToggle = document.getElementById('cartToggle');
        const cartSidebar = document.getElementById('cartSidebar');
        const cartOverlay = document.getElementById('cartOverlay');
        const closeCart = document.getElementById('closeCart');

        // Booking sidebar toggle
        const bookingToggle = document.getElementById('bookingToggle');
        const bookingSidebar = document.getElementById('bookingSidebar');
        const bookingOverlay = document.getElementById('bookingOverlay');
        const closeBooking = document.getElementById('closeBooking');

        // Toggle cart sidebar
        cartToggle.addEventListener('click', function (e) {
            e.preventDefault();
            cartSidebar.classList.add('active');
            cartOverlay.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        // Close cart sidebar
        closeCart.addEventListener('click', function () {
            cartSidebar.classList.remove('active');
            cartOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });

        cartOverlay.addEventListener('click', function () {
            cartSidebar.classList.remove('active');
            cartOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });

        // Toggle booking sidebar
        bookingToggle.addEventListener('click', function (e) {
            e.preventDefault();
            bookingSidebar.classList.add('active');
            bookingOverlay.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        // Close booking sidebar
        closeBooking.addEventListener('click', function () {
            bookingSidebar.classList.remove('active');
            bookingOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });

        bookingOverlay.addEventListener('click', function () {
            bookingSidebar.classList.remove('active');
            bookingOverlay.classList.remove('active');
            document.body.style.overflow = '';
        });
    });
</script> 