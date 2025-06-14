<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Parts Listing - DriverXO</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .page-title-section {
                background-color: #f8f9fa;
                padding: 30px 0;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            }

            .part-img {
                width: 100%;
                height: 200px;
                object-fit: contain;
                background-color: #f8f9fa; /* tránh nền trắng nếu ảnh nhỏ */
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                padding: 10px;
            }

            .filter-section {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="../components/navbar.jsp" />

        <div class="container">
            <!-- Breadcrumb -->
            <section class="page-title-section">
                <div class="container">
                    <div class="breadcrumb">
                        <a href="${pageContext.request.contextPath}/home">Home</a>
                        <span><i class="fas fa-angle-right"></i></span>
                        <a href="${pageContext.request.contextPath}/parts">Parts</a>
                    </div>
                </div>
            </section>

            <!-- Search and Filter -->
            <div class="filter-section">
                <form class="row g-3" action="${pageContext.request.contextPath}/parts/filter" method="get">
                    <!-- Search -->
                    <div class="col-md-4">
                        <label class="form-label fw-bold">Search by Name</label>
                        <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="e.g., Brake Pad">
                    </div>

                    <!-- Brand -->
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Brand</label>
                        <select name="brand" class="form-select">
                            <option value="">All Brands</option>
                            <c:forEach var="b" items="${brands}">
                                <option value="${b}" ${param.brand == b ? 'selected' : ''}>${b}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Car Model -->
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Car Model</label>
                        <input type="text" name="carModel" class="form-control" placeholder="e.g., Civic" value="${param.carModel}">
                    </div>

                    <!-- Sort by Price -->
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Sort by Price</label>
                        <select name="sort" class="form-select">
                            <option value="">No Sort</option>
                            <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Low to High</option>
                            <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>High to Low</option>
                        </select>
                    </div>


                    <!-- Stock -->
                    <div class="col-md-2">
                        <label class="form-label fw-bold">Stock Range</label>
                        <div class="d-flex">
                            <input type="number" name="stockFrom" class="form-control me-1" placeholder="From" value="${param.stockFrom}">
                            <input type="number" name="stockTo" class="form-control" placeholder="To" value="${param.stockTo}">
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="col-md-12 d-flex justify-content-end gap-2 mt-2">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-filter"></i> Apply Filter</button>
                        <a href="${pageContext.request.contextPath}/parts" class="btn btn-secondary">Reset</a>
                    </div>
                </form>
            </div>

            <!-- Parts Grid -->
            <div class="row g-4">
                <c:forEach var="part" items="${parts}">
                    <div class="col-md-4 col-lg-3">
                        <div class="card h-150">
                            <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" class="part-img" alt="${part.partName}">
                            <div class="card-body">
                                <h5 class="card-title">${part.partName}</h5>
                                <p class="card-text text-muted">${part.partBrand} - ${part.carModel}</p>
                                <p class="card-text"><strong>$<c:out value="${part.partPrice}" /></strong></p>
                                <p class="card-text"><i class="fas fa-box"></i> Stock: ${part.partStock}</p>
                            </div>
                            <div class="card-footer bg-transparent border-0 d-flex flex-column gap-2">
                                <a href="${pageContext.request.contextPath}/part/detail?id=${part.partId}" class="btn btn-outline-secondary w-100">
                                    <i class="fas fa-info-circle"></i> View Details
                                </a>

                                <button class="btn btn-primary w-100" onclick="addToCartInline(
                                                '${part.partId}',
                                                '${fn:escapeXml(part.partName)}',
                                                '${part.partPrice}')">
                                    <i class="fas fa-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty parts}">
                    <div class="alert alert-warning text-center mt-4">No parts found.</div>
                </c:if>
            </div>
        </div>

        <jsp:include page="../components/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function addToCartInline(partId, partName, partPriceStr) {
                const partPrice = parseFloat(partPriceStr);
                if (!partName || isNaN(partPrice)) {
                    alert("Error: Invalid part info.");
                    return;
                }

                const countEl = document.querySelector('.cart-btn .item-count');
                let currentCount = parseInt(countEl.innerText);
                if (isNaN(currentCount))
                    currentCount = 0;
                countEl.innerText = currentCount + 1;

                const cartItemsContainer = document.querySelector(".cart-items");
                const emptyMsg = document.querySelector(".empty-cart");
                if (emptyMsg)
                    emptyMsg.remove();

                const itemHtml = `<div class="cart-item">
                <p><strong>${partName}</strong> - $${partPrice.toFixed(2)}</p>
                </div>`;
                cartItemsContainer.insertAdjacentHTML('beforeend', itemHtml);

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
