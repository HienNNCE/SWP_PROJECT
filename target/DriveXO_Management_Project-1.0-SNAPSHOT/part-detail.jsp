<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DriverXO - Part Detail</title>
        <link rel="stylesheet" href="../asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .page-title-section {
                background-color: #f8f9fa;
                padding: 30px 0;
            }
            .car-detail-hero {
                background-color: #f8f9fa;
                padding: 50px 0;
            }
            .car-detail-wrapper {
                display: grid;
                grid-template-columns: 2fr 1fr;
                gap: 30px;
            }
            .car-gallery {
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

            .car-info-card {
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
            .btn-phone {
                background-color: var(--primary-color);
                color: #fff;
                padding: 14px 20px;
                border-radius: 8px;
                width: 100%;
                font-weight: 600;
                margin-bottom: 15px;
            }
            .btn-message {
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
        <section class="car-detail-hero">
            <div class="container" style="padding-top: 60px">
                <div class="car-detail-wrapper">

                    <!-- Image Gallery -->
                    <div class="car-gallery">
                        <div class="main-image">
                            <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" alt="${part.partName}">
                        </div>
                    </div>

                    <!-- Accessory Info -->
                    <div class="car-info-card">
                        <h1>${part.partName}</h1>
                        <div class="price-tag">
                            $<c:out value="${part.partPrice}" />
                        </div>

                        <div class="quick-info-grid">
                            <div class="quick-info-item">
                                <i class="fas fa-tags"></i>
                                <div class="info-value">${part.partBrand}</div>
                                <div class="info-label">Brand</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-car"></i>
                                <div class="info-value">${part.carModel}</div>
                                <div class="info-label">Model Compatible</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-box"></i>
                                <div class="info-value">${part.partStock}</div>
                                <div class="info-label">Stock</div>
                            </div>
                            <div class="quick-info-item">
                                <i class="fas fa-info-circle"></i>
                                <div class="info-value">Part</div>
                                <div class="info-label">Category</div>
                            </div>
                        </div>
                        <button class="btn-phone" onclick="addToCart('${part.partId}', '${part.partName}', '${part.partPrice}')">
                            <i class="fas fa-shopping-cart"></i> Add to Cart
                        </button>
                        <!--                        <button class="btn-phone"><i class="fas fa-phone"></i> 0915456680</button>
                                                <button class="btn-message"><i class="fas fa-comment"></i> Text to seller</button>-->
                        <div>
                            <a href="${pageContext.request.contextPath}/parts" class="btn-message" style="text-align: center; display: inline-block;">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Description -->
                <div class="car-detail-tabs" style="margin-top: 50px;">
                    <h3>Description</h3>
                    <p>${part.description}</p>
                </div>

                <!-- Related Parts Section -->
                <c:if test="${not empty relatedParts}">
                    <div class="container" style="margin-top: 60px;">
                        <h3 style="margin-bottom: 20px;">
                            You may also like (${fn:length(relatedParts)} related part${fn:length(relatedParts) > 1 ? 's' : ''})
                        </h3>
                        <div class="related-grid" style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; justify-items: start;">
                            <c:forEach var="rel" items="${relatedParts}">
                                <div style="background-color: #fff; border-radius: 10px; padding: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.05); text-align: center;">
                                    <img src="${pageContext.request.contextPath}/asset/img/parts/${rel.partImg}" alt="${rel.partName}" style="width:100%; height:180px; object-fit:contain; margin-bottom:10px; border-radius: 8px;">
                                    <h5 style="font-size: 15px; margin: 10px 0; color: #333;">${rel.partName}</h5>
                                    <p style="color: #777; font-size: 14px;">$<c:out value="${rel.partPrice}" /></p>
                                    <a href="${pageContext.request.contextPath}/part/detail?id=${rel.partId}" class="btn-message" style="padding: 8px 16px; font-size: 13px; text-decoration: none;">
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
                                    // Nếu không có banner thì luôn scrolled
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
        <script>
            function addToCart(partId, partName, partPriceStr) {
                const partPrice = parseFloat(partPriceStr);

                // Tăng số lượng icon
                const countEl = document.querySelector('.cart-btn .item-count');
                let currentCount = parseInt(countEl.innerText);
                if (isNaN(currentCount))
                    currentCount = 0;
                countEl.innerText = currentCount + 1;

                // Hiển thị alert
                alert(partName + " added to cart!");

                // Xóa empty nếu có
                const cartItemsContainer = document.querySelector(".cart-items");
                const emptyMsg = document.querySelector(".empty-cart");
                if (emptyMsg)
                    emptyMsg.remove();

                // Thêm sản phẩm vào giỏ
                const itemHtml = `<div class="cart-item">
                <p><strong>${partName}</strong> - $${partPrice.toFixed(2)}</p>
                </div>`;
                cartItemsContainer.insertAdjacentHTML('beforeend', itemHtml);

                // Cập nhật tổng tiền
                const totalAmountEl = document.querySelector(".total-amount");
                let currentTotal = parseFloat(totalAmountEl.innerText.replace('$', ''));
                if (isNaN(currentTotal))
                    currentTotal = 0;
                const newTotal = currentTotal + partPrice;
                totalAmountEl.innerText = `$${newTotal.toFixed(2)}`;
            }
        </script>
    </body>
</html>
