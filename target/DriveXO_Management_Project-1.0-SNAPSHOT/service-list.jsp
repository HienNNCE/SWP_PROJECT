<%@ page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Services Collection - DriverXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        html, body {
            height: 100%;
        }
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        .container {
            flex: 1 0 auto;
        }
        footer {
            flex-shrink: 0;
        }
        .services-header {
            text-align: center;
            margin: 60px 0 30px 0;
        }
        .services-title {
            font-size: 32px;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }
        .services-subtitle {
            font-size: 13px;
            color: #777;
            font-weight: 300;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }
        .services-filter-section {
            max-width: 1280px;
            margin: 0 auto 30px auto;
            padding: 0 15px;
        }
        .services-advanced-filter-grid {
            display: grid;
            grid-template-columns: 1fr 3fr;
            gap: 30px;
            align-items: start;
            background: #fcfcfc;
            border: 1px solid #f0f0f0;
            border-radius: 4px;
            padding: 30px 40px;
        }
        .services-filter-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .services-filter-form label {
            font-size: 13px;
            font-weight: 500;
            color: #333;
            margin-bottom: 8px;
        }
        .services-filter-form .filter-group {
            margin-bottom: 10px;
        }
        .services-filter-form .filter-radio-list {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .services-filter-form input[type="radio"] {
            accent-color: #000;
        }
        .services-filter-form .filter-actions {
            display: flex;
            gap: 10px;
        }
        .services-filter-form .filter-button {
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
        .services-filter-form .filter-button.primary {
            background: #000;
            color: #fff;
            border-color: #000;
        }
        .services-filter-form .filter-button:hover {
            opacity: 0.8;
        }
        .services-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        .service-card {
            border: 1px solid #eee;
            border-radius: 2px;
            background: #fff;
            display: flex;
            flex-direction: column;
            transition: border-color 0.2s;
        }
        .service-card:hover {
            border-color: #000;
        }
        .service-img-container {
            width: 100%;
            height: 160px;
            overflow: hidden;
            background: #f8f8f8;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .service-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            transition: transform 0.3s;
        }
        .service-card:hover .service-img {
            transform: scale(1.05);
        }
        .service-card-body {
            padding: 18px 16px 0 16px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .service-name {
            font-size: 15px;
            font-weight: 500;
            color: #000;
            margin-bottom: 6px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .service-meta {
            font-size: 12px;
            color: #666;
            margin-bottom: 10px;
        }
        .service-price {
            font-size: 15px;
            font-weight: 600;
            color: #000;
            margin-bottom: 8px;
        }
        .service-estimate {
            font-size: 12px;
            color: #888;
            margin-bottom: 10px;
        }
        .service-card-footer {
            padding: 0 16px 16px 16px;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .service-detail-btn, .service-add-btn {
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
        .service-detail-btn {
            background: #fff;
            border: 1px solid #ddd;
            color: #333;
        }
        .service-detail-btn:hover {
            border-color: #000;
            color: #000;
        }
        .service-add-btn {
            background: #000;
            color: #fff;
            border: 1px solid #000;
        }
        .service-add-btn:disabled {
            background: #eee;
            color: #bbb;
            border-color: #eee;
            cursor: not-allowed;
        }
        @media (max-width: 1200px) {
            .services-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        @media (max-width: 768px) {
            .services-advanced-filter-grid {
                grid-template-columns: 1fr;
                padding: 20px 10px;
            }
            .services-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="container" style="padding-top:100px;">
    <div class="services-header">
        <h1 class="services-title">Services Collection</h1>
        <p class="services-subtitle">Browse and filter our premium car services.</p>
    </div>
    <section class="services-filter-section">
        <div class="services-advanced-filter-grid">
            <form class="services-filter-form" action="${pageContext.request.contextPath}/services/filter" method="get">
                <div class="filter-group">
                    <label>Service Type</label>
                    <div class="filter-radio-list">
                        <div class="filter-radio">
                            <input type="radio" id="type-all" name="serviceType" value="" <c:if test="${empty param.serviceType}">checked</c:if>>
                            <label for="type-all">All Types</label>
                        </div>
                        <c:forEach var="type" items="${serviceTypes}">
                            <div class="filter-radio">
                                <input type="radio" id="type-${type}" name="serviceType" value="${type}" <c:if test="${param.serviceType == type}">checked</c:if>>
                                <label for="type-${type}">${type}</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <%-- <div class="filter-group">
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
                </div> --%>
                <div class="filter-group">
                    <label>Search</label>
                    <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="e.g., Oil Change">
                </div>
                <div class="filter-actions">
                    <button class="filter-button" type="reset" onclick="window.location.href='${pageContext.request.contextPath}/services'">Reset</button>
                    <button class="filter-button primary" type="submit">Apply</button>
                </div>
            </form>
            <div>
                <div class="services-grid">
                    <c:forEach var="service" items="${services}">
                        <div class="service-card">
                            <div class="service-img-container">
                                <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" class="service-img" alt="${service.serviceName}">
                            </div>
                            <div class="service-card-body">
                                <div class="service-name">${service.serviceName}</div>
                                <%-- <div class="service-meta">${service.serviceType}</div> --%>
                                <div class="service-price">$<c:out value="${service.servicePrice}"/></div>
                                <div class="service-estimate"><i class="fas fa-clock"></i> Estimate: ${service.estimateTime}</div>
                            </div>
                            <div class="service-card-footer">
                                <a href="${pageContext.request.contextPath}/service/detail?id=${service.serviceId}" class="service-detail-btn"><i class="fas fa-info-circle"></i> Detail</a>
                                <a class="service-add-btn" href="${pageContext.request.contextPath}/serviceAppointment?serviceId=${service.serviceId}">Book Now</a>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty services}">
                        <div style="grid-column: 1/-1; text-align:center; color:#888; padding:60px 0; font-size:18px;">No services found.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html>
