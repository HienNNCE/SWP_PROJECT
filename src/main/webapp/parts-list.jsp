<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Parts Collection - DriverXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .parts-header {
            text-align: center;
            margin: 60px 0 30px 0;
        }
        .parts-title {
            font-size: 32px;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }
        .parts-subtitle {
            font-size: 13px;
            color: #777;
            font-weight: 300;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }
        .parts-filter-section {
            max-width: 1280px;
            margin: 0 auto 30px auto;
            padding: 0 15px;
        }
        .parts-advanced-filter-grid {
            display: grid;
            grid-template-columns: 1fr 3fr;
            gap: 30px;
            align-items: start;
            background: #fcfcfc;
            border: 1px solid #f0f0f0;
            border-radius: 4px;
            padding: 30px 40px;
        }
        .parts-filter-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .parts-filter-form label {
            font-size: 13px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .parts-filter-form .filter-group {
            margin-bottom: 10px;
        }
        .parts-filter-form .filter-radio-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .parts-filter-form input[type="radio"] {
            accent-color: #000;
        }
        .parts-filter-form .filter-actions {
            display: flex;
            gap: 10px;
        }
        .parts-filter-form .filter-button {
            padding: 8px 16px;
            font-size: 12px;
            border: 1px solid #ddd;
            background: #fff;
            cursor: pointer;
            border-radius: 3px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .parts-filter-form .filter-button.primary {
            background: #000;
            color: #fff;
            border-color: #000;
        }
        .parts-filter-form .filter-button:hover {
            opacity: 0.8;
        }
        .parts-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        .part-card {
            border: 1px solid #eee;
            border-radius: 2px;
            background: #fff;
            display: flex;
            flex-direction: column;
            transition: border-color 0.2s;
        }
        .part-card:hover {
            border-color: #000;
        }
        .part-img-container {
            width: 100%;
            height: 160px;
            overflow: hidden;
            background: #f8f8f8;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .part-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s;
        }
        .part-card:hover .part-img {
            transform: scale(1.05);
        }
        .part-card-body {
            padding: 18px 16px 0 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .part-name {
            font-size: 15px;
            font-weight: 500;
            color: #000;
            margin-bottom: 6px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .part-meta {
            font-size: 12px;
            color: #666;
            margin-bottom: 10px;
        }
        .part-price {
            font-size: 15px;
            font-weight: 600;
            color: #000;
            margin-bottom: 8px;
        }
        .part-stock {
            font-size: 12px;
            color: #888;
            margin-bottom: 10px;
        }
        .part-card-footer {
            padding: 0 16px 16px 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .part-detail-btn, .part-add-btn {
            width: 100%;
            height: 36px;
            border: none;
            font-size: 13px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.2s, color 0.2s;
        }
        .part-detail-btn {
            background: #fff;
            border: 1px solid #ddd;
            color: #333;
        }
        .part-detail-btn:hover {
            border-color: #000;
            color: #000;
        }
        .part-add-btn {
            background: #000;
            color: #fff;
            border: 1px solid #000;
        }
        .part-add-btn:disabled {
            background: #eee;
            color: #bbb;
            border-color: #eee;
            cursor: not-allowed;
        }
        @media (max-width: 1200px) {
            .parts-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .parts-advanced-filter-grid {
                grid-template-columns: 1fr;
                padding: 20px 10px;
            }
            .parts-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="container" style="padding-top:100px;">    <div class="parts-header">
        <h1 class="parts-title">Parts Collection</h1>
        <p class="parts-subtitle">Browse and filter genuine car parts for your vehicle.</p>
    </div>
    <section class="parts-filter-section">
        <div class="parts-advanced-filter-grid">
            <form class="parts-filter-form" action="${pageContext.request.contextPath}/parts" method="get">
                <div class="filter-group">
                    <label>Car Model</label>
                    <div class="filter-radio-list">
                        <div class="filter-radio">
                            <input type="radio" id="model-all" name="carModel" value="" <c:if test="${empty param.carModel}">checked</c:if>>
                            <label for="model-all">All Models</label>
                        </div>
                        <c:forEach var="model" items="${carModels}">
                            <div class="filter-radio">
                                <input type="radio" id="model-${model}" name="carModel" value="${model}" <c:if test="${param.carModel == model}">checked</c:if>>
                                <label for="model-${model}">${model}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="filter-group">
                    <label>Sort by Price</label>
                    <div class="filter-radio-list">
                        <div class="filter-radio">
                            <input type="radio" id="sort-asc" name="sort" value="asc" <c:if test="${param.sort == 'asc'}">checked</c:if>>
                            <label for="sort-asc">Low to High</label>
                        </div>
                        <div class="filter-radio">
                            <input type="radio" id="sort-desc" name="sort" value="desc" <c:if test="${param.sort == 'desc'}">checked</c:if>>
                            <label for="sort-desc">High to Low</label>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="brand" value="${param.brand}" />
                <div class="filter-actions">
                    <button class="filter-button" type="reset" onclick="window.location.href='${pageContext.request.contextPath}/parts'">Reset</button>
                    <button class="filter-button primary" type="submit">Apply</button>
                </div>
            </form>
            <div>
                <div class="parts-grid">
                    <c:forEach var="part" items="${parts}">
                        <div class="part-card">
                            <div class="part-img-container">
                                <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" class="part-img" alt="${part.partName}">
                            </div>
                            <div class="part-card-body">
                                <div class="part-name">${part.partName}</div>
                                <div class="part-meta">${part.partBrand} • ${part.carModel}</div>
                                <div class="part-price">$<c:out value="${part.partPrice}"/></div>
                                <div class="part-stock"><i class="fas fa-box"></i> Stock: ${part.partStock}</div>
                            </div>
                            <div class="part-card-footer">
                                <a href="${pageContext.request.contextPath}/part/detail?id=${part.partId}" class="part-detail-btn"><i class="fas fa-info-circle"></i> Detail</a>
                                <button type="button" part-id='${part.partId}' class="part-add-btn" <c:if test="${part.partStock <= 0}">disabled</c:if>>Add to Cart</button>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty parts}">
                        <div style="grid-column: 1/-1; text-align:center; color:#888; padding:60px 0; font-size:18px;">No parts found.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html>