<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Footer -->
<footer class="minimal-footer">
    <div class="container">
        <div class="footer-top">
            <div class="footer-logo">
                <img src="asset/img/driverxo-logo-white.png" alt="DriverXO">
                <span>DriverXO</span>
            </div>
            
            <div class="footer-links">
                <div class="footer-links-group">
                    <h4>Quick Links</h4>
                    <ul>
                        <li><a href="home">Home</a></li>
                        <li><a href="car/list">Our Cars</a></li>
                        <li><a href="services">Services</a></li>
                    </ul>
                </div>
                
                <div class="footer-links-group">
                    <h4>Company</h4>
                    <ul>
                        <li><a href="about">About Us</a></li>
                        <li><a href="contact">Contact</a></li>
                        <li><a href="feedback">Feedback</a></li>
                    </ul>
                </div>
                
                <div class="footer-links-group">
                    <h4>Contact</h4>
                    <ul class="contact-info">
                        <li><i class="fas fa-phone"></i> (555) 123-4567</li>
                        <li><i class="fas fa-envelope"></i> info@driverxo.com</li>
                        <li><i class="fas fa-map-marker-alt"></i> HCM City, Vietnam</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="footer-bottom">
            <div class="copyright">
                <p>© 2025 Group3 - SE1816</p>
            </div>
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <div class="legal-links">
                <a href="#">Privacy</a>
                <a href="#">Terms</a>
            </div>
        </div>
    </div>
</footer>

<style>
    /* Minimal Footer Styles */
    .minimal-footer {
        background-color: #111;
        color: #fff;
        padding: 40px 0 20px;
        font-size: 14px;
    }
    
    .footer-top {
        display: flex;
        justify-content: space-between;
        margin-bottom: 30px;
        padding-bottom: 30px;
    }
    
    .footer-logo {
        display: flex;
        align-items: center;
    }
    
    .footer-logo img {
        height: 24px;
        margin-right: 10px;
    }
    
    .footer-logo span {
        font-size: 18px;
        font-weight: 400;
        letter-spacing: 1px;
    }
    
    .footer-links {
        display: flex;
        gap: 60px;
    }
    
    .footer-links-group h4 {
        font-size: 14px;
        font-weight: 500;
        margin-bottom: 15px;
        color: #fff;
    }
    
    .footer-links-group ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    
    .footer-links-group ul li {
        margin-bottom: 8px;
    }
    
    .footer-links-group ul li a {
        color: rgba(255,255,255,0.7);
        text-decoration: none;
        transition: color 0.2s ease;
    }
    
    .footer-links-group ul li a:hover {
        color: #fff;
    }
    
    .contact-info li {
        color: rgba(255,255,255,0.7);
        margin-bottom: 8px;
        display: flex;
        align-items: center;
    }
    
    .contact-info li i {
        margin-right: 8px;
        font-size: 12px;
        color: rgba(255,255,255,0.5);
    }
    
    .footer-bottom {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 20px;
    }
    
    .copyright {
        color: rgba(255,255,255,0.5);
        font-size: 12px;
    }
    
    .social-links {
        display: flex;
        gap: 15px;
    }
    
    .social-links a {
        color: rgba(255,255,255,0.5);
        transition: color 0.2s ease;
        font-size: 14px;
    }
    
    .social-links a:hover {
        color: #fff;
    }
    
    .legal-links {
        display: flex;
        gap: 15px;
    }
    
    .legal-links a {
        color: rgba(255,255,255,0.5);
        text-decoration: none;
        font-size: 12px;
        transition: color 0.2s ease;
    }
    
    .legal-links a:hover {
        color: #fff;
    }
    
    /* Responsive styles */
    @media (max-width: 768px) {
        .footer-top {
            flex-direction: column;
        }
        
        .footer-logo {
            margin-bottom: 30px;
        }
        
        .footer-links {
            flex-wrap: wrap;
            gap: 30px;
        }
        
        .footer-bottom {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
    }
</style> 