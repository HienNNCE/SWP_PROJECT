<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>About Us - DriverXO</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .about-section {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            padding: 40px 28px 32px 28px;
            margin-bottom: 36px;
        }
        .about-section-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #222;
            margin-bottom: 14px;
            letter-spacing: 0.2px;
        }
        .about-section-subtitle {
            font-size: 1.02rem;
            color: #666;
            margin-bottom: 20px;
            font-weight: 400;
        }
        .about-features, .about-services, .about-team {
            display: flex;
            flex-wrap: wrap;
            gap: 22px;
            margin-bottom: 10px;
        }
        .about-feature, .about-service, .about-member {
            flex: 1 1 220px;
            background: #fff;
            border-radius: 10px;
            padding: 22px 12px 18px 12px;
            text-align: center;
            box-shadow: none;
            border: 1px solid #f3f3f3;
        }
        .about-feature i, .about-service i {
            font-size: 1.5rem;
            color: #072eb0;
            margin-bottom: 10px;
            opacity: 0.7;
        }
        .about-feature-title, .about-service-title {
            font-size: 1.01rem;
            font-weight: 500;
            color: #222;
            margin-bottom: 6px;
        }
        .about-feature-desc, .about-service-desc {
            color: #888;
            font-size: 0.97rem;
            font-weight: 400;
        }
        .about-member img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 8px;
            border: 1.5px solid #eee;
        }
        .about-member-name {
            font-weight: 500;
            color: #222;
            margin-bottom: 2px;
            font-size: 1rem;
        }
        .about-member-role {
            color: #aaa;
            font-size: 0.95rem;
            margin-bottom: 6px;
        }
        .about-member-desc {
            color: #888;
            font-size: 0.95rem;
            font-weight: 400;
        }
        .about-cta {
            text-align: center;
            margin: 48px 0 32px 0;
        }
        .about-cta-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #222;
            margin-bottom: 10px;
        }
        .about-cta-desc {
            color: #666;
            font-size: 1rem;
            margin-bottom: 16px;
        }
        .about-cta-btn {
            display: inline-block;
            padding: 12px 32px;
            background: #111;
            color: #fff;
            border-radius: 5px;
            font-size: 1rem;
            font-weight: 500;
            text-decoration: none;
            border: none;
            transition: background 0.18s;
            margin-bottom: 8px;
        }
        .about-cta-btn:hover {
            background: #072eb0;
        }
        @media (max-width: 900px) {
            .about-section {
                padding: 18px 3vw 12px 3vw;
            }
            .about-features, .about-team, .about-services {
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="car-listing-page" style="padding-top: 80px;">
    <div class="container">
        <div class="car-listing-header-container">
            <header class="car-listing-header">
                <h1 class="car-listing-title">About DriverXO</h1>
                <p class="car-listing-subtitle">Redefining your automotive experience with trust, quality, and innovation.</p>
            </header>
        </div>
        <div class="about-section">
            <div class="about-section-title">Our Mission & Vision</div>
            <div class="about-section-subtitle">
                <strong>Mission:</strong> To empower every driver with access to the finest vehicles, authentic parts, and exceptional service, making car ownership seamless and enjoyable.<br>
                <strong>Vision:</strong> To become the most trusted and innovative automotive platform in Vietnam and beyond.
            </div>
            <div class="about-features">
                <div class="about-feature">
                    <i class="fas fa-shield-alt"></i>
                    <div class="about-feature-title">Trust & Transparency</div>
                    <div class="about-feature-desc">Every car and part is thoroughly inspected and verified for authenticity. We believe in honest pricing and clear information.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-bolt"></i>
                    <div class="about-feature-title">Innovation</div>
                    <div class="about-feature-desc">We leverage technology to simplify your journey, from smart search to seamless checkout and real-time support.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-users"></i>
                    <div class="about-feature-title">Customer-Centric</div>
                    <div class="about-feature-desc">Your satisfaction is our top priority. Our team is always ready to support and listen to your needs.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-globe-asia"></i>
                    <div class="about-feature-title">Community Impact</div>
                    <div class="about-feature-desc">We aim to create positive change in the automotive industry and contribute to a sustainable future.</div>
                </div>
            </div>
        </div>
        <div class="about-section">
            <div class="about-section-title">Why Choose DriverXO?</div>
            <div class="about-features">
                <div class="about-feature">
                    <i class="fas fa-car"></i>
                    <div class="about-feature-title">Premium Car Selection</div>
                    <div class="about-feature-desc">A curated collection of luxury, sports, and family vehicles from top brands, all in pristine condition.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-cogs"></i>
                    <div class="about-feature-title">Genuine Parts</div>
                    <div class="about-feature-desc">Only authentic, high-quality parts to ensure your vehicle’s performance and safety.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-tools"></i>
                    <div class="about-feature-title">Expert Services</div>
                    <div class="about-feature-desc">From maintenance to repairs, our certified technicians provide reliable, transparent service.</div>
                </div>
                <div class="about-feature">
                    <i class="fas fa-headset"></i>
                    <div class="about-feature-title">Dedicated Support</div>
                    <div class="about-feature-desc">24/7 customer care, real-time chat, and personalized assistance for every need.</div>
                </div>
            </div>
        </div>
        <div class="about-section">
            <div class="about-section-title">Our Services</div>
            <div class="about-services">
                <div class="about-service">
                    <i class="fas fa-car-side"></i>
                    <div class="about-service-title">Car Sales</div>
                    <div class="about-service-desc">Buy, sell, or trade-in your vehicle with confidence and ease.</div>
                </div>
                <div class="about-service">
                    <i class="fas fa-cogs"></i>
                    <div class="about-service-title">Parts Marketplace</div>
                    <div class="about-service-desc">Browse and order genuine parts for all major car models.</div>
                </div>
                <div class="about-service">
                    <i class="fas fa-tools"></i>
                    <div class="about-service-title">Maintenance & Repair</div>
                    <div class="about-service-desc">Professional service centers and mobile repair for your convenience.</div>
                </div>
                <div class="about-service">
                    <i class="fas fa-calendar-check"></i>
                    <div class="about-service-title">Appointment Booking</div>
                    <div class="about-service-desc">Book test drives, service appointments, and consultations online.</div>
                </div>
                <div class="about-service">
                    <i class="fas fa-headset"></i>
                    <div class="about-service-title">Customer Support</div>
                    <div class="about-service-desc">Friendly, knowledgeable support team available around the clock.</div>
                </div>
            </div>
        </div>
        <div class="about-section">
            <div class="about-section-title">Meet Our Team</div>
            <div class="about-team" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 22px; justify-items: center;">
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="GIA HUY">
                    <div class="about-member-name">GIA HUY</div>
                    <div class="about-member-role">Member</div>
                </div>
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="NGOC HIEN">
                    <div class="about-member-name">NGOC HIEN</div>
                    <div class="about-member-role">Member</div>
                </div>
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="NHAT THIEN">
                    <div class="about-member-name">NHAT THIEN</div>
                    <div class="about-member-role">Member</div>
                </div>
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="NGOC NHU">
                    <div class="about-member-name">NGOC NHU</div>
                    <div class="about-member-role">Member</div>
                </div>
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="QUOC THANG">
                    <div class="about-member-name">QUOC THANG</div>
                    <div class="about-member-role">Member</div>
                </div>
                <div class="about-member">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="VINH PHUC">
                    <div class="about-member-name">VINH PHUC</div>
                    <div class="about-member-role">Member</div>
                </div>
            </div>
        </div>
        <div class="about-cta">
            <div class="about-cta-title">Ready to experience the DriverXO difference?</div>
            <div class="about-cta-desc">Explore our collection, book a test drive, or contact our team for personalized assistance. Your journey starts here.</div>
            <a href="${pageContext.request.contextPath}/car/list" class="about-cta-btn">Browse Cars</a>
            <a href="${pageContext.request.contextPath}/parts" class="about-cta-btn" style="margin-left: 12px; background: #072eb0;">Shop Parts</a>
        </div>
    </div>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html> 