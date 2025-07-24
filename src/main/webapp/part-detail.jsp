<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DriverXO - Part Details</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
        <style>
            .part-detail-page .section-label {
                font-size: 15px;
                font-weight: 600;
                color: #222;
                margin-bottom: 10px;
                letter-spacing: 0.5px;
            }
            .part-detail-page .highlights-grid {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 18px 24px;
                margin-bottom: 24px;
            }
            .part-detail-page .highlight-item {
                display: flex;
                align-items: center;
                gap: 12px;
                background: #f8f8f8;
                border-radius: 8px;
                padding: 12px 16px;
            }
            .part-detail-page .highlight-icon {
                font-size: 20px;
                color: #888;
                min-width: 28px;
                text-align: center;
            }
            .part-detail-page .highlight-value {
                font-weight: 600;
                color: #222;
                font-size: 15px;
            }
            .part-detail-page .highlight-label {
                font-size: 12px;
                color: #888;
            }
            .part-detail-page .features-preview {
                margin-bottom: 24px;
            }
            .part-detail-page .feature-chip {
                display: inline-block;
                background: #f3f3f3;
                color: #444;
                border-radius: 16px;
                padding: 6px 16px;
                font-size: 13px;
                font-weight: 500;
                margin: 0 8px 8px 0;
            }
            .part-detail-page .feature-chip i {
                margin-right: 6px;
                color: #27ae60;
            }
            .part-detail-page .price-card {
                background: #f8f8f8;
                border-radius: 10px;
                padding: 24px 20px 18px 20px;
                margin-bottom: 18px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
            }
            .part-detail-page .current-price {
                font-size: 2rem;
                font-weight: 700;
                color: #222;
                margin-bottom: 6px;
            }
            .part-detail-page .price-qualifier {
                font-size: 13px;
                color: #888;
                margin-bottom: 0;
            }
            .part-detail-page .contact-actions {
                display: flex;
                gap: 12px;
                margin-bottom: 18px;
            }
            .part-detail-page .contact-action-btn {
                flex: 1;
                padding: 13px 0;
                border-radius: 8px;
                font-size: 15px;
                font-weight: 600;
                border: none;
                background: #222;
                color: #fff;
                cursor: pointer;
                transition: background 0.18s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }
            .part-detail-page .contact-action-btn.secondary {
                background: #fff;
                color: #222;
                border: 1px solid #ddd;
            }
            .part-detail-page .contact-action-btn.secondary:hover {
                background: #f3f3f3;
            }
            .part-detail-page .contact-action-btn:hover {
                background: #111;
            }
            .part-detail-page .guarantee-line {
                margin-top: 10px;
                color: #888;
                font-size: 13px;
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .part-detail-page .part-description {
                margin-top: 40px;
                background: #fff;
                border-radius: 10px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
                padding: 32px 28px;
            }
            .part-detail-page .related-parts-section {
                margin-top: 60px;
            }
            .part-detail-page .related-parts-title {
                font-size: 1.2rem;
                font-weight: 600;
                margin-bottom: 20px;
                color: #222;
            }
            .part-detail-page .related-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
            }
            .part-detail-page .related-card {
                background: #fff;
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.05);
                text-align: center;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .part-detail-page .related-card img {
                width: 100%;
                height: 160px;
                object-fit: contain;
                margin-bottom: 10px;
                border-radius: 8px;
            }
            .part-detail-page .related-card .related-name {
                font-size: 15px;
                margin: 10px 0 4px 0;
                color: #333;
                font-weight: 500;
            }
            .part-detail-page .related-card .related-price {
                color: #777;
                font-size: 14px;
                margin-bottom: 8px;
            }
            .part-detail-page .related-card .btn-message {
                padding: 8px 16px;
                font-size: 13px;
                text-decoration: none;
                border-radius: 6px;
                border: 1px solid #222;
                background: #fff;
                color: #222;
                font-weight: 500;
                transition: background 0.18s, color 0.18s;
                display: inline-block;
            }
            .part-detail-page .related-card .btn-message:hover {
                background: #222;
                color: #fff;
            }
            @media (max-width: 992px) {
                .part-detail-page .car-detail-container {
                    flex-direction: column;
                    gap: 32px;
                }
                .part-detail-page .related-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 600px) {
                .part-detail-page .car-detail-container {
                    flex-direction: column;
                    gap: 24px;
                }
                .part-detail-page .part-description {
                    padding: 18px 8px;
                }
                .part-detail-page .related-grid {
                    grid-template-columns: 1fr;
                }
            }

            .comment-section {
                margin-top: 40px;
            }

            .btn-comment {
                display: inline-block;
                padding: 10px 18px;
                font-size: 14px;
                font-weight: 600;
                background-color: var(--primary-color, #007bff);
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                margin-bottom: 20px;
                transition: background-color 0.3s ease;
            }

            .btn-comment:hover {
                background-color: #0056b3;
            }

            .comment-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            .comment-item {
                background-color: #f8f9fa;
                border-left: 4px solid var(--primary-color, #007bff);
                padding: 15px 20px;
                border-radius: 6px;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.05);
            }

            .comment-author {
                font-weight: 600;
                font-size: 14px;
                margin-bottom: 5px;
                color: #333;
            }

            .comment-rating i {
                color: #f5c518;
                font-size: 16px;
                margin-right: 2px;
            }

            .comment-content {
                font-size: 14px;
                color: #444;
                margin: 8px 0;
            }

            .comment-date {
                font-size: 12px;
                color: #888;
            }

            /* MODAL COMMENT */
            .modal {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background-color: #fff;
                padding: 30px;
                border-radius: 10px;
                max-width: 500px;
                width: 90%;
                box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
                position: relative;
                animation: fadeIn 0.3s ease;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .close-modal {
                position: absolute;
                top: 15px;
                right: 20px;
                font-size: 22px;
                color: #aaa;
                cursor: pointer;
            }

            .close-modal:hover {
                color: #000;
            }

            .rating-stars {
                margin-bottom: 15px;
            }

            .star {
                font-size: 24px;
                color: #ccc;
                cursor: pointer;
                margin-right: 5px;
                transition: color 0.2s ease;
            }

            .star.selected {
                color: #f5c518;
            }

            .comment-input {
                width: 100%;
                min-height: 100px;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #ccc;
                resize: vertical;
                margin-bottom: 20px;
                font-size: 14px;
            }
        </style>
    </head>
    <body class="part-detail-page">
        <jsp:include page="/components/navbar.jsp" />
        <div class="car-listing-page">
            <div class="container" style="padding-top: 80px;">
                <!-- Header Section -->
                <div class="car-listing-header-container">
                    <header class="car-listing-header">
                        <h1 class="car-listing-title">Part Details</h1>
                        <p class="car-listing-subtitle">Comprehensive information about this genuine part</p>
                    </header>
                </div>
                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/home">Home</a>
                    <i class="fas fa-angle-right"></i>
                    <a href="${pageContext.request.contextPath}/parts">Parts</a>
                    <i class="fas fa-angle-right"></i>
                    <span>${part.partName}</span>
                </div>
                <!-- Main Detail Layout -->
                <div class="car-detail-container" style="display: flex; gap: 40px; align-items: flex-start;">
                    <!-- Left: Gallery -->
                    <div class="car-gallery" style="flex:1; min-width: 320px; max-width: 480px;">
                        <div class="car-main-image" style="background: #f8f8f8; border-radius: 10px; overflow: hidden; display: flex; align-items: center; justify-content: center; height: 340px;">
                            <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" alt="${part.partName}" style="width: 100%; height: 100%; object-fit: contain;">
                        </div>
                    </div>
                    <!-- Right: Info -->
                    <div class="car-info" style="flex:1; min-width: 320px;">
                        <div class="car-header">
                            <div class="car-title">
                                <h1 class="car-name">${part.partName}</h1>
                                <div class="car-brand">${part.partBrand}</div>
                            </div>
                        </div>
                        <!-- Highlights -->
                        <div class="highlights-section">
                            <h3 class="section-label">Key Highlights</h3>
                            <div class="highlights-grid">
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-tags"></i></span>
                                    <div>
                                        <div class="highlight-value">${part.partBrand}</div>
                                        <div class="highlight-label">Brand</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-car"></i></span>
                                    <div>
                                        <div class="highlight-value">${part.carModel}</div>
                                        <div class="highlight-label">Model Compatible</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-box"></i></span>
                                    <div>
                                        <div class="highlight-value">${part.partStock}</div>
                                        <div class="highlight-label">Stock</div>
                                    </div>
                                </div>
                                <div class="highlight-item">
                                    <span class="highlight-icon"><i class="fas fa-info-circle"></i></span>
                                    <div>
                                        <div class="highlight-value">Part</div>
                                        <div class="highlight-label">Category</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Price Card -->
                        <div class="price-card">
                            <div class="current-price">$<c:out value="${part.partPrice}" /></div>
                            <div class="price-qualifier">Genuine part, best price</div>
                        </div>
                        <!-- Features Preview (nếu có thể mở rộng) -->
                        <div class="features-preview">
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> 100% Authentic</div>
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Warranty Included</div>
                            <div class="feature-chip"><i class="fas fa-check-circle"></i> Fast Delivery</div>
                        </div>
                        <!-- Contact Actions -->
                        <div class="contact-actions card">
                            <button type="button" part-id="${part.partId}" class="contact-action-btn add_to_cart">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                            <a href="${pageContext.request.contextPath}/parts" class="contact-action-btn secondary" style="text-align: center;">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>
                        <div class="guarantee-line">
                            <i class="fas fa-shield-alt"></i> Guaranteed by DriverXO
                        </div>
                    </div>
                </div>
                <!-- Description -->
                <div class="part-description">
                    <h3 style="font-size: 1.1rem; font-weight: 600; margin-bottom: 12px; color: #222;">Description</h3>
                    <p style="color: #444; font-size: 15px; line-height: 1.7;">${part.description}</p>
                </div>
                <!-- Related Parts Section -->
                <c:if test="${not empty relatedParts}">
                    <div class="related-parts-section">
                        <h3 class="related-parts-title">
                            You may also like (${fn:length(relatedParts)} related part${fn:length(relatedParts) > 1 ? 's' : ''})
                        </h3>
                        <div class="related-grid">
                            <c:forEach var="rel" items="${relatedParts}">
                                <div class="related-card">
                                    <img src="${pageContext.request.contextPath}/asset/img/parts/${rel.partImg}" alt="${rel.partName}">
                                    <div class="related-name">${rel.partName}</div>
                                    <div class="related-price">$<c:out value="${rel.partPrice}" /></div>
                                    <a href="${pageContext.request.contextPath}/part/detail?id=${rel.partId}" class="btn-message">
                                        <i class="fas fa-eye"></i> View Detail
                                    </a>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>

                <div class="container" style="margin-top: 60px;">
                    <div class="comment-section">
                        <h3 style="margin-bottom: 15px;">Comments</h3>
                        <c:if test="${hasPurchased}">
                            <button type="button" class="btn-comment" onclick="openCommentModal()">Comment</button>
                        </c:if>

                        <div class="comment-list">
                            <c:forEach var="cmt" items="${comments}">
                                <div class="comment-item">
                                    <div class="comment-author">${cmt.user.fullName}</div>
                                    <div class="comment-rating">
                                        <c:forEach begin="1" end="${cmt.rating}">
                                            <i class="fas fa-star"></i>
                                        </c:forEach>
                                    </div>
                                    <div class="comment-content">${cmt.commentText}</div>
                                    <div class="comment-date">${cmt.date}</div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- MODAL -->
                <div id="commentModal" class="modal">
                    <div class="modal-content">
                        <span class="close-modal" onclick="closeCommentModal()">&times;</span>
                        <h3 style="margin-bottom: 15px;">Leave Your Review</h3>
                        <form method="post" action="${pageContext.request.contextPath}/comment/add">
                            <input type="hidden" name="partId" value="${part.partId}" />
                            <div class="rating-stars">
                                <input type="hidden" name="rating" id="ratingValue" value="5" />
                                <c:forEach var="i" begin="1" end="5">
                                    <i class="fas fa-star star" data-value="${i}"></i>
                                </c:forEach>
                            </div>
                            <textarea name="content" class="comment-input" placeholder="Write your review..." required></textarea>
                            <button type="submit" class="btn-comment">Submit Review</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/components/footer.jsp" />
        <script src="${pageContext.request.contextPath}/asset/js/main.js"></script>

        <script>
                            function openCommentModal() {
                                document.getElementById('commentModal').style.display = 'flex';
                            }

                            function closeCommentModal() {
                                document.getElementById('commentModal').style.display = 'none';
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                const stars = document.querySelectorAll('.star');
                                const ratingInput = document.getElementById('ratingValue');

                                stars.forEach(star => {
                                    star.addEventListener('click', function () {
                                        const rating = parseInt(this.getAttribute('data-value'));
                                        ratingInput.value = rating;

                                        stars.forEach(s => {
                                            const value = parseInt(s.getAttribute('data-value'));
                                            s.classList.toggle('selected', value <= rating);
                                        });
                                    });
                                });
                            });
        </script>
    </body>
</html>
