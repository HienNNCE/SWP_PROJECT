<%-- 
    Document   : home
    Created on : May 17, 2025, 12:33:32 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - World of Cars</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <!-- Google Fonts - Montserrat -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <!-- Include Navbar -->
        <jsp:include page="components/navbar.jsp" />

        <!-- Hero Banner - Minimal & Modern -->
        <section class="hero-banner">
            <img src="asset/img/banner.jpg" alt="DriverXO Banner">
            <div class="hero-content">
                <h1 class="hero-title"><span class="animate-text">DriverXO</span></h1>
                <p class="hero-subtitle">Your trusted destination for quality vehicles at competitive prices. We make car buying simple.</p>
                <a href="car/list" class="hero-btn">View Our Collection</a>
            </div>
        </section>

        <!-- Luxury Brands Section - Premium Redesign -->
        <section class="luxury-brands">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Exceptional Marques</h2>
                    <p class="section-subtitle">Discover prestigious automotive brands that define luxury, performance, and innovation in the modern era</p>
                </div>
                
                <div class="brands-showcase">
                    <!-- Mercedes-Benz -->
                    <div class="brand-row">
                        <div class="brand-video-container">
                            <img src="asset/img/cars/mercedes_s-class.jpg" alt="Mercedes-Benz" class="brand-img" style="width:100%;height:100%;object-fit:cover;opacity:0.85;">
                            <div class="video-overlay"></div>
                        </div>
                        <div class="brand-content">
                            <div class="brand-logo">
                                <img src="asset/img/brands/mercedes.png" alt="Mercedes-Benz">
                            </div>
                            <h3 class="brand-name">Mercedes-Benz</h3>
                            <p class="brand-desc">The pinnacle of German engineering, Mercedes-Benz represents luxury, innovation, and performance. With a legacy spanning over a century, the brand continues to set standards in automotive excellence.</p>
                            <div class="brand-stats">
                                <div class="stat-item">
                                    <span class="stat-value">1886</span>
                                    <span class="stat-label">Founded</span>
                                </div>
                                <div class="stat-item">
                                    <span class="stat-value">3</span>
                                    <span class="stat-label">Models Available</span>
                                </div>
                            </div>
                            <a href="#" class="brand-link">Explore Mercedes-Benz Collection</a>
                        </div>
                    </div>
                    
                    <!-- BMW -->
                    <div class="brand-row">
                        <div class="brand-video-container">
                            <img src="asset/img/cars/bmw_m4.jpg" alt="BMW" class="brand-img" style="width:100%;height:100%;object-fit:cover;opacity:0.85;">
                            <div class="video-overlay"></div>
                        </div>
                        <div class="brand-content">
                            <div class="brand-logo">
                                <img src="asset/img/brands/bmw.png" alt="BMW">
                            </div>
                            <h3 class="brand-name">BMW</h3>
                            <p class="brand-desc">Known for creating the ultimate driving machines, BMW blends sporty performance with luxurious comfort. The brand's commitment to innovation has resulted in vehicles that deliver an unparalleled driving experience.</p>
                            <div class="brand-stats">
                                <div class="stat-item">
                                    <span class="stat-value">1916</span>
                                    <span class="stat-label">Founded</span>
                                </div>
                                <div class="stat-item">
                                    <span class="stat-value">5</span>
                                    <span class="stat-label">Models Available</span>
                                </div>
                            </div>
                            <a href="#" class="brand-link">Explore BMW Collection</a>
                        </div>
                    </div>
                </div>
                
                <div class="brands-grid">
                    <div class="brand-mini">
                        <img src="asset/img/brands/chevrolet.png" alt="Chevrolet">
                    </div>
                    <div class="brand-mini">
                        <img src="asset/img/brands/honda.png" alt="Honda">
                    </div>
                    <div class="brand-mini">
                        <img src="asset/img/brands/hyundai.png" alt="Hyundai">
                    </div>
                    <div class="brand-mini">
                        <img src="asset/img/brands/nissan.png" alt="Nissan">
                    </div>
                    <div class="brand-mini">
                        <img src="asset/img/brands/mercedes.png" alt="Mercedes-Benz">
                    </div>
                    <div class="brand-mini">
                        <img src="asset/img/brands/bmw.png" alt="BMW">
                    </div>
                </div>
            </div>
        </section>

        <!-- Featured Cars Section - Ultra Minimalist Design -->
        <section class="featured-cars">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Featured Vehicles</h2>
                    <p class="section-subtitle">Discover our premium selection of luxury vehicles</p>
                </div>
                
                <div class="featured-cars-slider-container">
                    <div class="featured-nav featured-prev">
                        <i class="fas fa-chevron-left"></i>
                    </div>
                    
                    <div class="featured-cars-slider">
                        <c:forEach var="car" items="${latestCars}">
                            <div class="featured-car-item">
                                <div class="featured-car-image">
                                    <span class="featured-car-tag">New</span>
                                    <img src="asset/img/cars/${not empty car.carImg ? car.carImg : car.carBrand.toLowerCase().replaceAll(' ', '_').concat('_').concat(car.carName.toLowerCase().replaceAll(' ', '_')).concat('.webp')}" 
                                         onerror="this.src='asset/img/cars/default-car.png'" 
                                         alt="${car.carBrand} ${car.carName}">
                                    <div class="featured-car-actions">
                                        <button class="featured-car-action" title="Favorite">
                                            <i class="far fa-heart"></i>
                                        </button>
                                        <button class="featured-car-action" title="Compare">
                                            <i class="fas fa-exchange-alt"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="featured-car-content">
                                    <div class="featured-car-brand">${car.carBrand}</div>
                                    <h3 class="featured-car-name">${car.carName} (${car.carYear.getYear() + 1900})</h3>
                                    <div class="featured-car-price">
                                        $<fmt:formatNumber value="${car.carPrice}" type="number" pattern="#,###,###" />
                                    </div>
                                    <div class="featured-car-specs">
                                        <div class="featured-car-spec">
                                            <i class="fas fa-tachometer-alt spec-icon"></i>
                                            <span class="spec-value">
                                                <fmt:formatNumber value="${car.carOdo}" type="number" pattern="#,###" /> mi
                                            </span>
                                        </div>
                                        <div class="featured-car-spec">
                                            <i class="fas fa-gas-pump spec-icon"></i>
                                            <span class="spec-value">${car.fuelType}</span>
                                        </div>
                                        <div class="featured-car-spec">
                                            <i class="fas fa-cog spec-icon"></i>
                                            <span class="spec-value">${not empty car.displacement ? car.displacement : '2.0'} L</span>
                                        </div>
                                    </div>
                                    <div class="featured-car-footer">
                                        <a href="car/detail?id=${car.carId}" class="featured-car-more">
                                            Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="featured-nav featured-next">
                        <i class="fas fa-chevron-right"></i>
                    </div>
                </div>

                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/car/list" class="view-all-btn">View All Vehicles</a>
                </div>
            </div>
        </section>

        <!-- Services Section - Minimal -->
        <section class="services">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Our Services</h2>
                    <p class="section-subtitle">Exceptional automotive services tailored to your needs</p>
                </div>
                
                <div class="services-grid">
                    <!-- Service 1 -->
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-car"></i>
                        </div>
                        <h3 class="service-title">Premium Selection</h3>
                        <p class="service-desc">Access to a curated collection of luxury and high-performance vehicles from prestigious brands worldwide.</p>
                    </div>
                    
                    <!-- Service 2 -->
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-tools"></i>
                        </div>
                        <h3 class="service-title">Expert Maintenance</h3>
                        <p class="service-desc">Professional maintenance and repair services performed by certified technicians using genuine parts.</p>
                    </div>
                    
                    <!-- Service 3 -->
                    <div class="service-item">
                        <div class="service-icon">
                            <i class="fas fa-handshake"></i>
                        </div>
                        <h3 class="service-title">Personalized Consultation</h3>
                        <p class="service-desc">Tailored advice and guidance to help you find the perfect vehicle that matches your preferences and lifestyle.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Testimonials - Clean & Simple -->
        <section class="testimonials">
            <div class="container">
                <div class="section-header">
                    <h2 class="section-title">Client Experiences</h2>
                    <p class="section-subtitle">What our valued clients say about their journey with us</p>
                </div>
                
                <div class="testimonial-content">
                    <p class="testimonial-quote">"The attention to detail and personalized service at DriverXO exceeded all my expectations. Their team guided me through every step of finding my dream car, making the entire process seamless and enjoyable."</p>
                    <h4 class="testimonial-author">Alexander Mitchell</h4>
                    <p class="testimonial-role">Business Executive</p>
                </div>
            </div>
        </section>

        <!-- Contact CTA - Minimal -->
        <section class="contact-cta">
            <div class="container">
                <h2 class="cta-title">Ready to Find Your Perfect Vehicle?</h2>
                <p class="cta-text">Connect with our automotive specialists to begin your journey towards owning a luxury vehicle that reflects your unique style and preferences.</p>
                <a href="#" class="cta-btn">Contact Us</a>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Cookie consent functionality
                const cookieConsent = document.querySelector('.cookie-consent');
                const acceptBtn = document.querySelector('.accept-btn');
                const closeBtn = document.querySelector('.close-btn');
                
                if (cookieConsent && acceptBtn && closeBtn) {
                    acceptBtn.addEventListener('click', function() {
                        cookieConsent.style.display = 'none';
                        localStorage.setItem('cookieAccepted', 'true');
                    });
                    
                    closeBtn.addEventListener('click', function() {
                        cookieConsent.style.display = 'none';
                    });
                    
                    if (localStorage.getItem('cookieAccepted') === 'true') {
                        cookieConsent.style.display = 'none';
                    }
                }
                
                // Scroll animation for brand rows
                const brandRows = document.querySelectorAll('.brand-row');
                const brandsGrid = document.querySelector('.brands-grid');
                
                // Intersection Observer for animations
                const observerOptions = {
                    root: null,
                    rootMargin: '0px',
                    threshold: 0.2
                };
                
                const observer = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        if (entry.isIntersecting) {
                            entry.target.classList.add('animate');
                            observer.unobserve(entry.target);
                        }
                    });
                }, observerOptions);
                
                // Observe each brand row
                brandRows.forEach(row => {
                    observer.observe(row);
                });
                
                // Observe brands grid
                if (brandsGrid) {
                    observer.observe(brandsGrid);
                }
                
                // Featured cars slider
                const featuredSlider = document.querySelector('.featured-cars-slider');
                const featuredPrev = document.querySelector('.featured-prev');
                const featuredNext = document.querySelector('.featured-next');
                
                if (featuredSlider && featuredPrev && featuredNext) {
                    // Scroll amount for arrow buttons
                    const scrollAmount = 310; // Slightly wider than car width
                    
                    // Scroll left button
                    featuredPrev.addEventListener('click', () => {
                        featuredSlider.scrollBy({
                            left: -scrollAmount,
                            behavior: 'smooth'
                        });
                    });
                    
                    // Scroll right button
                    featuredNext.addEventListener('click', () => {
                        featuredSlider.scrollBy({
                            left: scrollAmount,
                            behavior: 'smooth'
                        });
                    });
                    
                    // Kiểm tra xem có nên hiển thị nút mũi tên không
                    const checkArrowVisibility = () => {
                        if (featuredSlider.scrollWidth <= featuredSlider.clientWidth) {
                            // Nếu không có cuộn ngang, ẩn cả hai nút
                            featuredPrev.style.display = 'none';
                            featuredNext.style.display = 'none';
                        } else {
                            // Hiển thị nút nếu cần cuộn
                            featuredPrev.style.display = 'flex';
                            featuredNext.style.display = 'flex';
                            
                            // Kiểm tra vị trí cuộn để làm mờ nút khi cần
                            if (featuredSlider.scrollLeft <= 10) {
                                featuredPrev.style.opacity = '0.5';
                                featuredPrev.style.pointerEvents = 'none';
                            } else {
                                featuredPrev.style.opacity = '1';
                                featuredPrev.style.pointerEvents = 'auto';
                            }
                            
                            if (featuredSlider.scrollLeft + featuredSlider.clientWidth >= featuredSlider.scrollWidth - 10) {
                                featuredNext.style.opacity = '0.5';
                                featuredNext.style.pointerEvents = 'none';
                            } else {
                                featuredNext.style.opacity = '1';
                                featuredNext.style.pointerEvents = 'auto';
                            }
                        }
                    };
                    
                    // Update arrow visibility on scroll
                    featuredSlider.addEventListener('scroll', checkArrowVisibility);
                    
                    // Initial check
                    checkArrowVisibility();
                    
                    // Check on window resize
                    window.addEventListener('resize', checkArrowVisibility);
                    
                    // Prevent horizontal scroll wheel event on featured slider
                    featuredSlider.addEventListener('wheel', (e) => {
                        if (e.deltaY !== 0) {
                            e.preventDefault();
                            featuredSlider.scrollLeft += e.deltaY;
                        }
                    });
                }
            });
        </script>

        <style>
            /* Featured Cars Section - Single Row Slider Design */
            .featured-cars {
                padding: 80px 0;
                background-color: #f9f9f9;
            }
            
            /* Container cho slider */
            .featured-cars-slider-container {
                position: relative;
                margin: 40px auto 0;
                max-width: 95%;
            }
            
            /* Slider chính */
            .featured-cars-slider {
                display: flex;
                overflow-x: auto;
                scroll-snap-type: x mandatory;
                scroll-behavior: smooth;
                -webkit-overflow-scrolling: touch;
                scrollbar-width: none; /* Firefox */
                -ms-overflow-style: none; /* IE and Edge */
                gap: 20px;
                padding: 10px 5px;
            }
            
            .featured-cars-slider::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
            }
            
            /* Nút điều hướng slider */
            .featured-nav {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                width: 36px;
                height: 36px;
                background: #fff;
                border: 1px solid #eee;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                color: #777;
                font-size: 12px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
                z-index: 3;
                transition: all 0.2s;
            }
            
            .featured-nav:hover {
                background: #f9f9f9;
                color: #333;
            }
            
            .featured-prev {
                left: -18px;
            }
            
            .featured-next {
                right: -18px;
            }
            
            /* Card xe */
            .featured-car-item {
                flex: 0 0 300px;
                scroll-snap-align: start;
                border: none;
                transition: all 0.2s;
                box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                border-radius: 2px;
                background: #fff;
                min-width: 300px;
                max-width: 300px;
            }
            
            .featured-car-item:hover {
                transform: translateY(-5px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.08);
            }
            
            .featured-car-image {
                position: relative;
                overflow: hidden;
                height: 180px;
            }
            
            .featured-car-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s;
            }
            
            .featured-car-item:hover .featured-car-image img {
                transform: scale(1.05);
            }
            
            .featured-car-tag {
                position: absolute;
                top: 10px;
                left: 10px;
                background: #000;
                color: #fff;
                font-size: 10px;
                padding: 2px 6px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .featured-car-actions {
                position: absolute;
                top: 10px;
                right: 10px;
                display: flex;
                gap: 5px;
                opacity: 0;
                transition: opacity 0.2s;
            }
            
            .featured-car-item:hover .featured-car-actions {
                opacity: 1;
            }
            
            .featured-car-action {
                background: rgba(255,255,255,0.9);
                border: none;
                width: 26px;
                height: 26px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                color: #333;
                font-size: 11px;
            }
            
            .featured-car-content {
                padding: 15px;
            }
            
            .featured-car-brand {
                font-size: 11px;
                color: #555;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-bottom: 4px;
                font-weight: 500;
            }
            
            .featured-car-name {
                font-size: 15px;
                font-weight: 500;
                margin-bottom: 8px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            
            .featured-car-price {
                font-size: 16px;
                margin-bottom: 12px;
                font-weight: 600;
            }
            
            .featured-car-specs {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                border-top: 1px solid #f0f0f0;
                padding-top: 8px;
                font-size: 11px;
            }
            
            .featured-car-spec {
                display: flex;
                align-items: center;
                gap: 4px;
                font-size: 11px;
                color: #666;
            }
            
            .featured-car-footer {
                display: flex;
                justify-content: flex-end;
                align-items: center;
                margin-top: 10px;
                padding-top: 10px;
                border-top: 1px solid #f0f0f0;
            }
            
            .featured-car-more {
                font-size: 11px;
                text-decoration: none;
                color: #000;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            
            .view-all {
                text-align: center;
                margin-top: 40px;
            }
            
            .view-all-btn {
                display: inline-block;
                padding: 10px 25px;
                background: #000;
                color: #fff;
                font-size: 14px;
                font-weight: 500;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                transition: all 0.3s ease;
                border: 1px solid #000;
            }
            
            .view-all-btn:hover {
                background: transparent;
                color: #000;
            }
            
            /* Responsive design */
            @media (max-width: 768px) {
                .featured-car-item {
                    flex: 0 0 260px;
                    min-width: 260px;
                }
                
                .featured-cars-slider-container {
                    max-width: 90%;
                }
            }
            
            @media (max-width: 576px) {
                .featured-car-item {
                    flex: 0 0 240px;
                    min-width: 240px;
                }
                
                .featured-cars-slider-container {
                    max-width: 85%;
                }
            }
        </style>
    </body>
</html>
