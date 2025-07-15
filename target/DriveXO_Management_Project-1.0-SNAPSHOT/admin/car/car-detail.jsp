<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Details - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
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
            background-color: #f8f9fa;
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
        }
    </style>
</head>
<body class="admin-panel">
    <!-- Import Sidebar -->
    <jsp:include page="../../components/adminSidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Import Header -->
        <jsp:include page="../../components/dashboardHeader.jsp" />

        <!-- Content -->
        <div class="content">
            <!-- Content Header -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                            <h1 class="page-title">Car Details #${car.carId}</h1>
                        </div>
                        <div class="col">
                            <ol class="breadcrumb float-right">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/car">Cars</a></li>
                                <li class="breadcrumb-item active">Car Details</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Car Information</h5>
                        <div class="card-tools">
                            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/car'">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:if test="${empty car}">
                            <div class="alert alert-danger">Car not found or has been deleted.</div>
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
                                            <span class="status-badge status-in-stock"><i class="fas fa-check-circle"></i> In Stock (${car.carStock} units)</span>
                                        </c:when>
                                        <c:when test="${car.carStock > 0}">
                                            <span class="status-badge status-low-stock"><i class="fas fa-exclamation-circle"></i> Low Stock (${car.carStock} units)</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                    
                                    <div class="car-specs">
                                        <div class="spec-item">
                                            <span class="spec-label">Year</span>
                                            <span class="spec-value">${car.carYear.getYear() + 1900}</span>
                                        </div>
                                        
                                        <div class="spec-item">
                                            <span class="spec-label">Fuel Type</span>
                                            <span class="spec-value">${car.fuelType}</span>
                                        </div>
                                        
                                        <div class="spec-item">
                                            <span class="spec-label">Mileage</span>
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
                                            <span class="spec-label">Engine Displacement</span>
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
                                            <span class="spec-label">Category</span>
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
                                            <span class="spec-label">Car ID</span>
                                            <span class="spec-value">#${car.carId}</span>
                                        </div>
                                    </div>
                                    
                                    <div class="action-buttons">
                                        <a href="${pageContext.request.contextPath}/admin/car/edit?id=${car.carId}" class="btn btn-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <button type="button" class="btn btn-danger" onclick="confirmDelete('${car.carId}')">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

        <!-- Import Footer -->
        <jsp:include page="../../components/dashboardFooter.jsp" />
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function() {
            // Toggle Sidebar
            $('.sidebar-toggle').on('click', function() {
                $('.admin-panel').toggleClass('sidebar-mini');
            });

            // Dropdown Toggle
            $('.dropdown-toggle').on('click', function(e) {
                e.preventDefault();
                $(this).next('.dropdown-menu').toggleClass('show');
            });

            // Close dropdowns when clicking outside
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.dropdown').length) {
                    $('.dropdown-menu').removeClass('show');
                }
            });
        });
        
        // Confirm delete function
        function confirmDelete(carId) {
            if (confirm("Are you sure you want to delete this car? This action cannot be undone.")) {
                window.location.href = "${pageContext.request.contextPath}/admin/car/delete?id=" + carId;
            }
        }
    </script>
</body>
</html> 