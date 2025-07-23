<%-- 
    Document   : car-detail
    Created on : May 18, 2025, 11:30:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - Car Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/cardetail.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <!-- Google Fonts - Montserrat -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>

        <jsp:include page="/components/navbar.jsp"/>
        
        <!-- Car Detail Page Header - Similar to car-list.jsp -->
        <div class="car-listing-page" style="padding-top: 80px;">
            <div class="container">
                <!-- Header Section -->
                <div class="car-listing-header-container">
                    <header class="car-listing-header">
                        <h1 class="car-listing-title">Vehicle Details</h1>
                        <p class="car-listing-subtitle">Comprehensive information about your selected premium vehicle</p>
                    </header>
                </div>
                
                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <i class="fas fa-angle-right"></i>
                    <a href="${pageContext.request.contextPath}/car/list">Cars</a>
                    <i class="fas fa-angle-right"></i>
                    <span>${car.carYear.getYear() + 1900} ${car.carName}</span>
                </div>

                <!-- Car Detail Layout -->
                <div class="car-detail-container">
                    <!-- Left Column - Car Gallery -->
                    <div class="car-gallery">
                        <!-- Main Image -->
                        <div class="car-main-image">
                            <c:set var="carImageUrl" value="${not empty car.carImg ? car.carImg : 'default-car.png'}" />
                            <img src="${pageContext.request.contextPath}/asset/img/cars/${carImageUrl}" 
                                onerror="this.src='${pageContext.request.contextPath}/asset/img/cars/default-car.png'" 
                                alt="${car.carName}" id="mainImage">
                        </div>
                        
                        <!-- Key Highlights - Moved from right column -->
                        <div class="highlights-section">
                            <h3 class="section-label">Key Highlights</h3>
                            <div class="highlights-grid">
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-calendar-alt"></i></span>
                                    <div class="highlight-info">
                                        <div class="highlight-value">${car.carYear.getYear() + 1900}</div>
                                        <div class="highlight-label">Year</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-tachometer-alt"></i></span>
                                    <div class="highlight-info">
                                        <div class="highlight-value"><fmt:formatNumber value="${car.carOdo}" type="number" pattern="#,###" /></div>
                                        <div class="highlight-label">Mileage</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-gas-pump"></i></span>
                                    <div class="highlight-info">
                                        <div class="highlight-value">${car.fuelType}</div>
                                        <div class="highlight-label">Fuel</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-cogs"></i></span>
                                    <div class="highlight-info">
                                        <div class="highlight-value">${car.displacement} L</div>
                                        <div class="highlight-label">Engine</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column - Car Info -->
                    <div class="car-info">
                        <!-- Car Title & Quick Actions -->
                        <div class="car-header">
                            <div class="car-title">
                                <h1 class="car-name">${car.carYear.getYear() + 1900} ${car.carName}</h1>
                                <div class="car-brand">${car.carBrand}</div>
                            </div>
                            <div class="quick-actions">
                                <button class="action-btn" title="Add to Favorites">
                                    <i class="far fa-heart"></i>
                                </button>
                                <button class="action-btn" title="Compare">
                                    <i class="fas fa-exchange-alt"></i>
                                </button>
                                <button class="action-btn" title="Share">
                                    <i class="fas fa-share-alt"></i>
                                </button>
                            </div>
                        </div>
                        
                        <!-- Price Card -->
                        <div class="price-card">
                            <div class="price-details">
                                <div class="current-price">$<fmt:formatNumber value="${car.carPrice}" type="number" pattern="#,###,###" /></div>
                                <div class="price-qualifier">
                                    <span class="tax-note">+Tax & License</span>
                                    <span class="price-tag"><i class="fas fa-tag"></i> Special Price</span>
                            </div>
                            </div>
                            <div class="finance-est">
                                <div class="est-payment">
                                    <span class="payment-amount">$<fmt:formatNumber value="${car.carPrice / 60}" type="number" maxFractionDigits="0" /></span>
                                    <span class="payment-term">/mo</span>
                            </div>
                                <div class="payment-note">Est. $0 down, 60 months</div>
                            </div>
                        </div>
                        
                        <!-- Additional Features Preview -->
                        <div class="features-preview">
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Premium Sound System</div>
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Leather Seats</div>
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Navigation</div>
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Bluetooth</div>
                            <div class="feature-chip more-features">+12 more</div>
                        </div>

                        <!-- Contact Actions -->
                        <div class="contact-actions">
                            <button class="contact-action-btn book-btn">
                                <i class="far fa-calendar-alt"></i> 
                                <span class="btn-text">
                                    <span class="btn-title">Book Appointment</span>
                                    <span class="btn-subtitle">Available today</span>
                                </span>
                        </button>
                        
                            <button class="contact-action-btn drive-btn">
                                <i class="fas fa-car"></i>
                                <span class="btn-text">
                                    <span class="btn-title">Schedule Test Drive</span>
                                    <span class="btn-subtitle">Experience it yourself</span>
                                </span>
                        </button>
                        
                            <div class="guarantee-line">
                                <i class="fas fa-shield-alt"></i> Guaranteed by DriverXO
                            </div>
                        </div>

                        <!-- Contact Form (hidden by default) -->
                        <div class="contact-form" id="contactForm" style="display: none;">
                            <form>
                                <div class="form-group">
                                    <input type="text" placeholder="Your Name" required>
                                </div>
                                <div class="form-group">
                                    <input type="email" placeholder="Your Email" required>
                                </div>
                                <div class="form-group">
                                    <input type="tel" placeholder="Phone Number">
                                </div>
                                <div class="form-group">
                                    <textarea placeholder="Your Message" required>I'm interested in this ${car.carYear.getYear() + 1900} ${car.carName}. Please contact me with more information.</textarea>
                            </div>
                                <button type="submit" class="contact-btn primary">Send Inquiry</button>
                            </form>
                        </div>
                    </div>
                            </div>

                <!-- Car Details Tabs -->
                <div class="car-details-tabs">
                    <!-- Tab Navigation -->
                    <div class="tab-navigation">
                        <button class="tab-button active" data-target="overview">Overview</button>
                        <button class="tab-button" data-target="features">Features</button>
                        <button class="tab-button" data-target="specs">Specifications</button>
                        </div>

                    <!-- Tab Content -->
                    <div class="tab-content">
                        <!-- Overview Tab -->
                        <div class="tab-pane active" id="overview">
                            <div class="car-overview">
                                <div class="overview-text">
                                    <p>
                                        The ${car.carYear.getYear() + 1900} ${car.carBrand} ${car.carName} represents the perfect balance of luxury, performance, and reliability.
                                        With its sleek design and powerful ${car.displacement} L engine, this vehicle delivers an extraordinary driving experience that's both
                                        exhilarating and refined.
                                    </p>
                                    <p>
                                        With only <fmt:formatNumber value="${car.carOdo}" type="number" pattern="#,###" /> miles on the odometer, this ${car.carName} has been
                                        meticulously maintained and is in excellent condition. The ${car.fuelType} engine provides exceptional fuel efficiency without compromising
                                        on performance, making it an ideal choice for daily commuting and weekend adventures alike.
                                    </p>
                                    <p>
                                        Our comprehensive inspection ensures that this vehicle meets our stringent quality standards. We're proud to offer this 
                                        ${car.carBrand} ${car.carName} with complete service records and a clean history report.
                                    </p>
                                </div>
                                <div class="overview-stats">
                                    <div class="stat-group">
                                        <h3 class="stat-group-title">Vehicle Details</h3>
                                        <div class="stat-row">
                                            <div class="stat-label">Condition</div>
                                            <div class="stat-value">Excellent</div>
                                        </div>
                                        <div class="stat-row">
                                            <div class="stat-label">Exterior Color</div>
                                            <div class="stat-value">Premium Silver</div>
                                        </div>
                                        <div class="stat-row">
                                            <div class="stat-label">Interior Color</div>
                                            <div class="stat-value">Black Leather</div>
                                </div>
                                        <div class="stat-row">
                                            <div class="stat-label">VIN</div>
                                            <div class="stat-value">XXX-XXXX-XXXX</div>
                                </div>
                            </div>
                                    <div class="stat-group">
                                        <h3 class="stat-group-title">Performance</h3>
                                        <div class="stat-row">
                                            <div class="stat-label">Engine</div>
                                            <div class="stat-value">${car.displacement} L</div>
                                        </div>
                                        <div class="stat-row">
                                            <div class="stat-label">Transmission</div>
                                            <div class="stat-value">Automatic</div>
                                        </div>
                                        <div class="stat-row">
                                            <div class="stat-label">Drive Type</div>
                                            <div class="stat-value">All-Wheel Drive</div>
                            </div>
                        </div>
                    </div>
                            </div>
                        </div>

                        <!-- Features Tab -->
                        <div class="tab-pane" id="features">
                            <div class="features-grid">
                                <div class="feature-category">
                                    <h3 class="feature-title">Comfort & Convenience</h3>
                                    <ul class="feature-list">
                                        <li><i class="fas fa-check"></i> Dual-Zone Automatic Climate Control</li>
                                        <li><i class="fas fa-check"></i> Heated Front Seats</li>
                                        <li><i class="fas fa-check"></i> Power-Adjustable Front Seats</li>
                                        <li><i class="fas fa-check"></i> Keyless Entry and Start</li>
                                        <li><i class="fas fa-check"></i> Remote Start System</li>
                                        <li><i class="fas fa-check"></i> Power Moonroof</li>
                                        <li><i class="fas fa-check"></i> Automatic Dimming Rearview Mirror</li>
                                    </ul>
                                </div>
                                <div class="feature-category">
                                    <h3 class="feature-title">Technology</h3>
                                    <ul class="feature-list">
                                        <li><i class="fas fa-check"></i> 10.1" Touchscreen Display</li>
                                        <li><i class="fas fa-check"></i> Navigation System</li>
                                        <li><i class="fas fa-check"></i> Bluetooth Connectivity</li>
                                        <li><i class="fas fa-check"></i> Premium Sound System</li>
                                        <li><i class="fas fa-check"></i> Apple CarPlay & Android Auto</li>
                                        <li><i class="fas fa-check"></i> Wireless Charging Pad</li>
                                        <li><i class="fas fa-check"></i> Multiple USB Ports</li>
                                    </ul>
                                </div>
                                <div class="feature-category">
                                    <h3 class="feature-title">Safety</h3>
                                    <ul class="feature-list">
                                        <li><i class="fas fa-check"></i> Forward Collision Warning</li>
                                        <li><i class="fas fa-check"></i> Automatic Emergency Braking</li>
                                        <li><i class="fas fa-check"></i> Lane Departure Warning</li>
                                        <li><i class="fas fa-check"></i> Lane Keeping Assist</li>
                                        <li><i class="fas fa-check"></i> Blind Spot Monitoring</li>
                                        <li><i class="fas fa-check"></i> Rear Cross Traffic Alert</li>
                                        <li><i class="fas fa-check"></i> 360° Camera System</li>
                                    </ul>
                                </div>
                                <div class="feature-category">
                                    <h3 class="feature-title">Exterior</h3>
                                    <ul class="feature-list">
                                        <li><i class="fas fa-check"></i> LED Headlights and Taillights</li>
                                        <li><i class="fas fa-check"></i> Adaptive Headlights</li>
                                        <li><i class="fas fa-check"></i> 19" Alloy Wheels</li>
                                        <li><i class="fas fa-check"></i> Power-Folding Side Mirrors</li>
                                        <li><i class="fas fa-check"></i> Hands-Free Power Liftgate</li>
                                        <li><i class="fas fa-check"></i> Roof Rails</li>
                                        <li><i class="fas fa-check"></i> Rain-Sensing Wipers</li>
                                    </ul>
                                </div>
                            </div>
                            </div>

                        <!-- Specifications Tab -->
                        <div class="tab-pane" id="specs">
                            <table class="specs-table">
                                <tr>
                                    <th colspan="2">Engine & Performance</th>
                                </tr>
                                <tr>
                                    <td>Engine Type</td>
                                    <td>${car.displacement} L ${car.fuelType}</td>
                                </tr>
                                <tr>
                                    <td>Horsepower</td>
                                    <td>248 hp @ 5,000 rpm</td>
                                </tr>
                                <tr>
                                    <td>Torque</td>
                                    <td>273 lb-ft @ 1,600 rpm</td>
                                </tr>
                                <tr>
                                    <td>Transmission</td>
                                    <td>8-Speed Automatic</td>
                                </tr>
                                <tr>
                                    <td>Drive Type</td>
                                    <td>All-Wheel Drive</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Fuel Economy</th>
                                </tr>
                                <tr>
                                    <td>City</td>
                                    <td>22 mpg</td>
                                </tr>
                                <tr>
                                    <td>Highway</td>
                                    <td>29 mpg</td>
                                </tr>
                                <tr>
                                    <td>Combined</td>
                                    <td>25 mpg</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Dimensions</th>
                                </tr>
                                <tr>
                                    <td>Length</td>
                                    <td>184.6 in</td>
                                </tr>
                                <tr>
                                    <td>Width</td>
                                    <td>74.4 in</td>
                                </tr>
                                <tr>
                                    <td>Height</td>
                                    <td>65.6 in</td>
                                </tr>
                                <tr>
                                    <td>Wheelbase</td>
                                    <td>105.9 in</td>
                                </tr>
                                <tr>
                                    <td>Ground Clearance</td>
                                    <td>8.2 in</td>
                                </tr>
                                <tr>
                                    <td>Cargo Volume</td>
                                    <td>28.9 cu ft (59.6 cu ft with rear seats folded)</td>
                                </tr>
                                <tr>
                                    <th colspan="2">Comfort & Convenience</th>
                                </tr>
                                <tr>
                                    <td>Seating Capacity</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <td>Front Legroom</td>
                                    <td>41.2 in</td>
                                </tr>
                                <tr>
                                    <td>Rear Legroom</td>
                                    <td>38.0 in</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <!-- Similar Cars Section -->
                <div class="similar-cars">
                    <h2 class="section-title">Similar Vehicles</h2>
                    <div class="similar-cars-grid">
                        <c:forEach var="simCar" items="${similarCars}">
                            <div class="car-card">
                                <div class="card-image">
                                    <span class="card-tag">New</span>
                                    <img src="${pageContext.request.contextPath}/asset/img/cars/${not empty simCar.carImg ? simCar.carImg : 'default-car.png'}"
                                         onerror="this.src='${pageContext.request.contextPath}/asset/img/cars/default-car.png'"
                                         alt="${simCar.carName}">
                                    <div class="card-actions">
                                        <button class="card-action" title="Add to Favorites">
                                            <i class="far fa-heart"></i>
                                        </button>
                                        <button class="card-action" title="Compare">
                                            <i class="fas fa-exchange-alt"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="card-content">
                                    <div class="card-brand">${simCar.carBrand}</div>
                                    <h3 class="card-name">${simCar.carYear.year + 1900} ${simCar.carName}</h3>
                                    <div class="card-price">$<fmt:formatNumber value="${simCar.carPrice}" type="number" pattern="#,#00,###" /></div>
                                    <div class="card-specs">
                                        <div class="card-spec">
                                            <i class="fas fa-tachometer-alt"></i>
                                            <span><fmt:formatNumber value="${simCar.carOdo}" type="number" pattern="#,#00" /> mi</span>
                                        </div>
                                        <div class="card-spec">
                                            <i class="fas fa-gas-pump"></i>
                                            <span>${simCar.fuelType}</span>
                                        </div>
                                        <div class="card-spec">
                                            <i class="fas fa-cog"></i>
                                            <span>${simCar.displacement} L</span>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <a href="${pageContext.request.contextPath}/car/detail?id=${simCar.carId}" class="view-details">Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thêm khoảng cách trước footer -->
        <div style="margin-bottom: 120px;"></div>

        <!-- Footer -->
        <jsp:include page="components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Tab switching
                const tabButtons = document.querySelectorAll('.tab-button');
                
                tabButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        // Remove active class from all buttons and tab panes
                        document.querySelectorAll('.tab-button').forEach(btn => {
                            btn.classList.remove('active');
                        });
                        
                        document.querySelectorAll('.tab-pane').forEach(pane => {
                            pane.classList.remove('active');
                        });
                        
                        // Add active class to current button and corresponding tab
                        this.classList.add('active');
                        
                        const targetId = this.getAttribute('data-target');
                        document.getElementById(targetId).classList.add('active');
                    });
                });
                
                // Contact form toggle
                const messageButton = document.getElementById('messageDealer');
                const contactForm = document.getElementById('contactForm');
                
                messageButton.addEventListener('click', function() {
                    if (contactForm.style.display === 'none') {
                        contactForm.style.display = 'block';
                    } else {
                            contactForm.style.display = 'none';
                        }
                    });
            });
        </script>
    </body>
</html> 