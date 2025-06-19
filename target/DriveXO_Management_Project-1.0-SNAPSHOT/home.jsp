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
        <style>
            /* Hero Banner Styles - Modern & Minimal */
            .hero-banner {
                position: relative;
                height: 100vh;
                width: 100%;
                overflow: hidden;
                background-color: #000;
            }
            
            .hero-banner video {
                width: 100%;
                height: 100%;
                object-fit: cover;
                opacity: 0.7;
            }
            
            .hero-banner::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to bottom, rgba(0,0,0,0.3), rgba(0,0,0,0.7));
                z-index: 1;
            }
            
            .hero-content {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                text-align: center;
                color: #fff;
                width: 80%;
                max-width: 800px;
                z-index: 2;
            }
            
            .hero-title {
                font-size: 72px;
                font-weight: 700;
                letter-spacing: 2px;
                margin-bottom: 20px;
                line-height: 1.1;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            }
            
            .animate-text {
                display: inline-block;
                opacity: 0;
                transform: translateY(30px);
                animation: fadeInUp 1s forwards 0.5s;
            }
            
            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .hero-subtitle {
                font-size: 24px;
                font-weight: 300;
                margin-bottom: 40px;
                line-height: 1.4;
                text-shadow: 0 1px 3px rgba(0,0,0,0.3);
                opacity: 0;
                transform: translateY(30px);
                animation: fadeInUp 1s forwards 0.8s;
            }
            
            .hero-btn {
                display: inline-block;
                padding: 15px 40px;
                background-color: transparent;
                border: 1px solid #fff;
                color: #fff;
                font-size: 16px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                position: relative;
                z-index: 2;
                opacity: 0;
                transform: translateY(30px);
                animation: fadeInUp 1s forwards 1.1s;
            }
            
            .hero-btn:hover {
                background-color: #fff;
                color: #000;
            }
            
            /* Luxury Brands Section - Premium Redesign */
            .luxury-brands {
                padding: 120px 0;
                background-color: #f8f8f8;
                position: relative;
            }
            
            .luxury-brands::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url('asset/img/subtle-pattern.png');
                opacity: 0.03;
                pointer-events: none;
            }
            
            .section-header {
                text-align: center;
                margin-bottom: 80px;
            }
            
            .section-title {
                font-size: 42px;
                font-weight: 300;
                margin-bottom: 15px;
                color: #000;
                letter-spacing: 1px;
            }
            
            .section-subtitle {
                font-size: 16px;
                color: #555;
                max-width: 600px;
                margin: 0 auto;
                font-weight: 300;
                line-height: 1.6;
            }
            
            .brands-showcase {
                display: flex;
                flex-direction: column;
                gap: 80px;
            }
            
            .brand-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                opacity: 0;
                transform: translateY(50px);
                transition: opacity 0.8s ease, transform 0.8s ease;
            }
            
            .brand-row.animate {
                opacity: 1;
                transform: translateY(0);
            }
            
            .brand-row:nth-child(even) {
                flex-direction: row-reverse;
            }
            
            .brand-video-container {
                flex: 1;
                position: relative;
                height: 400px;
                overflow: hidden;
                transform: scale(0.95);
                transition: transform 1s ease;
            }
            
            .brand-row.animate .brand-video-container {
                transform: scale(1);
            }
            
            .brand-video {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .video-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to right, rgba(0,0,0,0.3), rgba(0,0,0,0));
                pointer-events: none;
            }
            
            .brand-row:nth-child(even) .video-overlay {
                background: linear-gradient(to left, rgba(0,0,0,0.3), rgba(0,0,0,0));
            }
            
            .brand-content {
                flex: 1;
                padding: 0 60px;
                opacity: 0;
                transform: translateX(-30px);
                transition: opacity 0.8s ease 0.3s, transform 0.8s ease 0.3s;
            }
            
            .brand-row:nth-child(even) .brand-content {
                transform: translateX(30px);
            }
            
            .brand-row.animate .brand-content {
                opacity: 1;
                transform: translateX(0);
            }
            
            .brand-logo {
                height: 60px;
                margin-bottom: 30px;
                display: flex;
                align-items: center;
            }
            
            .brand-logo img {
                max-height: 100%;
                max-width: 140px;
            }
            
            .brand-name {
                font-size: 32px;
                font-weight: 300;
                margin-bottom: 15px;
                color: #000;
                letter-spacing: 1px;
            }
            
            .brand-desc {
                font-size: 16px;
                line-height: 1.8;
                color: #555;
                margin-bottom: 25px;
                font-weight: 300;
            }
            
            .brand-stats {
                display: flex;
                gap: 40px;
                margin-bottom: 30px;
            }
            
            .stat-item {
                display: flex;
                flex-direction: column;
            }
            
            .stat-value {
                font-size: 28px;
                font-weight: 600;
                color: #000;
                margin-bottom: 5px;
            }
            
            .stat-label {
                font-size: 12px;
                color: #777;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .brand-link {
                display: inline-block;
                font-size: 14px;
                font-weight: 500;
                color: #000;
                text-transform: uppercase;
                letter-spacing: 1px;
                position: relative;
                padding-bottom: 5px;
                transition: all 0.3s ease;
            }
            
            .brand-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100%;
                height: 1px;
                background-color: #000;
                transform: scaleX(0.3);
                transform-origin: left;
                transition: transform 0.3s ease;
            }
            
            .brand-link:hover::after {
                transform: scaleX(1);
            }
            
            .brands-grid {
                display: grid;
                grid-template-columns: repeat(6, 1fr);
                margin-top: 80px;
                border-top: 1px solid #eee;
                padding-top: 60px;
                opacity: 0;
                transform: translateY(30px);
                transition: opacity 0.8s ease, transform 0.8s ease;
            }
            
            .brands-grid.animate {
                opacity: 1;
                transform: translateY(0);
            }
            
            .brand-mini {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                opacity: 0.5;
                transition: all 0.3s ease;
            }
            
            .brand-mini:hover {
                opacity: 1;
            }
            
            .brand-mini img {
                max-width: 80px;
                max-height: 40px;
                filter: grayscale(100%);
                transition: all 0.3s ease;
            }
            
            .brand-mini:hover img {
                filter: grayscale(0%);
                transform: scale(1.1);
            }
            
            @media (max-width: 992px) {
                .brand-row {
                    flex-direction: column;
                    gap: 40px;
                }
                
                .brand-row:nth-child(even) {
                    flex-direction: column;
                }
                
                .brand-content {
                    padding: 0;
                }
                
                .brands-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }
            
            @media (max-width: 576px) {
                .brands-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            
            /* Featured Cars Section - Ultra Minimalist Design */
            .featured-cars {
                padding: 80px 0;
                background-color: #fff;
            }
            
            .section-header {
                text-align: center;
                margin-bottom: 50px;
            }
            
            .section-title {
                font-size: 32px;
                font-weight: 300;
                color: #000;
                letter-spacing: 1px;
            }
            
            .cars-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 30px;
            }
            
            .car-card {
                background-color: #fff;
                overflow: hidden;
                transition: transform 0.3s ease;
            }
            
            .car-card:hover {
                transform: translateY(-5px);
            }
            
            .car-image {
                height: 180px;
                overflow: hidden;
                position: relative;
            }
            
            .car-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
            }
            
            .car-card:hover .car-image img {
                transform: scale(1.05);
            }
            
            .car-details {
                padding: 20px 0;
                text-align: center;
            }
            
            .car-brand {
                font-size: 12px;
                color: #777;
                text-transform: uppercase;
                letter-spacing: 2px;
                margin-bottom: 5px;
            }
            
            .car-name {
                font-size: 18px;
                font-weight: 500;
                margin-bottom: 5px;
                color: #000;
            }
            
            .car-specs {
                font-size: 14px;
                color: #555;
                margin-bottom: 10px;
            }
            
            .car-specs span {
                margin: 0 3px;
            }
            
            .car-price {
                font-size: 16px;
                font-weight: 600;
                color: #000;
                margin-bottom: 15px;
            }
            
            .car-btn {
                display: inline-block;
                padding: 8px 30px;
                background-color: transparent;
                border: 1px solid #000;
                color: #000;
                font-size: 12px;
                text-transform: uppercase;
                letter-spacing: 2px;
                transition: all 0.3s ease;
            }
            
            .car-btn:hover {
                background-color: #000;
                color: #fff;
            }
            
            .view-all {
                text-align: center;
                margin-top: 50px;
            }
            
            .view-all-btn {
                display: inline-block;
                padding: 10px 40px;
                background-color: transparent;
                border: 1px solid #000;
                color: #000;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 2px;
                transition: all 0.3s ease;
            }
            
            .view-all-btn:hover {
                background-color: #000;
                color: #fff;
            }
            
            @media (max-width: 1200px) {
                .cars-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }
            
            @media (max-width: 992px) {
                .cars-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            
            @media (max-width: 576px) {
                .cars-grid {
                    grid-template-columns: 1fr;
                }
            }
            
            /* Services Section - Minimal */
            .services {
                padding: 120px 0;
                background-color: #fff;
            }
            
            .services-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 40px;
            }
            
            .service-item {
                text-align: center;
                padding: 40px 30px;
            }
            
            .service-icon {
                font-size: 48px;
                margin-bottom: 25px;
                color: #000;
            }
            
            .service-title {
                font-size: 24px;
                font-weight: 500;
                margin-bottom: 15px;
                color: #000;
            }
            
            .service-desc {
                font-size: 16px;
                color: #555;
                line-height: 1.6;
            }
            
            /* Testimonials - Clean & Simple */
            .testimonials {
                padding: 120px 0;
                background-color: #f8f8f8;
                text-align: center;
            }
            
            .testimonial-quote {
                font-size: 24px;
                line-height: 1.6;
                max-width: 800px;
                margin: 0 auto 30px;
                color: #000;
                font-weight: 300;
                font-style: italic;
            }
            
            .testimonial-author {
                font-size: 18px;
                font-weight: 500;
                color: #000;
            }
            
            .testimonial-role {
                font-size: 14px;
                color: #555;
            }
            
            /* Contact CTA - Minimal */
            .contact-cta {
                padding: 100px 0;
                background-color: #000;
                color: #fff;
                text-align: center;
            }
            
            .cta-title {
                font-size: 42px;
                font-weight: 600;
                margin-bottom: 20px;
            }
            
            .cta-text {
                font-size: 18px;
                margin-bottom: 40px;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
                font-weight: 300;
            }
            
            .cta-btn {
                display: inline-block;
                padding: 15px 40px;
                background-color: transparent;
                border: 1px solid #fff;
                color: #fff;
                font-size: 16px;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }
            
            .cta-btn:hover {
                background-color: #fff;
                color: #000;
            }
        </style>
    </head>
    <body>
        <!-- Include Navbar -->
        <jsp:include page="components/navbar.jsp" />

        <!-- Hero Banner - Minimal & Modern -->
        <section class="hero-banner">
            <video autoplay muted loop playsinline>
                <source src="asset/img/vidbanner.mp4" type="video/mp4">
                Your browser does not support the video tag.
            </video>
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
                            <video class="brand-video" autoplay muted loop playsinline>
                                <source src="asset/img/mecbrand.mp4" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
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
                            <video class="brand-video" autoplay muted loop playsinline>
                                <source src="asset/img/bmwbrand.mp4" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
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
                </div>
                
                <div class="cars-grid">
                    <c:forEach var="car" items="${latestCars}">
                        <div class="car-card">
                            <div class="car-image">
                                <img src="asset/img/cars/${car.carImg}" alt="${car.carBrand} ${car.carName}">
                            </div>
                            <div class="car-details">
                                <div class="car-brand">${car.carBrand}</div>
                                <h3 class="car-name">${car.carName}</h3>
                                <div class="car-specs">
                                    <span>${car.carYear.getYear() + 1900}</span>
                                    <span>&bull;</span>
                                    <span>${car.fuelType}</span>
                                </div>
                                <div class="car-price">$<fmt:formatNumber value="${car.carPrice}" type="number" pattern="#,###" /></div>
                                <a href="car-detail.jsp?id=${car.carId}" class="car-btn">Explore</a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="view-all">
                    <a href="${pageContext.request.contextPath}/car/list" class="view-all-btn">View All</a>
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
            });
        </script>
    </body>
</html>
