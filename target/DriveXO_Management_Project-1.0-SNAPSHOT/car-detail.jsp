<%-- 
    Document   : car-detail
    Created on : May 18, 2025, 11:30:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - Chi tiết xe</title>
        <link rel="stylesheet" href="../asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <!-- Thêm CSS tùy chỉnh cho trang chi tiết xe mới -->
        <style>
            /* Banner, breadcrumb và tiêu đề */
            .page-title-section {
                background-color: #f8f9fa;
                padding: 30px 0;
            }
            
            /* Thiết kế mới cho trang chi tiết xe */
            .car-detail-hero {
                background-color: #f8f9fa;
                padding: 50px 0;
            }
            
            .car-detail-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
            }
            
            /* Phần Gallery cải tiến */
            .car-gallery {
                position: relative;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            
            .main-image {
                height: 400px;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #f8f9fa;
                border-radius: 10px 10px 0 0;
                margin-bottom: 0;
                border: none;
            }
            
            .main-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .thumbnail-images {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 10px;
                padding: 15px;
                background-color: #fff;
            }
            
            .thumbnail {
                width: 100%;
                height: 70px;
                border-radius: 5px;
                cursor: pointer;
                overflow: hidden;
                transition: all 0.3s;
            }
            
            /* Thông tin xe cải tiến */
            .car-info-card {
                background-color: #fff;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            }
            
            .price-tag {
                font-size: 28px;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            
            .price-tag .price-label {
                font-size: 14px;
                font-weight: 400;
                color: #777;
            }
            
            .quick-info-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 15px;
                margin-bottom: 25px;
            }
            
            .quick-info-item {
                text-align: center;
                padding: 15px 10px;
                background-color: #f8f9fa;
                border-radius: 8px;
            }
            
            .quick-info-item i {
                font-size: 24px;
                color: var(--primary-color);
                margin-bottom: 8px;
            }
            
            .quick-info-item .info-value {
                font-weight: 600;
                font-size: 16px;
                color: #333;
            }
            
            .quick-info-item .info-label {
                font-size: 12px;
                color: #777;
            }
            
            .contact-action-btn {
                width: 100%;
                padding: 14px 20px;
                border-radius: 8px;
                font-weight: 600;
                font-size: 16px;
                text-align: center;
                margin-bottom: 15px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                transition: all 0.3s;
            }
            
            .btn-phone {
                background-color: var(--primary-color);
                color: #fff;
                border: none;
            }
            
            .btn-phone:hover {
                background-color: var(--secondary-color);
            }
            
            .btn-message {
                background-color: #fff;
                color: var(--primary-color);
                border: 1px solid var(--primary-color);
            }
            
            .btn-message:hover {
                background-color: rgba(7, 46, 176, 0.05);
            }
            
            /* Phần nội dung chi tiết */
            .car-detail-tabs {
                margin-top: 40px;
            }
            
            .detail-tabs-nav {
                display: flex;
                border-bottom: 1px solid #ddd;
                margin-bottom: 30px;
            }
            
            .detail-tab-btn {
                padding: 15px 25px;
                font-weight: 600;
                font-size: 16px;
                color: #777;
                border: none;
                background: transparent;
                cursor: pointer;
                position: relative;
            }
            
            .detail-tab-btn.active {
                color: var(--primary-color);
            }
            
            .detail-tab-btn.active:after {
                content: "";
                position: absolute;
                bottom: -1px;
                left: 0;
                width: 100%;
                height: 3px;
                background-color: var(--primary-color);
            }
            
            .detail-tab-content {
                margin-bottom: 40px;
            }
            
            .tab-pane {
                display: none;
            }
            
            .tab-pane.active {
                display: block;
            }
            
            /* Seller info */
            .seller-card {
                background-color: #fff;
                border-radius: 10px;
                padding: 25px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            
            .seller-header {
                display: flex;
                align-items: center;
                gap: 15px;
                margin-bottom: 20px;
            }
            
            .seller-avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                overflow: hidden;
            }
            
            .seller-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .seller-name {
                font-size: 18px;
                font-weight: 600;
            }
            
            .seller-type {
                font-size: 12px;
                color: #777;
            }
            
            .seller-info-item {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 12px;
                font-size: 14px;
            }
            
            .seller-info-item i {
                width: 20px;
                color: var(--primary-color);
            }
            
            /* Additional styles for tab content */
            .tab-overview-content h3,
            .features-content h3,
            .specs-content h3 {
                font-size: 20px;
                font-weight: 700;
                margin-bottom: 20px;
                color: #333;
            }
            
            .tab-overview-content p {
                margin-bottom: 20px;
                line-height: 1.6;
                color: #555;
            }
            
            .overview-grid {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                margin-top: 30px;
            }
            
            .features-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 30px;
            }
            
            .feature-list h4 {
                font-size: 18px;
                font-weight: 600;
                margin-bottom: 15px;
                color: var(--primary-color);
                padding-bottom: 8px;
                border-bottom: 1px solid #eee;
            }
            
            .feature-list ul li {
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            
            .feature-list ul li i {
                color: var(--success-color);
            }
            
            .specs-table-wrapper {
                overflow-x: auto;
            }
            
            .specs-table {
                width: 100%;
                border-collapse: collapse;
            }
            
            .specs-table th {
                background-color: #f5f7fa;
                padding: 12px 15px;
                text-align: left;
                font-weight: 600;
                font-size: 16px;
                color: var(--primary-color);
            }
            
            .specs-table td {
                padding: 12px 15px;
                border-bottom: 1px solid #eee;
                font-size: 14px;
            }
            
            .specs-table tr:last-child td {
                border-bottom: none;
            }
            
            .specs-table tr:nth-child(even) {
                background-color: #fbfbfb;
            }
            
            @media (max-width: 992px) {
                .car-detail-wrapper {
                    grid-template-columns: 1fr;
                }
                
                .features-grid {
                    grid-template-columns: 1fr;
                }
                
                .overview-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            
            @media (max-width: 768px) {
                .detail-tabs-nav {
                    overflow-x: auto;
                    white-space: nowrap;
                    padding-bottom: 5px;
                }
                
                .detail-tab-btn {
                    padding: 12px 15px;
                    font-size: 14px;
                }
                
                .overview-grid {
                    grid-template-columns: 1fr;
                }
            }
            
            /* Contact form styles */
            .contact-form {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 20px;
                margin-top: 20px;
                display: none;
            }
            
            .contact-form .form-group {
                margin-bottom: 15px;
            }
            
            .contact-form input,
            .contact-form textarea {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
            }
            
            .contact-form textarea {
                height: 100px;
                resize: none;
            }
            
            .contact-form .submit-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
            }
            
            .contact-form .submit-btn:hover {
                background-color: var(--secondary-color);
            }
        </style>
    </head>
    <body>
        <!-- Header (Giống như car-list.jsp) -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <div class="breadcrumb">
                    <a href="../home.jsp">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="car-list.jsp">Cars</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>${car.year} ${car.carName}</span>
                </div>
            </div>
        </section>

        <!-- Car Detail Hero Section -->
        <section class="car-detail-hero">
            <div class="container">
                <div class="car-detail-wrapper">
                    <!-- Gallery Section -->
                    <div class="car-gallery">
                        <div class="main-image">
                            <!-- Main Car Image -->
                            <img src="${pageContext.request.contextPath}/car/image?id=${car.carId}" alt="${car.carBrand} ${car.carName}" id="main-car-image">
                        </div>
                        <div class="thumbnail-images">
                            <%-- You might need a dynamic way to load thumbnails based on the car object --%>
                            <%-- Example for a single thumbnail, you'll need logic to get multiple images if available --%>
                            <c:if test="${car.carImg != null}">
                                <div class="thumbnail active" onclick="changeImage('${pageContext.request.contextPath}/car/image?id=${car.carId}')">
                                    <img src="${pageContext.request.contextPath}/car/image?id=${car.carId}" alt="${car.carName} - Image">
                                </div>
                            </c:if>
                        </div>
                    </div>
                    
                    <!-- Car Info Card -->
                    <div class="car-info-card">
                        <h1>${car.year} ${car.carName}</h1>
                        <div class="price-tag">
                            <span>$<c:out value="${car.carPrice}" /></span>
                            <div class="price-label">
                                <i class="fas fa-tag"></i> Giá đặc biệt
                            </div>
                        </div>
                        
                        <div class="quick-info-grid">
                            <div class="quick-info-item">
                                <i class="fas fa-calendar-alt"></i>
                                <div class="info-value">${car.year}</div>
                                <div class="info-label">Model Year</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-tachometer-alt"></i>
                                <div class="info-value">${car.carOdo}</div>
                                <div class="info-label">Mileage (mi)</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-gas-pump"></i>
                                <div class="info-value">Gasoline</div>
                                <div class="info-label">Fuel Type</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-cogs"></i>
                                <div class="info-value">Automatic</div>
                                <div class="info-label">Transmission</div>
                            </div>
                        </div>
                        
                        <button class="contact-action-btn btn-phone">
                            <i class="fas fa-phone"></i> 0915456680
                        </button>
                        
                        <button class="contact-action-btn btn-message">
                            <i class="fas fa-comment"></i> Text to seller
                        </button>
                        
                     
                        
                        <!-- Thông tin người bán -->
                        
                    </div>
                </div>
            </div>
        </section>
        
        <!-- Car Detail Tabs Section -->
        <section class="car-detail-tabs">
            <div class="container">
                <div class="detail-tabs-nav">
                    <button class="detail-tab-btn active" data-tab="overview">Tổng quan</button>
                    <button class="detail-tab-btn" data-tab="features">Tính năng</button>
                    <button class="detail-tab-btn" data-tab="specs">Thông số kỹ thuật</button>
                </div>
            </div>
        </section>

        <!-- Similar Cars Section -->
        <section class="similar-cars-section">
            <div class="container">
                <div class="section-header">
                    <div>
                        <h4 class="section-label">Đề xuất cho bạn</h4>
                        <h2 class="section-title">Xe tương tự</h2>
                    </div>
                </div>
                <div class="car-cards">
                    <!-- Car 1 -->
                    <div class="car-card" data-id="car2">
                        <div class="card-image">
                            <span class="tag">New</span>
                            <!-- Car Image: 300x200px -->
                            <img src="../asset/img/cars/alfa-romeo.png" alt="Nissan Alfa Romeo Giulia">
                            <div class="card-actions">
                                <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="car-brand">Nissan</div>
                            <h3 class="car-name">2019 Alfa Romeo Giulia</h3>
                            <div class="car-price">$180.00</div>
                            <div class="car-specs">
                                <div class="spec">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>1,20,520(mi)</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Gasoline</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-cog"></i>
                                    <span>2,350 (cc)</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <span class="listing-author">Listed by: John Doe</span>
                                <a href="${pageContext.request.contextPath}/car/detail?id=car2" class="view-details">View Details</a>
                            </div>
                        </div>
                    </div>

                    <!-- Car 2 -->
                    <div class="car-card" data-id="car3">
                        <div class="card-image">
                            <span class="tag">New</span>
                            <!-- Car Image: 300x200px -->
                            <img src="../asset/img/cars/atra-benz-yellow.png" alt="Chevrolet Altra Benz C-Class">
                            <div class="card-actions">
                                <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="car-brand">Chevrolet</div>
                            <h3 class="car-name">2020 Altra Benz C-Class</h3>
                            <div class="car-price">$500.00</div>
                            <div class="car-specs">
                                <div class="spec">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>1,20,520(mi)</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Gasoline</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-cog"></i>
                                    <span>2,350 (cc)</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <span class="listing-author">Listed by: John Doe</span>
                                <a href="${pageContext.request.contextPath}/car/detail?id=car3" class="view-details">View Details</a>
                            </div>
                        </div>
                    </div>

                    <!-- Car 3 -->
                    <div class="car-card" data-id="car4">
                        <div class="card-image">
                            <span class="tag">New</span>
                            <!-- Car Image: 300x200px -->
                            <img src="../asset/img/cars/atra-benz-black.png" alt="Hyundai Altra Benz C-Class">
                            <div class="card-actions">
                                <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                            </div>
                        </div>
                        <div class="card-content">
                            <div class="car-brand">Hyundai</div>
                            <h3 class="car-name">2007 Altra Benz C-Class</h3>
                            <div class="car-price">$3,000.00</div>
                            <div class="car-specs">
                                <div class="spec">
                                    <i class="fas fa-tachometer-alt"></i>
                                    <span>1,20,520(mi)</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-gas-pump"></i>
                                    <span>Gasoline</span>
                                </div>
                                <div class="spec">
                                    <i class="fas fa-cog"></i>
                                    <span>2,350 (cc)</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <span class="listing-author">Listed by: John Doe</span>
                                <a href="${pageContext.request.contextPath}/car/detail?id=car4" class="view-details">View Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer (Giống như car-list.jsp) -->
        <footer class="footer black-footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-col">
                        <div class="footer-logo">
                            <!-- Footer Logo: 120x40px -->
                            <img src="../asset/img/driverxo-logo-white.png" alt="DriverXO">
                            <span>DriverXO</span>
                        </div>
                        <p>There are many variations of passages of Lorem Ipsum a majority have suffered alteration in some form, by injected humour or randomised words which.</p>
                        <div class="social-links">
                            <h4>Follow Us:</h4>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#"><i class="fab fa-twitter"></i></a>
                            <a href="#"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-facebook-f"></i></a>
                        </div>
                    </div>
                    <div class="footer-col">
                        <h3>Popular links</h3>
                        <ul>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> About Us</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Contact Us</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Our Blogs</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Join as Dealer</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>My Profile</h3>
                        <ul>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Dashboard</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Manage Car</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Edit Profile</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Review List</a></li>
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>Contact Us</h3>
                        <ul class="contact-info">
                            <li><i class="fas fa-phone"></i> 0915456680</li>
                            <li><i class="fas fa-envelope"></i> fpt@gmail.com</li>
                            <li><i class="fas fa-map-marker-alt"></i> Vo Gia Huy, <br>Ca Mau City</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <div class="container">
                    <div class="copyright">
                        <p>Copyright 2024 DuomodeSoft. All Rights Reserved</p>
                    </div>
                    <div class="footer-links">
                        <a href="#">Privacy Policy</a>
                        <a href="#">Terms & Conditions</a>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Cookie Consent -->
        <div class="cookie-consent">
            <div class="cookie-text">
                <h3>Cookies</h3>
                <p>Group3 SWP.</p>
            </div>
            <button class="accept-btn">Accept</button>
            <button class="close-btn"><i class="fas fa-times"></i></button>
        </div>

        <!-- JavaScript -->
        <script src="../asset/js/main.js"></script>
        <script>
            // Hàm đổi hình ảnh chính
            function changeImage(src) {
                document.getElementById('main-car-image').src = src;
                
                // Cập nhật trạng thái thumbnail
                const thumbnails = document.querySelectorAll('.thumbnail');
                thumbnails.forEach(thumb => {
                    if (thumb.querySelector('img').src === src) {
                        thumb.classList.add('active');
                    } else {
                        thumb.classList.remove('active');
                    }
                });
            }
            
            // Xử lý tabs
            document.addEventListener('DOMContentLoaded', function() {
                // Lấy tất cả các nút tab
                const tabButtons = document.querySelectorAll('.detail-tab-btn');
                
                // Thêm event listener cho mỗi nút
                tabButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        // Xóa trạng thái active từ tất cả các nút và tab content
                        document.querySelectorAll('.detail-tab-btn').forEach(btn => {
                            btn.classList.remove('active');
                        });
                        
                        document.querySelectorAll('.tab-pane').forEach(pane => {
                            pane.classList.remove('active');
                        });
                        
                        // Thêm trạng thái active cho nút được click
                        this.classList.add('active');
                        
                        // Hiển thị tab content tương ứng
                        const tabId = this.getAttribute('data-tab');
                        document.getElementById(tabId).classList.add('active');
                    });
                });
                
                // Button contact toggle
                const messageBtn = document.querySelector('.btn-message');
                const contactForm = document.querySelector('.contact-form');
                
                if (messageBtn && contactForm) {
                    messageBtn.addEventListener('click', function() {
                        // Kiểm tra xem contact form có đang hiển thị không
                        if (contactForm.style.display === 'block') {
                            contactForm.style.display = 'none';
                        } else {
                            contactForm.style.display = 'block';
                        }
                    });
                }
            });
        </script>
    </body>
</html> 