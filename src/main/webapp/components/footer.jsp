<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Footer -->
<footer class="footer black-footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-col">
                <div class="footer-logo">
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
                <h3>Quick Links</h3>
                <ul>
                    <li><a href="home"><i class="fas fa-chevron-right"></i> Home</a></li>
                    <li><a href="car/list"><i class="fas fa-chevron-right"></i> Our Cars</a></li>
                    <li><a href="services"><i class="fas fa-chevron-right"></i> Services</a></li>
                    <li><a href="about"><i class="fas fa-chevron-right"></i> About Us</a></li>
                    <li><a href="contact"><i class="fas fa-chevron-right"></i> Contact Us</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h3>My Account</h3>
                <ul>
                    <li><a href="profile"><i class="fas fa-chevron-right"></i> My Profile</a></li>
                    <li><a href="cart"><i class="fas fa-chevron-right"></i> My Cart</a></li>
                    <li><a href="order-history"><i class="fas fa-chevron-right"></i> Order History</a></li>
                    <li><a href="bookings"><i class="fas fa-chevron-right"></i> My Bookings</a></li>
                    <li><a href="feedback"><i class="fas fa-chevron-right"></i> Submit Feedback</a></li>
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

<style>
    /* Footer Styles */
    .footer {
        background-color: #333;
        color: #fff;
        padding: 60px 0 0;
    }
    
    .black-footer {
        background-color: #111;
    }
    
    .footer-content {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 30px;
    }
    
    .footer-col {
        margin-bottom: 30px;
    }
    
    .footer-logo {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
    }
    
    .footer-logo img {
        height: 40px;
        margin-right: 10px;
    }
    
    .footer-logo span {
        font-size: 24px;
        font-weight: 700;
    }
    
    .footer-col p {
        color: #ccc;
        margin-bottom: 25px;
        line-height: 1.8;
    }
    
    .footer-col h3 {
        font-size: 18px;
        color: #fff;
        margin-bottom: 20px;
        position: relative;
        padding-bottom: 10px;
    }
    
    .footer-col h3:after {
        content: '';
        position: absolute;
        left: 0;
        bottom: 0;
        width: 50px;
        height: 2px;
        background-color: var(--primary-color);
    }
    
    .footer-col ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-col ul li {
        margin-bottom: 12px;
    }
    
    .footer-col ul li a {
        color: #ccc;
        text-decoration: none;
        transition: color 0.3s;
        display: flex;
        align-items: center;
    }
    
    .footer-col ul li a i {
        margin-right: 8px;
        font-size: 12px;
    }
    
    .footer-col ul li a:hover {
        color: var(--primary-color);
    }
    
    .social-links {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }
    
    .social-links h4 {
        font-size: 16px;
        margin: 0;
    }
    
    .social-links a {
        display: inline-block;
        width: 35px;
        height: 35px;
        background-color: rgba(255, 255, 255, 0.1);
        color: #fff;
        border-radius: 50%;
        text-align: center;
        line-height: 35px;
        margin-right: 10px;
        transition: background-color 0.3s;
    }
    
    .social-links a:hover {
        background-color: var(--primary-color);
    }
    
    .contact-info li {
        display: flex;
        margin-bottom: 15px;
        color: #ccc;
    }
    
    .contact-info li i {
        margin-right: 15px;
        color: var(--primary-color);
        width: 16px;
    }
    
    .newsletter {
        margin-top: 25px;
    }
    
    .newsletter h4 {
        font-size: 16px;
        margin-bottom: 15px;
    }
    
    .newsletter-form {
        display: flex;
        height: 45px;
    }
    
    .newsletter-form input {
        flex: 1;
        padding: 10px 15px;
        border: none;
        border-radius: 4px 0 0 4px;
        font-size: 14px;
    }
    
    .newsletter-form button {
        padding: 0 15px;
        background-color: var(--primary-color);
        color: white;
        border: none;
        border-radius: 0 4px 4px 0;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    .newsletter-form button:hover {
        background-color: var(--secondary-color);
    }
    
    .footer-bottom {
        background-color: rgba(0, 0, 0, 0.3);
        padding: 20px 0;
        margin-top: 40px;
    }
    
    .footer-bottom .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .copyright {
        color: #999;
        font-size: 14px;
    }
    
    .footer-links a {
        color: #999;
        text-decoration: none;
        margin-left: 20px;
        font-size: 14px;
        transition: color 0.3s;
    }
    
    .footer-links a:hover {
        color: var(--primary-color);
    }
    
    /* Responsive styles */
    @media (max-width: 992px) {
        .footer-content {
            grid-template-columns: repeat(2, 1fr);
        }
    }
    
    @media (max-width: 576px) {
        .footer-content {
            grid-template-columns: 1fr;
        }
        
        .footer-bottom .container {
            flex-direction: column;
            text-align: center;
        }
        
        .footer-links {
            margin-top: 10px;
        }
        
        .footer-links a {
            margin: 0 10px;
        }
    }
</style> 