<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết xe - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --primary-dark: #2980b9;
            --secondary-color: #e74c3c;
            --secondary-dark: #c0392b;
            --text-color: #333;
            --light-gray: #f8f9fa;
            --border-color: #ddd;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            color: var(--text-color);
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border-color);
        }
        
        .header h1 {
            font-size: 24px;
            margin: 0;
            color: var(--primary-color);
        }
        
        .header .back-btn {
            display: flex;
            align-items: center;
            color: var(--text-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        
        .header .back-btn:hover {
            color: var(--primary-color);
        }
        
        .header .back-btn i {
            margin-right: 5px;
        }
        
        .card {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .card-body {
            padding: 25px;
        }
        
        .car-details {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .car-image {
            flex: 0 0 350px;
        }
        
        .car-image img {
            width: 100%;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        
        .car-info {
            flex: 1;
        }
        
        .car-name {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 5px;
            color: var(--text-color);
        }
        
        .car-brand {
            color: #666;
            font-size: 18px;
            margin-bottom: 20px;
        }
        
        .car-price {
            font-size: 24px;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 20px;
        }
        
        .car-specs {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-bottom: 30px;
        }
        
        .spec-item {
            display: flex;
            flex-direction: column;
            background-color: var(--light-gray);
            padding: 12px;
            border-radius: 6px;
            transition: transform 0.2s;
        }
        
        .spec-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .spec-label {
            font-size: 12px;
            color: #666;
            margin-bottom: 5px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .spec-value {
            font-size: 16px;
            font-weight: 500;
            color: var(--text-color);
        }
        
        .status-badge {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 20px;
        }
        
        .status-in-stock {
            background-color: #e3f8e3;
            color: #28a745;
        }
        
        .status-low-stock {
            background-color: #fff7e0;
            color: #ffc107;
        }
        
        .status-out-of-stock {
            background-color: #ffe0e0;
            color: #dc3545;
        }
        
        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 10px 16px;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
            font-size: 14px;
        }
        
        .btn i {
            margin-right: 6px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: #fff;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
        }
        
        .btn-danger {
            background-color: var(--secondary-color);
            color: #fff;
        }
        
        .btn-danger:hover {
            background-color: var(--secondary-dark);
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        @media (max-width: 768px) {
            .car-details {
                flex-direction: column;
            }
            
            .car-image {
                flex: 0 0 auto;
                max-width: 100%;
            }
            
            .car-specs {
                grid-template-columns: 1fr;
            }
            
            .container {
                padding: 15px;
            }
            
            .card-body {
                padding: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Chi tiết xe #${car.carId}</h1>
            <a href="${pageContext.request.contextPath}/admin/car" class="back-btn">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <c:if test="${empty car}">
                    <div class="alert alert-danger">Không tìm thấy xe hoặc xe đã bị xóa.</div>
                </c:if>
                
                <c:if test="${not empty car}">
                    <div class="car-details">
                        <div class="car-image">
                            <c:choose>
                                <c:when test="${not empty car.carImg}">
                                    <img src="${pageContext.request.contextPath}/asset/img/cars/${car.carImg}" alt="${car.carName}">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/asset/img/cars/default-car.png" alt="Default Car">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <div class="car-info">
                            <h2 class="car-name">${car.carName}</h2>
                            <div class="car-brand">${car.carBrand} | ${car.model}</div>
                            
                            <div class="car-price">
                                $<fmt:formatNumber value="${car.carPrice}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
                            </div>
                            
                            <c:choose>
                                <c:when test="${car.carStock > 5}">
                                    <span class="status-badge status-in-stock"><i class="fas fa-check-circle"></i> Còn hàng (${car.carStock} xe)</span>
                                </c:when>
                                <c:when test="${car.carStock > 0}">
                                    <span class="status-badge status-low-stock"><i class="fas fa-exclamation-circle"></i> Sắp hết hàng (${car.carStock} xe)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-out-of-stock"><i class="fas fa-times-circle"></i> Hết hàng</span>
                                </c:otherwise>
                            </c:choose>
                            
                            <div class="car-specs">
                                <div class="spec-item">
                                    <span class="spec-label">Năm sản xuất</span>
                                    <span class="spec-value">${car.carYear.getYear() + 1900}</span>
                                </div>
                                
                                <div class="spec-item">
                                    <span class="spec-label">Loại nhiên liệu</span>
                                    <span class="spec-value">
                                        <c:choose>
                                            <c:when test="${car.fuelType eq 'Gasoline'}">Xăng</c:when>
                                            <c:when test="${car.fuelType eq 'Diesel'}">Dầu diesel</c:when>
                                            <c:when test="${car.fuelType eq 'Electric'}">Điện</c:when>
                                            <c:when test="${car.fuelType eq 'Hybrid'}">Hybrid</c:when>
                                            <c:when test="${car.fuelType eq 'Plug-in Hybrid'}">Plug-in Hybrid</c:when>
                                            <c:otherwise>${car.fuelType}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="spec-item">
                                    <span class="spec-label">Số km đã đi</span>
                                    <span class="spec-value">
                                        <c:choose>
                                            <c:when test="${not empty car.carOdo}">
                                                <fmt:formatNumber value="${car.carOdo}" type="number" maxFractionDigits="1"/> miles
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="spec-item">
                                    <span class="spec-label">Dung tích động cơ</span>
                                    <span class="spec-value">
                                        <c:choose>
                                            <c:when test="${not empty car.displacement && car.fuelType ne 'Electric'}">
                                                <fmt:formatNumber value="${car.displacement}" type="number" maxFractionDigits="1"/>L
                                            </c:when>
                                            <c:otherwise>
                                                N/A
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="spec-item">
                                    <span class="spec-label">Phân loại</span>
                                    <span class="spec-value">
                                        <c:choose>
                                            <c:when test="${car.categoryId eq 1}">Sedan</c:when>
                                            <c:when test="${car.categoryId eq 2}">SUV</c:when>
                                            <c:when test="${car.categoryId eq 3}">Truck</c:when>
                                            <c:when test="${car.categoryId eq 4}">Sports Car</c:when>
                                            <c:when test="${car.categoryId eq 5}">Luxury</c:when>
                                            <c:otherwise>Unknown</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                
                                <div class="spec-item">
                                    <span class="spec-label">Mã xe</span>
                                    <span class="spec-value">#${car.carId}</span>
                                </div>
                            </div>
                            
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/admin/car/edit?id=${car.carId}" class="btn btn-primary">
                                    <i class="fas fa-edit"></i> Chỉnh sửa
                                </a>
                                <button type="button" class="btn btn-danger" onclick="confirmDelete('${car.carId}')">
                                    <i class="fas fa-trash"></i> Xóa xe
                                </button>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 20px; color: #777; font-size: 12px;">
            Copyright © 2025 DriverXO | Version 1.0.0
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        // Confirm delete function
        function confirmDelete(carId) {
            if (confirm("Bạn có chắc chắn muốn xóa xe này không? Hành động này không thể hoàn tác.")) {
                window.location.href = "${pageContext.request.contextPath}/admin/car/delete?id=" + carId;
            }
        }
    </script>
</body>
</html> 