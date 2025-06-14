<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    /* Minimal Modern Navbar Styles */
    .header {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        transition: all 0.3s ease;
        background-color: transparent;
    }
    
    .header.scrolled {
        background-color: #fff;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }
    
    .compact-header .main-header {
        padding: 20px 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    
    .compact-header .logo a {
        font-size: 22px;
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
        height: 28px;
        margin-right: 10px;
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
        gap: 40px;
        padding: 0;
        margin: 0;
    }
    
    .main-nav ul li {
        list-style: none;
        position: relative;
    }
    
    .main-nav a {
        color: #fff;
        font-size: 14px;
        font-weight: 400;
        text-decoration: none;
        letter-spacing: 1px;
        transition: all 0.3s ease;
        padding: 5px 0;
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
        background-color: #fff;
        transition: width 0.3s ease;
    }
    
    .header.scrolled .main-nav a:after {
        background-color: #000;
    }
    
    .main-nav a:hover:after,
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
        width: 1000px;
        background-color: #fff;
        box-shadow: 0 5px 15px rgba(0,0,0,0.05);
        opacity: 0;
        visibility: hidden;
        transform: translateY(10px);
        transition: all 0.3s ease;
        z-index: 1000;
        display: flex;
        margin-top: 20px;
        max-height: 80vh;
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
        width: 250px;
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
        padding: 15px 20px;
        color: #333;
        font-size: 14px;
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
        padding: 30px;
        background-color: #fff;
    }
    
    .cars-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 25px;
    }
    
    .car-preview {
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
        padding: 10px;
        transition: all 0.3s ease;
    }
    
    .car-preview:hover {
        transform: translateY(-5px);
    }
    
    .car-preview img {
        width: 100%;
        height: auto;
        margin-bottom: 15px;
        transition: all 0.3s ease;
    }
    
    .car-model {
        font-weight: 500;
        color: #000;
        margin-bottom: 5px;
        font-size: 14px;
    }
    
    .car-model-badge {
        font-size: 10px;
        vertical-align: super;
    }
    
    .car-price {
        color: #666;
        font-size: 13px;
        margin-bottom: 8px;
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
        margin-top: 25px;
        color: #000;
        font-size: 14px;
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
        padding: 8px 20px;
        background-color: transparent;
        border: 1px solid #fff;
        color: #fff;
        font-size: 13px;
        text-decoration: none;
        letter-spacing: 1px;
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
        gap: 20px;
    }
    
    .header-actions a {
        color: #fff;
        font-size: 16px;
        transition: all 0.3s ease;
    }
    
    .header.scrolled .header-actions a {
        color: #000;
    }
    
    .header-actions a:hover {
        opacity: 0.8;
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
                    <a href="home.jsp">
                        <img src="asset/img/driverxo-logo-white.png" alt="DriverXO" class="logo-white">
                        <img src="asset/img/driverxo-logo.png" alt="DriverXO" class="logo-dark" style="display: none;">
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
                        <a href="car-list.jsp" class="dropdown-toggle ${pageContext.request.servletPath eq '/car-list.jsp' ? 'active' : ''}">
                            Cars <i class="fas fa-chevron-down"></i>
                        </a>
                        <div class="mega-dropdown">
                            <!-- Sidebar Categories -->
                            <div class="mega-menu-sidebar">
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=suv">SUVs & Cars <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=truck">Trucks & Vans <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=electric">Electric & Hybrid <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=performance">Performance Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=commercial">Commercial Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list?category=future">Future Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                    <li><a href="${pageContext.request.contextPath}/car/list">All Vehicles <i class="fas fa-chevron-right"></i></a></li>
                                </ul>
                            </div>
                            
                            <!-- Car Previews -->
                            <div class="mega-menu-content">
                                <div class="cars-grid">
                                    <c:forEach var="car" items="${latestCars}" varStatus="loop">
                                        <c:if test="${loop.index < 8}">
                                            <div class="car-preview">
                                                <img src="asset/img/cars/${car.carBrand.toLowerCase()}-${car.model.toLowerCase().replace(' ', '-')}.png" alt="${car.carBrand} ${car.carName}">
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
                                            <img src="asset/img/cars/mercedes-s-class.png" alt="Mercedes S-Class">
                                            <div class="car-model">
                                                S-Class <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $110,000<sup>1</sup>
                                            </div>
                                        </div>
                                        <div class="car-preview">
                                            <img src="asset/img/cars/bmw-7-series.png" alt="BMW 7 Series">
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
                                            <img src="asset/img/cars/audi-a8.png" alt="Audi A8">
                                            <div class="car-model">
                                                A8 <span class="car-model-badge">®</span>
                                            </div>
                                            <div class="car-price">
                                                Starting at $86,500<sup>1</sup>
                                            </div>
                                        </div>
                                        <div class="car-preview">
                                            <img src="asset/img/cars/lexus-ls.png" alt="Lexus LS">
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
                                
                                <a href="${pageContext.request.contextPath}/car/list" class="see-all-link">
                                    See the DriveXO Family of Luxury Cars <i class="fas fa-chevron-right"></i>
                                </a>
                            </div>
                        </div>
                    </li>
                    <li><a href="#" class="${pageContext.request.servletPath eq '/services.jsp' ? 'active' : ''}">Services</a></li>
                    <li><a href="#" class="${pageContext.request.servletPath eq '/about.jsp' ? 'active' : ''}">About</a></li>
                    <li><a href="#" class="${pageContext.request.servletPath eq '/contact.jsp' ? 'active' : ''}">Contact</a></li>
                    <li><a href="feedback.jsp" class="${pageContext.request.servletPath eq '/feedback.jsp' ? 'active' : ''}">Feedback</a></li>
                </ul>
            </nav>
            
            <div class="right-section">
                <c:if test="${sessionScope.account != null}">
                    <div class="header-actions">
                        <a href="cart.jsp" class="cart-icon"><i class="fas fa-shopping-cart"></i></a>
                        <a href="#" class="compare-icon"><i class="fas fa-exchange-alt"></i></a>
                    </div>
                </c:if>
                <a href="auth/login.jsp" class="login-btn">
                    <c:choose>
                        <c:when test="${sessionScope.account != null}">
                            My Account
                        </c:when>
                        <c:otherwise>
                            Login
                        </c:otherwise>
                    </c:choose>
                </a>
            </div>
        </div>
    </div>
</header>

<script>
    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('.header');
        const logoWhite = document.querySelector('.logo-white');
        const logoDark = document.querySelector('.logo-dark');
        
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
            logoWhite.style.display = 'none';
            logoDark.style.display = 'block';
        } else {
            header.classList.remove('scrolled');
            logoWhite.style.display = 'block';
            logoDark.style.display = 'none';
        }
    });
</script>
