<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Footer -->
<footer class="footer black-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-col">
                <div class="footer-logo">
                    <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo-white.png" alt="DriverXO">
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
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/home"><i class="fas fa-chevron-right"></i> Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/car/list"><i class="fas fa-chevron-right"></i> Our Cars</a></li>
                    <li><a href="${pageContext.request.contextPath}/services"><i class="fas fa-chevron-right"></i> Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-chevron-right"></i> Contact Us</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>My Account</h3>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/profile"><i class="fas fa-chevron-right"></i> My Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart"><i class="fas fa-chevron-right"></i> My Cart</a></li>
                    <li><a href="${pageContext.request.contextPath}/order-history"><i class="fas fa-chevron-right"></i> Order History</a></li>
                    <li><a href="${pageContext.request.contextPath}/bookings"><i class="fas fa-chevron-right"></i> My Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/feedback"><i class="fas fa-chevron-right"></i> Submit Feedback</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>Contact Us</h3>
                <ul class="contact-info">
                    <li><i class="fas fa-phone"></i> (555) 123-4567</li>
                    <li><i class="fas fa-envelope"></i> info@driverxo.com</li>
                    <li><i class="fas fa-map-marker-alt"></i> 123 Luxury Drive, <br>HCM City, Vietnam</li>
                </ul>
                <div class="newsletter">
                    <h4>Subscribe to Our Newsletter</h4>
                    <form class="newsletter-form">
                        <input type="email" placeholder="Your email address" required>
                        <button type="submit"><i class="fas fa-paper-plane"></i></button>
                    </form>
                </div>
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
