<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* Minimal Modern Navbar Styles */
    .header {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        transition: none;
        background-color: #000 !important;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .header.scrolled {
        background-color: #000 !important;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .compact-header .main-header {
        padding: 12px 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .compact-header .logo a {
        font-size: 18px;
        font-weight: 400;
        letter-spacing: 1px;
        color: #fff;
        display: flex;
        align-items: center;
        text-decoration: none;
    }

    .header.scrolled .logo a {
        color: #000;
    }

    .compact-header .logo img {
        height: 22px;
        margin-right: 8px;
    }

    /* Contact Icons */
    .contact-icons {
        display: flex;
        gap: 20px;
        margin-left: 30px;
    }

    .contact-icons a {
        font-size: 14px;
        color: #fff;
        transition: all 0.3s ease;
    }

    .header.scrolled .contact-icons a {
        color: #555;
    }

    .contact-icons a:hover {
        opacity: 0.8;
    }

    /* Left and Right Sections */
    .left-section {
        display: flex;
        align-items: center;
    }

    .right-section {
        display: flex;
        align-items: center;
        gap: 30px;
    }

    /* Main Navigation */
    .main-nav {
        flex: 1;
        display: flex;
        justify-content: center;
    }

    .main-nav ul {
        display: flex;
        gap: 30px;
        padding: 0;
        margin: 0;
    }

    .main-nav ul li {
        list-style: none;
        position: relative;
    }

    .main-nav a {
        color: #fff;
        font-size: 13px;
        font-weight: 400;
        text-decoration: none;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
        padding: 3px 0;
        position: relative;
    }

    .header.scrolled .main-nav a {
        color: #000;
    }

    .main-nav a:after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 0;
        height: 1px;
        background-color: transparent;
        transition: width 0.3s ease;
    }

    .header.scrolled .main-nav a:after {
        background-color: #000;
    }

    /*    .main-nav a:hover:after,*/
    .main-nav a.active:after {
        width: 100%;
    }

    /* Dropdown Toggle */
    .dropdown-toggle {
        display: flex;
        align-items: center;
        gap: 5px;
        cursor: pointer;
    }

    .dropdown-toggle i {
        font-size: 9px;
        transition: transform 0.3s ease;
    }

    /* Mega Dropdown - Minimal Style */
    .mega-dropdown {
        position: absolute;
        top: 100%;
        left: -300px;
        width: 900px;
        background-color: #fff;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 1000;
        display: flex;
        margin-top: 12px;
        max-height: 70vh;
        overflow-y: auto;
    }

    .dropdown-container:hover .mega-dropdown {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .dropdown-container:hover .dropdown-toggle i {
        transform: rotate(180deg);
    }

    /* Sidebar Categories - Minimal Style */
    .mega-menu-sidebar {
        width: 220px;
        background-color: #f9f9f9;
        border-right: 1px solid #f0f0f0;
    }

    .mega-menu-sidebar ul {
        display: block;
        width: 100%;
        padding: 0;
        margin: 0;
    }

    .mega-menu-sidebar ul li {
        padding: 0;
        border-bottom: 1px solid #f0f0f0;
    }

    .mega-menu-sidebar ul li a {
        padding: 12px 16px;
        color: #333;
        font-size: 13px;
        display: flex;
        align-items: center;
        justify-content: space-between;
        transition: all 0.2s ease;
    }

    .mega-menu-sidebar ul li a:hover {
        background-color: #f5f5f5;
        color: #000;
    }

    .mega-menu-sidebar ul li a:after {
        display: none;
    }

    .mega-menu-sidebar ul li a i {
        font-size: 10px;
        color: #999;
    }

    /* Cars Grid - Minimal Style */
    .mega-menu-content {
        flex: 1;
        padding: 20px;
        background-color: #fff;
    }

    .cars-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 20px;
    }

    .car-preview {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        padding: 8px;
        transition: all 0.3s ease;
        /* Thêm chiều rộng cố định cho khung ảnh */
    }

    .car-preview-img-wrapper {
        width: 100%;
        aspect-ratio: 16/9;
        background: #f5f5f5;
        display: flex;
        align-items: center;
        justify-content: center;
        overflow: hidden;
        border-radius: 8px;
        margin-bottom: 15px;
    }

    .car-preview img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        background: transparent;
        transition: all 0.3s ease;
        display: block;
    }

    .car-model {
        font-weight: 500;
        color: #000;
        margin-bottom: 4px;
        font-size: 13px;
    }

    .car-model-badge {
        font-size: 10px;
        vertical-align: super;
    }

    .car-price {
        color: #666;
        font-size: 12px;
        margin-bottom: 6px;
    }

    .car-price sup {
        font-size: 9px;
    }

    .car-badge {
        display: flex;
        align-items: center;
        gap: 5px;
        font-size: 11px;
        color: #559900;
    }

    .car-badge.electric {
        color: #0066cc;
    }

    .car-badge i {
        font-size: 12px;
    }

    /* See All Link */
    .see-all-link {
        display: inline-block;
        margin-top: 20px;
        color: #000;
        font-size: 13px;
        font-weight: 500;
        text-decoration: none;
        transition: all 0.3s ease;
        border-bottom: 1px solid transparent;
    }

    .see-all-link:hover {
        border-bottom: 1px solid #000;
    }

    .see-all-link i {
        font-size: 10px;
        margin-left: 5px;
    }

    /* Login Button */
    .login-btn {
        padding: 6px 16px;
        background-color: transparent;
        border: 1px solid #fff;
        color: #fff;
        font-size: 12px;
        text-decoration: none;
        letter-spacing: 0.5px;
        transition: all 0.3s ease;
    }

    .header.scrolled .login-btn {
        border: 1px solid #000;
        color: #000;
    }

    .login-btn:hover {
        background-color: #fff;
        color: #000;
    }

    .header.scrolled .login-btn:hover {
        background-color: #000;
        color: #fff;
    }

    /* Header Actions */
    .header-actions {
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .header-actions a {
        color: #fff;
        font-size: 14px;
        transition: all 0.3s ease;
        position: relative;
    }

    .header.scrolled .header-actions a {
        color: #000;
    }

    .header-actions a:hover {
        opacity: 0.8;
    }

    /* Badge for cart items */
    .cart-icon {
        display: flex;
        align-items: center;
        position: relative;
        gap: 6px;
    }

    /* Bao icon để định vị badge */
    .cart-icon-wrapper {
        position: relative;
    }
    .cart-badge {
        position: absolute;
        top: -8px;
        right: -8px;
        background-color: #ff3a3a;
        color: white;
        font-size: 10px;
        width: 16px;
        height: 16px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 500;
    }
    .cart-total {
        font-size: 12px;
        color: inherit;
    }

    /* Responsive Styles */
    @media (max-width: 1200px) {
        .mega-dropdown {
            width: 900px;
            left: -250px;
        }

        .cars-grid {
            grid-template-columns: repeat(3, 1fr);
        }

        .main-nav ul {
            gap: 30px;
        }
    }

    @media (max-width: 992px) {
        .mega-dropdown {
            width: 700px;
            left: -200px;
        }

        .cars-grid {
            grid-template-columns: repeat(2, 1fr);
        }

        .main-nav ul {
            gap: 20px;
        }

        .contact-icons {
            display: none;
        }
    }

    /* Dropdown profile menu */
    .profile-dropdown {
        position: relative;
    }

    .profile-menu {
        position: absolute;
        top: 40px;
        right: 0;
        width: 200px;
        background-color: #fff;
        border-radius: 4px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        padding: 10px 0;
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 1100;
    }

    .profile-dropdown:hover .profile-menu {
        opacity: 1;
        visibility: visible;
        transform: translateY(0);
    }

    .profile-menu ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .profile-menu ul li {
        padding: 0;
        margin: 0;
    }

    .profile-menu ul li a {
        display: flex;
        align-items: center;
        padding: 10px 20px;
        color: #333;
        font-size: 13px;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .profile-menu ul li a:hover {
        background-color: #f5f5f5;
    }

    .profile-menu ul li a i {
        width: 20px;
        margin-right: 10px;
        text-align: center;
    }

    .profile-avatar {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        cursor: pointer;
        border: 2px solid #fff;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 16px;
        color: #fff;
    }

    .header.scrolled .profile-avatar {
        border-color: #eee;
        color: #000;
    }

    /* Divider in dropdown menu */
    .menu-divider {
        height: 1px;
        background-color: #f0f0f0;
        margin: 5px 0;
    }

    /* Dropdown Parts: chỉnh nhỏ, gọn */
    .parts-dropdown {
        left: -100px !important;
        width: 260px !important;
        max-height: 400px;
        overflow-y: auto;
        padding: 10px 0;
    }

    .parts-dropdown .mega-menu-sidebar {
        width: 100% !important;
        background: #fff;
        border-right: none;
    }

    .parts-dropdown .mega-menu-sidebar ul li a {
        padding: 8px 14px;
        font-size: 13px;
        color: #333;
    }

    .parts-dropdown .mega-menu-sidebar ul li a:hover {
        background-color: #f0f0f0;
        color: #000;
    }

    .parts-dropdown .mega-menu-sidebar ul li a i {
        display: none;
    }

    /* Chỉ đổi màu chữ trên thanh navbar chính khi scroll, không ảnh hưởng dropdown */
    .header.scrolled .main-header > .left-section .logo a,
    .header.scrolled .main-header > .main-nav > ul > li > a,
    .header.scrolled .main-header > .right-section .header-actions > a,
    .header.scrolled .main-header > .right-section .login-btn,
    .header.scrolled .main-header > .right-section .profile-avatar {
        color: #fff !important;
        border-color: #fff !important;
    }

    .main-nav a:after {
        background-color: #fff;
    }

    .logo-white {
        display: block !important;
    }
    .logo-dark {
        display: none !important;
    }

    /* Fix màu chữ và icon trong dropdown profile luôn là đen */
    .header .profile-menu ul li a,
    .header .profile-menu ul li a i {
        color: #111 !important;
    }
</style>

<!-- Fetch all car data from the backend -->
<c:set var="brands" value="${requestScope.carBrands}" />
<c:set var="categories" value="${requestScope.carCategories}" />

<!-- Header -->
<header class="header compact-header">
    <div class="container">
        <div class="main-header">
            <div class="left-section">
                <div class="logo">
                    <a href="${pageContext.request.contextPath}/home">
                        <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo-white.png" alt="DriverXO" class="logo-white">
                        <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo.png" alt="DriverXO" class="logo-dark" style="display: none;">
                        DriverXO
                    </a>
                </div>
                <div class="contact-icons">
                    <a href="mailto:fpt@gmail.com"><i class="far fa-envelope"></i></a>
                    <a href="tel:0915456680"><i class="fas fa-phone"></i></a>
                </div>
            </div>

            <nav class="main-nav">
                <ul>
                    <li class="dropdown-container">
                        <a href="${pageContext.request.contextPath}/car/list" class="${pageContext.request.servletPath eq '/car/car-list.jsp' ? 'active' : ''}">
                            Cars <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="mega-dropdown">
                            <!-- Sidebar Categories -->
                            <div class="mega-menu-sidebar">
                                <ul>
                                    <!-- Loại xe theo phân khúc -->
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=luxury">Luxury Cars <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=suv">SUVs & Crossovers <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=sedan">Sedans <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=sports">Sports Cars <i class="fas fa-chevron-right"></i></a></li>

                                    <!-- Phân loại theo nhiên liệu -->
                                    <li><a href="${pageContext.request.contextPath}/car/list?fuel=Electric">Electric Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?fuel=Hybrid">Hybrid Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?fuel=Gasoline">Gasoline Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?fuel=Diesel">Diesel Vehicles <i class="fas fa-chevron-right"></i></a></li>

                                    <!-- Phân loại theo giá -->
                                    <li><a href="${pageContext.request.contextPath}/car/list?price=25000-50000">Affordable Cars <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?price=50000-80000">Premium Cars <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?price=80000-125000">High-End Luxury <i class="fas fa-chevron-right"></i></a></li>

                                    <!-- Tất cả xe -->
                                    <li><a href="${pageContext.request.contextPath}/car/list">All Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                </ul>
                            </div>

                            <!-- Car Previews -->
                            <div class="mega-menu-content">
                                <div class="cars-grid">
                                    <c:forEach var="car" items="${latestCars}" varStatus="loop">
                                        <c:if test="${loop.index < 8}">
                                            <div class="car-preview">
                                                <div class="car-preview-img-wrapper">
                                                    <img src="${pageContext.request.contextPath}/asset/img/cars/${car.carImg}" alt="${car.carBrand} ${car.carName}">
                                                </div>
                                                <div class="car-model">
                                                    ${car.carName} <span class="car-model-badge">®</span>
                                                </div>
                                                <div class="car-price">
                                                    Starting at $${car.carPrice}<sup>1</sup>
                                                </div>
                                                <c:if test="${car.categoryId == 3}">
                                                    <div class="car-badge">
                                                        <i class="fas fa-leaf"></i> Hybrid Available
                                                    </div>
                                                </c:if>
                                                <c:if test="${car.categoryId == 4}">
                                                    <div class="car-badge electric">
                                                        <i class="fas fa-bolt"></i> All Electric
                                                    </div>
                                                </c:if>
                                            </div>
                                        </c:if>
                                    </c:forEach>

                                    <!-- Fallback if no cars in database -->
                                    <c:if test="${empty latestCars}">
                                        <div class="car-preview">
                                            <img src="${pageContext.request.contextPath}/asset/img/cars/mercedes-s-class.png" alt="Mercedes S-Class">
                                            <div class="car-model">
                                                S-Class <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $110,000<sup>1</sup>
                                            </div>
                                        </div>
                                        <div class="car-preview">
                                            <img src="${pageContext.request.contextPath}/asset/img/cars/bmw-7-series.png" alt="BMW 7 Series">
                                            <div class="car-model">
                                                7 Series <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $93,300<sup>1</sup>
                                            </div>
                                            <div class="car-badge electric">
                                                <i class="fas fa-bolt"></i> All Electric
                                            </div>
                                        </div>
                                        <div class="car-preview">
                                            <img src="${pageContext.request.contextPath}/asset/img/cars/audi-a8.png" alt="Audi A8">
                                            <div class="car-model">
                                                A8 <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $86,500<sup>1</sup>
                                            </div>
                                        </div>
                                        <div class="car-preview">
                                            <img src="${pageContext.request.contextPath}/asset/img/cars/lexus-ls.png" alt="Lexus LS">
                                            <div class="car-model">
                                                LS <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $77,250<sup>1</sup>
                                            </div>
                                            <div class="car-badge">
                                                <i class="fas fa-leaf"></i> Hybrid Available
                                            </div>
                                        </div>
                                    </c:if>
                                </div>

                            </div>
                        </div>
                    </li>

                    <li class="dropdown-container">
                        <a href="${pageContext.request.contextPath}/parts" class="${pageContext.request.servletPath eq '/parts' ? 'active' : ''}">
                            Parts <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="mega-dropdown parts-dropdown">
                            <!-- Sidebar for Parts (brand list or category list) -->
                            <div class="mega-menu-sidebar" style="width: 100%;">
                                <ul>
                                    <c:forEach var="brand" items="${partBrands}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/parts?brand=${brand}">
                                                ${brand}</i>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </li>

                    <li><a href="${pageContext.request.contextPath}/services" class="${pageContext.request.servletPath eq '/services' ? 'active' : ''}">Services</a></li>

                    <li><a href="${pageContext.request.contextPath}/about.jsp" class="${pageContext.request.servletPath eq '/about.jsp' ? 'active' : ''}">About</a></li>

                    <li><a href="${pageContext.request.contextPath}/blog"
                       class="${pageContext.request.servletPath eq '/blog' ? 'active' : ''}">Blog</a></li>
      
                    <li><a href="${pageContext.request.contextPath}/serviceAppointment" class="${pageContext.request.servletPath eq '/contact.jsp' ? 'active' : ''}">Contact</a></li>
                    <li><a href="feedback.jsp" class="${pageContext.request.servletPath eq '/feedback.jsp' ? 'active' : ''}">Feedback</a></li>
                </ul>
            </nav>

            <div class="right-section">
                <c:if test="${sessionScope.account != null || user != null}">
                    <div class="header-actions">
                        <a href="${pageContext.request.contextPath}/cart" class="cart-icon" title="Shopping Cart">
                            <i class="fas fa-shopping-cart"></i>
                            <span class="cart-badge" id = "cart-count">${cartCount}</span>
                        </a>
                        <!-- Profile dropdown -->
                        <div class="profile-dropdown">
                            <i class="fas fa-user profile-avatar"></i>
                            <div class="profile-menu">
                                <ul>
                                    <li><a href="profile.jsp"><i class="fas fa-user"></i> Profile</a></li>
                                    <li><a href="${pageContext.request.contextPath}/order"><i class="fas fa-shopping-bag"></i> Orders</a></li>
                                    <li><a href="${pageContext.request.contextPath}/appointment"><i class="fas fa-calendar-check"></i> Appointment
                                        </a></li>
                                    <li><a href="service-bookings.jsp"><i class="fas fa-tools"></i> Service Booking</a></li>
                                     <c:if test="${sessionScope.user != null && sessionScope.user.roleId == 1}">
                                        <li>
                                            <a href="${pageContext.request.contextPath}/admin/dashboard"
                                            class="admin-dashboard-btn ${pageContext.request.servletPath eq '/admin/dashboard.jsp' ? 'active' : ''}">
                                            <i class="fas fa-desktop"></i>Dashboard
                                            </a>
                                        </li>
                                    </c:if>
                                    <li class="menu-divider"></li>
                                    <li><a href="${pageContext.request.contextPath}/auth/LoginServlet?action=logout"><i class="fas fa-sign-out-alt"></i> Log out</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${sessionScope.account == null && user == null}">
                    <a href="${pageContext.request.contextPath}/auth/login.jsp" class="login-btn">Login</a>
                </c:if>
            </div>
        </div>
    </div>
</header>
<div id="cart-notification"
     style="display: none;
     position: fixed;
     top: 80px; /* bên dưới header */
     left: 50%;
     transform: translateX(-50%);
     background: rgba(0, 128, 0, 0.9);
     color: white;
     padding: 15px 20px;
     border-radius: 8px;
     font-size: 16px;
     text-align: center;
     z-index: 1000;
     min-width: 250px;
     max-width: 90%;
     box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);">
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        const header = document.querySelector('.header');
        const logoWhite = document.querySelector('.logo-white');
        const logoDark = document.querySelector('.logo-dark');
        const forceDark = '${forceDarkNavbar}' === 'true';
        const hasBanner = document.querySelector('.hero-banner') !== null;

        function updateNavbar() {
            if (forceDark === true) {
                header.classList.remove('scrolled');
                if (logoWhite)
                    logoWhite.style.display = 'block';
                if (logoDark)
                    logoDark.style.display = 'none';
                return;
            }

            if (window.scrollY > 50 || !hasBanner) {
                header.classList.add('scrolled');
                if (logoWhite)
                    logoWhite.style.display = 'none';
                if (logoDark)
                    logoDark.style.display = 'block';
            } else {
                header.classList.remove('scrolled');
                if (logoWhite)
                    logoWhite.style.display = 'block';
                if (logoDark)
                    logoDark.style.display = 'none';
            }
        }

        updateNavbar();
        window.addEventListener('scroll', updateNavbar);
    });
</script>
<script src="${pageContext.request.contextPath}/asset/js/cart_AddToCart.js?v=<%= System.currentTimeMillis()%>"></script>

