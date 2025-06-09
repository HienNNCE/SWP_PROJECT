<%-- 
    Document   : car-list
    Created on : May 18, 2025, 10:00:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - All Cars Collection</title>
        <link rel="stylesheet" href="../asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <h1>All Cars</h1>
                <div class="breadcrumb">
                    <a href="../home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Cars</span>
                </div>
            </div>
        </section>

        <!-- Filter Section -->
        <section class="filter-section">
            <div class="container">
                <div class="filter-wrapper">
                    <div class="filter-form">
                        <div class="filter-grid">
                            <div class="filter-item">
                                <label>Brand</label>
                                <select>
                                    <option value="">All Brands</option>
                                    <option value="chevrolet">Chevrolet</option>
                                    <option value="honda">Honda</option>
                                    <option value="bmw">BMW</option>
                                    <option value="hyundai">Hyundai</option>
                                    <option value="mercedes">Mercedes</option>
                                    <option value="nissan">Nissan</option>
                                </select>
                            </div>
                            <div class="filter-item">
                                <label>Model</label>
                                <select>
                                    <option value="">All Models</option>
                                </select>
                            </div>
                            <div class="filter-item">
                                <label>Year</label>
                                <select>
                                    <option value="">Any Year</option>
                                    <option value="2023">2023</option>
                                    <option value="2022">2022</option>
                                    <option value="2021">2021</option>
                                    <option value="2020">2020</option>
                                    <option value="2019">2019</option>
                                </select>
                            </div>
                            <div class="filter-item">
                                <label>Price Range</label>
                                <select>
                                    <option value="">Any Price</option>
                                    <option value="0-1000">$0 - $1,000</option>
                                    <option value="1000-5000">$1,000 - $5,000</option>
                                    <option value="5000-10000">$5,000 - $10,000</option>
                                    <option value="10000-20000">$10,000 - $20,000</option>
                                    <option value="20000+">$20,000+</option>
                                </select>
                            </div>
                            <div class="filter-item">
                                <label>Fuel Type</label>
                                <select>
                                    <option value="">Any Type</option>
                                    <option value="gasoline">Gasoline</option>
                                    <option value="diesel">Diesel</option>
                                    <option value="electric">Electric</option>
                                    <option value="hybrid">Hybrid</option>
                                </select>
                            </div>
                            <div class="filter-item">
                                <label>Transmission</label>
                                <select>
                                    <option value="">Any</option>
                                    <option value="automatic">Automatic</option>
                                    <option value="manual">Manual</option>
                                </select>
                            </div>
                        </div>
                        <div class="filter-actions">
                            <button class="reset-btn">Reset</button>
                            <button class="apply-btn">Apply Filters</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Car Listings Grid -->
        <section class="car-listings-grid">
            <div class="container">
                <div class="listings-header">
                    <div class="results-count">
                        <p>Showing <strong>1-12</strong> of <strong>50</strong> results</p>
                    </div>
                    <div class="sort-filter">
                        <label>Sort by:</label>
                        <select>
                            <option value="newest">Newest First</option>
                            <option value="oldest">Oldest First</option>
                            <option value="price-low">Price: Low to High</option>
                            <option value="price-high">Price: High to Low</option>
                            <option value="popularity">Popularity</option>
                        </select>
                    </div>
                    <div class="view-switch">
                        <button class="grid-view active"><i class="fas fa-th-large"></i></button>
                        <button class="list-view"><i class="fas fa-list"></i></button>
                    </div>
                </div>
                
                <div class="car-grid">
                    <!-- Car 1 -->
                    <c:forEach var="car" items="${carList}">
                        <div class="car-card" data-id="car${car.carId}">
                            <div class="card-image">
                                <span class="tag">New</span>
                                <!-- Car Image: 300x200px -->
                                <img src="${pageContext.request.contextPath}/car/image?id=${car.carId}" alt="${car.carName}">
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
                                        <%-- Assuming fuel is stored as a number, you might need to map it to a type string --%>
                                        <span>Gasoline</span>
                                    </div>
                                    <div class="spec">
                                        <i class="fas fa-cog"></i>
                                        <span>${car.displacement} (cc)</span>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <span class="listing-author">Listed by: John Doe</span>
                                    <a href="${pageContext.request.contextPath}/car/detail?id=${car.carId}" class="view-details">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                    <!-- Car 2 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 3 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 4 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 5 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 6 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 7 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 8 -->
                    <%-- Removed static car cards --%>

                    <!-- Car 9 -->
                    <%-- Removed static car cards --%>
                </div>
                
                <!-- Pagination -->
                <div class="pagination">
                    <a href="#" class="active">1</a>
                    <a href="#">2</a>
                    <a href="#">3</a>
                    <a href="#">4</a>
                    <a href="#">5</a>
                    <a href="#" class="next"><i class="fas fa-angle-right"></i></a>
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
    </body>
</html> 