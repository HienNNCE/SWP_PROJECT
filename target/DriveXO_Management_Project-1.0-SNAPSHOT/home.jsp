<%-- 
    Document   : home
    Created on : May 17, 2025, 12:33:32 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - World of Luxury Automobiles</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Hero Section -->
        <section class="hero-section">
            <div class="container">
                <div class="hero-content">
                    <h2>Find Your Perfect Car</h2>
                    <h1>Best Car Showroom from FPT</h1>

                    <div class="search-tabs">
                        <div class="tab-buttons">
                            <button class="tab-btn active">All Car</button>
                            <button class="tab-btn">Used Car</button>
                            <button class="tab-btn">New Car</button>
                        </div>
                        <div class="search-form">
                            <div class="form-group">
                                <input type="text" placeholder="Type here">
                            </div>
                            <div class="form-group">
                                <select>
                                    <option>Select Brand</option>
                                    <!-- Brand options will go here -->
                                </select>
                            </div>
                            <div class="form-group">
                                <select>
                                    <option>Country</option>
                                    <!-- Country options will go here -->
                                </select>
                            </div>
                            <div class="form-group">
                                <select>
                                    <option>Sort By</option>
                                    <!-- Sort options will go here -->
                                </select>
                            </div>
                            <button class="search-btn"><i class="fas fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="hero-image">
                <!-- Hero Car Image: Kích thước được điều chỉnh để phù hợp với layout -->
                <img src="asset/img/hero-car.png" alt="Luxury Car" id="hero-car-image">
            </div>
        </section>

        <!-- Stats Section -->
        <section class="stats-section">
            <div class="container">
                <div class="car-stats">
                    <div class="stat-item">
                        <div class="stat-number total-cars">500+</div>
                        <div class="stat-label">Luxury Cars</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number happy-customers">1200+</div>
                        <div class="stat-label">Happy Customers</div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-number dealers">150</div>
                        <div class="stat-label">Premium Dealers</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Popular Brands Section -->
        <section class="brands-section">
            <div class="container">
                <div class="section-header">
                    <h4 class="section-label">Brands</h4>
                    <h2 class="section-title">Explore Popular Brand</h2>
                    <a href="#" class="view-all-link">View All</a>
                </div>
                <div class="brand-cards">
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/chevrolet.png" alt="Chevrolet">
                        </div>
                        <h3>Chevrolet</h3>
                        <span class="count">3</span>
                    </div>
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/honda.png" alt="Honda">
                        </div>
                        <h3>Honda</h3>
                        <span class="count">3</span>
                    </div>
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/bmw.png" alt="BMW">
                        </div>
                        <h3>BMW</h3>
                        <span class="count">2</span>
                    </div>
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/hyundai.png" alt="Hyundai">
                        </div>
                        <h3>Hyundai</h3>
                        <span class="count">2</span>
                    </div>
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/mercedes.png" alt="Mercedes">
                        </div>
                        <h3>Mercedes</h3>
                        <span class="count">0</span>
                    </div>
                    <div class="brand-card">
                        <div class="brand-image">
                            <!-- Brand Logo: 120x80px -->
                            <img src="asset/img/brands/nissan.png" alt="Nissan">
                        </div>
                        <h3>Nissan</h3>
                        <span class="count">1</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- Latest Car Listings Section -->
        <section class="car-listings-section">
            <div class="container">
                <div class="section-header">
                    <h4 class="section-label">Available Brand Car</h4>
                    <h2 class="section-title">Latest Car Listings</h2>
                    <div class="car-filter-buttons">
                        <button class="filter-btn active">New Car</button>
                        <button class="filter-btn">Used Car</button>
                    </div>
                </div>
                <div class="car-cards">
                    <c:forEach var="car" items="${latestCars}">
                        <div class="car-card" data-id="car${car.carId}">
                            <div class="card-image">
                                <span class="tag">New</span> <%-- Assume all are New for now, can be made dynamic --%>
                                <!-- Car Image: 300x200px -->
                                <img src="asset/img/cars/${car.carBrand.toLowerCase()}-${car.model.toLowerCase().replace(' ', '-')}.png" alt="${car.carBrand} ${car.carName}"> <%-- Basic dynamic image path, might need adjustment --%>
                                <div class="card-actions">
                                    <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                    <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                </div>
                            </div>
                            <div class="card-content">
                                <div class="car-brand">${car.carBrand}</div>
                                <h3 class="car-name">${car.year} ${car.carName}</h3>
                                <div class="car-price">$<c:out value="${car.carPrice}" /></div>
                                <div class="car-specs">
                                    <div class="spec">
                                        <i class="fas fa-tachometer-alt"></i>
                                        <span>${car.carOdo}(mi)</span>
                                    </div>
                                    <div class="spec">
                                        <i class="fas fa-gas-pump"></i>
                                        <span>Gasoline</span> <%-- Placeholder, can be made dynamic --%>
                                    </div>
                                    <div class="spec">
                                        <i class="fas fa-cog"></i>
                                        <span>${car.displacement} (cc)</span>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <span class="listing-author">Listed by: John Doe</span> <%-- Placeholder --%>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="view-more-container">
                    <a href="${pageContext.request.contextPath}/car/list" class="view-more-btn">View More Car List</a>
                </div>
            </div>
        </section>

        <!-- Featured Car Listings Section -->
        <section class="featured-section">
            <div class="container">
                <div class="section-header">
                    <h4 class="section-label">Our Featured Cars</h4>
                    <h2 class="section-title">Featured Car Listings</h2>
                    <a href="#" class="view-more-link">View More</a>
                </div>
                <div class="featured-cars">
                    <div class="featured-main">
                        <div class="featured-image">
                            <!-- Featured Car Image: Ảnh theo chiều dọc (450x700px) -->
                            <img src="asset/img/cars/featured-main.png" alt="Luxurious Car">
                            <div class="featured-overlay">
                                <div class="featured-logo">DriverXO</div>
                             
                                <div class="featured-content">
                                    <h3>Buy Our Latest Luxurious Car</h3>
                                    <p>So Hurry Up</p>
                                    <div class="call-action">
                                        <span>Call Us Now</span>
                                        <a href="tel:+00 23904 0244">+00 23904 0244</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="featured-grid">
                        <div class="car-card">
                            <div class="card-image">
                                <span class="tag">Used</span>
                                <!-- Car Image: 300x200px -->
                                <img src="asset/img/cars/honda-civic.png" alt="Honda City">
                                <div class="card-actions">
                                    <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                    <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                </div>
                            </div>
                            <div class="card-content">
                                <div class="car-brand">Honda</div>
                                <h3 class="car-name">2018 Honda City 1.3 i-VTEC</h3>
                                <div class="car-price">$120.00</div>
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
                                    <span class="listing-author">Listed by: David Richard</span>
                                </div>
                            </div>
                        </div>
                        <div class="car-card">
                            <div class="card-image">
                                <span class="tag">New</span>
                                <!-- Car Image: 300x200px -->
                                <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                <div class="card-actions">
                                    <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                    <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                </div>
                            </div>
                            <div class="card-content">
                                <div class="car-brand">Chevrolet</div>
                                <h3 class="car-name">2019 CamFó Explorer</h3>
                                <div class="car-price">$120.00</div>
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
                                </div>
                            </div>
                        </div>
                        
                        <div class="featured-grid-bottom">
                            <div class="car-mini-card">
                                <div class="card-image">
                                    <span class="tag">Used</span>
                                    <!-- Mini Car Image: 150x100px -->
                                    <img src="asset/img/cars/bmw-portofino.png" alt="BMW Camé Ferrari Portofino">
                                    <div class="card-actions">
                                        <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                        <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="car-brand">BMW</div>
                                    <h3 class="car-name">1998 Camé Ferrari Portofino</h3>
                                    <div class="car-price">$50.00</div>
                                    <div class="card-footer">
                                        <span class="listing-author">Listed by: John Doe</span>
                                    </div>
                                </div>
                            </div>
                            <div class="car-mini-card">
                                <div class="card-image">
                                    <span class="tag">New</span>
                                    <!-- Mini Car Image: 150x100px -->
                                    <img src="asset/img/cars/atra-benz-black.png" alt="Hyundai Altra Benz C-Class">
                                    <div class="card-actions">
                                        <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                        <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="car-brand">Hyundai</div>
                                    <h3 class="car-name">2007 Altra Benz C-Class</h3>
                                    <div class="car-price">$3,000.00</div>
                                    <div class="card-footer">
                                        <span class="listing-author">Listed by: John Doe</span>
                                    </div>
                                </div>
                            </div>
                            <div class="car-mini-card">
                                <div class="card-image">
                                    <span class="tag">Used</span>
                                    <!-- Mini Car Image: 150x100px -->
                                    <img src="asset/img/cars/corvette-z51.png" alt="Honda Shevrolet Corvette Z51">
                                    <div class="card-actions">
                                        <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                        <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="car-brand">Honda</div>
                                    <h3 class="car-name">2023 Shevrolet Corvette Z51</h3>
                                    <div class="car-price">$800.00</div>
                                    <div class="card-footer">
                                        <span class="listing-author">Listed by: John Doe</span>
                                    </div>
                                </div>
                            </div>
                            <div class="car-mini-card">
                                <div class="card-image">
                                    <span class="tag">Used</span>
                                    <!-- Mini Car Image: 150x100px -->
                                    <img src="asset/img/cars/camford-mustang.png" alt="Chevrolet CamFord Mustang">
                                    <div class="card-actions">
                                        <button class="wishlist-btn"><i class="far fa-heart"></i></button>
                                        <button class="compare-btn"><i class="fas fa-exchange-alt"></i></button>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="car-brand">Chevrolet</div>
                                    <h3 class="car-name">2017 CamFord Mustang</h3>
                                    <div class="car-price">$800.00</div>
                                    <div class="card-footer">
                                        <span class="listing-author">Listed by: John Doe</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Blog Section -->
        <section class="blog-section">
            <div class="container">
                <div class="section-header">
                    <h4 class="section-label">Recent News</h4>
                    <h2 class="section-title">Read Our Latest Blogs</h2>
                </div>
                <div class="blog-cards">
                    <div class="blog-card">
                        <div class="blog-image">
                            <!-- Blog Image: 300x200px -->
                            <img src="asset/img/blogs/blog1.png" alt="Car on highway">
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span class="author"><i class="fas fa-user"></i> By John Doe</span>
                                <span class="comments"><i class="fas fa-comment"></i> 2 Comments</span>
                            </div>
                            <h3 class="blog-title">Car on highway directional road signs</h3>
                            <a href="#" class="learn-more">Learn More <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-image">
                            <!-- Blog Image: 300x200px -->
                            <img src="asset/img/blogs/blog2.png" alt="Professional man">
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span class="author"><i class="fas fa-user"></i> By John Doe</span>
                                <span class="comments"><i class="fas fa-comment"></i> 2 Comments</span>
                            </div>
                            <h3 class="blog-title">Professional man working on car full shot</h3>
                            <a href="#" class="learn-more">Learn More <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-image">
                            <!-- Blog Image: 300x200px -->
                            <img src="asset/img/blogs/blog3.png" alt="Stylish man">
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span class="author"><i class="fas fa-user"></i> By John Doe</span>
                                <span class="comments"><i class="fas fa-comment"></i> 0 Comments</span>
                            </div>
                            <h3 class="blog-title">Stylish and elegant old man in a car salon</h3>
                            <a href="#" class="learn-more">Learn More <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </div>
                    <div class="blog-card">
                        <div class="blog-image">
                            <!-- Blog Image: 300x200px -->
                            <img src="asset/img/blogs/blog4.png" alt="Mini coupe">
                        </div>
                        <div class="blog-content">
                            <div class="blog-meta">
                                <span class="author"><i class="fas fa-user"></i> By John Doe</span>
                                <span class="comments"><i class="fas fa-comment"></i> 0 Comments</span>
                            </div>
                            <h3 class="blog-title">Mini coupe parking on the highway bridge</h3>
                            <a href="#" class="learn-more">Learn More <i class="fas fa-arrow-right"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Newsletter Section -->
        <section class="newsletter-section">
            <div class="container">
                <div class="newsletter-content">
                    <div class="newsletter-text">
                        <h2 class="section-title">Join Our <span>Newsletter</span> <br>& Get updated.</h2>
                    </div>
                    <div class="newsletter-form">
                        <form>
                            <input type="email" placeholder="Email Address">
                            <button type="submit" class="subscribe-btn">Subscribe</button>
                        </form>
                        <p>We only send interesting and relevant emails.</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer black-footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-col">
                        <div class="footer-logo">
                            <!-- Footer Logo: 120x40px -->
                            <img src="asset/img/driverxo-logo-white.png" alt="DriverXO">
                            <span>DriverXO</span>
                        </div>
                        <p>At DriverXO, we offer a premium selection of high-performance and luxury vehicles tailored to your lifestyle. Whether you're looking for speed, comfort, or style, we bring you the finest cars with exceptional service and trusted quality.</p>
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
                           
                        </ul>
                    </div>
                    <div class="footer-col">
                        <h3>My Profile</h3>
                        <ul>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Dashboard</a></li>
                            <li><a href="#"><i class="fas fa-chevron-right"></i> Manage Car</a></li>
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
                        <p>Copyright 2025 Group3 - SE1816 - All Rights Reserved</p>
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
        <script src="asset/js/main.js"></script>
    </body>
    <script src="${pageContext.servletContext.contextPath}/assets/js/cart_addToCart.js?v=<%= System.currentTimeMillis()%>"></script>
</html>
