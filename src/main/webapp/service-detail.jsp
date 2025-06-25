<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DriverXO - Service Detail</title>
        <link rel="stylesheet" href="../asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .page-title-section {
                background-color: #f8f9fa;
                padding: 30px 0;
            }
            .service-detail-hero {
                background-color: #f8f9fa;
                padding: 50px 0;
            }
            .service-detail-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
            }
            .service-gallery {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                background-color: #fff;
            }
            .main-image {
                height: 450px;
                background-color: #f8f9fa;
                border-radius: 10px 10px 0 0;
                display: flex;
                align-items: center;
                justify-content: center;
                overflow: hidden;
            }

            .main-image img {
                width: 100%;
                height: 100%;
                object-fit: contain;
                background-color: #f8f9fa;
                padding: 10px;
            }

            .service-info-card {
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
            .btn-booking {
                background-color: var(--primary-color);
                color: #fff;
                padding: 14px 20px;
                border-radius: 8px;
                width: 100%;
                font-weight: 600;
                margin-bottom: 15px;
            }
            .btn-back {
                background-color: #fff;
                border: 1px solid var(--primary-color);
                color: var(--primary-color);
                padding: 14px 20px;
                border-radius: 8px;
                width: 100%;
                font-weight: 600;
            }
            @media (max-width: 768px) {
                .related-grid {
                    grid-template-columns: repeat(2, 1fr) !important;
                }
            }
            @media (max-width: 480px) {
                .related-grid {
                    grid-template-columns: 1fr !important;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="/components/navbar.jsp" />

        <!-- Main Content -->
        <section class="service-detail-hero">
            <div class="container" style="padding-top: 60px">
                <div class="service-detail-wrapper">

                    <!-- Image Gallery -->
                    <div class="service-gallery">
                        <div class="main-image">
                            <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" alt="${service.serviceName}">
                        </div>
                    </div>

                    <!-- Service Info -->
                    <div class="service-info-card">
                        <h1>${service.serviceName}</h1>
                        <div class="price-tag">
                            $<c:out value="${service.servicePrice}" />
                        </div>

                        <div class="quick-info-grid">
                            <div class="quick-info-item">
                                <i class="fas fa-tags"></i>
                                <div class="info-value">${service.serviceType}</div>
                                <div class="info-label">Service Type</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-clock"></i>
                                <div class="info-value">${service.estimateTime}</div>
                                <div class="info-label">Estimate Time</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-info-circle"></i>
                                <div class="info-value">Service</div>
                                <div class="info-label">Category</div>
                            </div>
                        </div>
                        <button class="btn-booking" onclick="window.location.href='${pageContext.request.contextPath}/service/booking?id=${service.serviceId}'">
                            <i class="fas fa-calendar-check"></i> Book This Service
                        </button>
                        <div>
                            <a href="${pageContext.request.contextPath}/services" class="btn-back" style="text-align: center; display: inline-block;">
                                <i class="fas fa-arrow-left"></i> Back to Services
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Description -->
                <div class="service-detail-tabs" style="margin-top: 50px;">
                    <h3>Description</h3>
                    <p>${service.serviceDescription}</p>
                </div>

                <!-- Related Services Section -->
                <c:if test="${not empty relatedServices}">
                    <div class="container" style="margin-top: 60px;">
                        <h3 style="margin-bottom: 20px;">
                            You may also like (${fn:length(relatedServices)} related service${fn:length(relatedServices) > 1 ? 's' : ''})
                        </h3>
                        <div class="related-grid" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; justify-items: start;">
                            <c:forEach var="rel" items="${relatedServices}">
                                <div style="background-color: #fff; border-radius: 10px; padding: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); text-align: center;">
                                    <img src="${pageContext.request.contextPath}/asset/img/services/${rel.serviceImg}" alt="${rel.serviceName}" style="width:100%; height:180px; object-fit:contain; margin-bottom:10px; border-radius: 8px;">
                                    <h5 style="font-size: 15px; margin: 10px 0; color: #333;">${rel.serviceName}</h5>
                                    <p style="color: #777; font-size: 14px;">$<c:out value="${rel.servicePrice}" /></p>
                                    <a href="${pageContext.request.contextPath}/service/detail?id=${rel.serviceId}" class="btn-message" style="padding: 8px 16px; font-size: 13px; text-decoration: none;">
                                        <i class="fas fa-eye"></i> View Detail
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </section>

        <jsp:include page="/components/footer.jsp" />
        <script src="../asset/js/main.js"></script>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const header = document.querySelector('.header');
                const logoWhite = document.querySelector('.logo-white');
                const logoDark = document.querySelector('.logo-dark');

                const hasBanner = document.querySelector('.hero-banner') !== null;

                function updateNavbar() {
                    // If there's no banner, always keep it scrolled
                    if (!hasBanner || window.scrollY > 50) {
                        header.classList.add('scrolled');
                        if (logoWhite)
                            logoWhite.style.display = 'none';
                        if (logoDark)
                            logoDark.style.display = 'block';
                    } else {
                        header.classList.remove('scrolled');
                        if (logoWhite)
                            logoWhite.style.display = 'block';
                        if (logoDark)
                            logoDark.style.display = 'none';
                    }
                }

                updateNavbar();
                window.addEventListener('scroll', updateNavbar);
            });
        </script>
    </body>
</html>
