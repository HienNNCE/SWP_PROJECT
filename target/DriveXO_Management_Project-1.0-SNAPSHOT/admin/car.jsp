<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Car Management - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="../asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .car-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .car-table th, 
        .car-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        .car-table th {
            background-color: #f8f9fa;
            color: #333;
            font-weight: 600;
        }
        
        .car-table tbody tr:hover {
            background-color: #f5f5f5;
        }
        
        .car-table .car-img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            background-color: #eee;
        }
        
        .car-table .car-name {
            font-weight: 600;
        }
        
        .car-table .car-price {
            font-weight: 600;
            color: var(--primary-color);
        }
        
        .status-badge {
            padding: 4px 8px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 500;
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
        
        .actions {
            display: flex;
            gap: 8px;
        }
        
        .action-btn {
            padding: 5px 8px;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            transition: background-color 0.3s;
        }
        
        .view-btn {
            background-color: #f8f9fa;
            color: #0d6efd;
            border: 1px solid #dee2e6;
        }
        
        .edit-btn {
            background-color: #fff7e0;
            color: #ffc107;
            border: 1px solid #ffe69c;
        }
        
        .delete-btn {
            background-color: #ffe0e0;
            color: #dc3545;
            border: 1px solid #f5c2c7;
        }
        
        .view-btn:hover {
            background-color: #e9ecef;
        }
        
        .edit-btn:hover {
            background-color: #ffecb5;
        }
        
        .delete-btn:hover {
            background-color: #f8d7da;
        }
        
        .filters {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            align-items: center;
            flex-wrap: wrap;
        }
        
        .filter-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .filter-group select,
        .filter-group input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-box {
            flex-grow: 1;
            max-width: 300px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 8px 12px 8px 36px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
        }
        
        .pagination {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
        
        .pagination a {
            padding: 8px 12px;
            margin: 0 4px;
            border: 1px solid #ddd;
            border-radius: 4px;
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .pagination a:hover {
            background-color: #f5f5f5;
        }
        
        .pagination a.active {
            background-color: var(--primary-color);
            color: white;
            border-color: var(--primary-color);
        }
    </style>
</head>
<body class="admin-panel">
    <!-- Import Sidebar -->
    <jsp:include page="../components/adminSidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Import Header -->
        <jsp:include page="../components/dashboardHeader.jsp" />

        <!-- Content -->
        <div class="content">
            <!-- Content Header -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col">
                            <h1 class="page-title">Car Management</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Car List</h5>
                        <div class="card-tools">
                            <button type="button" class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/admin/car/add'">
                                <i class="fas fa-plus"></i> Add New Car
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <!-- Filters -->
                        <div class="filters">
                            <div class="filter-group">
                                <label>Brand:</label>
                                <select id="brandFilter">
                                    <option value="">All</option>
                                    <option value="Toyota">Toyota</option>
                                    <option value="Honda">Honda</option>
                                    <option value="BMW">BMW</option>
                                    <option value="Mercedes">Mercedes</option>
                                    <option value="Audi">Audi</option>
                                </select>
                            </div>
                            <div class="filter-group">
                                <label>Sort by:</label>
                                <select id="sortBy">
                                    <option value="name">Name</option>
                                    <option value="price_asc">Price (Low - High)</option>
                                    <option value="price_desc">Price (High - Low)</option>
                                    <option value="year">Year</option>
                                </select>
                            </div>
                            <div class="search-box">
                                <i class="fas fa-search"></i>
                                <input type="text" id="searchInput" placeholder="Search cars...">
                            </div>
                        </div>
                        
                        <!-- Cars Table -->
                        <div class="table-responsive">
                            <table class="car-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Brand</th>
                                        <th>Model</th>
                                        <th>Price ($)</th>
                                        <th>Year</th>
                                        <th>Stock</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty carList}">
                                        <tr>
                                            <td colspan="10" style="text-align: center;">No car data available</td>
                                        </tr>
                                    </c:if>
                                    
                                    <c:forEach var="car" items="${carList}">
                                        <tr>
                                            <td>${car.carId}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty car.carImg}">
                                                        <img src="data:image/jpeg;base64,${car.base64Image}" alt="${car.carName}" class="car-img">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="../asset/img/cars/default-car.png" alt="Default Car" class="car-img">
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="car-name">${car.carName}</td>
                                            <td>${car.carBrand}</td>
                                            <td>${car.model}</td>
                                            <td class="car-price">
                                                $<fmt:formatNumber value="${car.carPrice}" type="number" maxFractionDigits="2" minFractionDigits="2"/>
                                            </td>
                                            <td>${car.year}</td>
                                            <td>${car.carStock}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${car.carStock > 5}">
                                                        <span class="status-badge status-in-stock">In Stock</span>
                                                    </c:when>
                                                    <c:when test="${car.carStock > 0}">
                                                        <span class="status-badge status-low-stock">Low Stock</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-out-of-stock">Out of Stock</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="actions">
                                                    <button class="action-btn view-btn" onclick="location.href='${pageContext.request.contextPath}/admin/car/view?id=${car.carId}'">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button class="action-btn edit-btn" onclick="location.href='${pageContext.request.contextPath}/admin/car/edit?id=${car.carId}'">
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button class="action-btn delete-btn" onclick="confirmDelete('${car.carId}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Pagination -->
                        <div class="pagination">
                            <a href="#" class="active">1</a>
                            <a href="#">2</a>
                            <a href="#">3</a>
                            <a href="#">&raquo;</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Import Footer -->
        <jsp:include page="../components/dashboardFooter.jsp" />
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
            
            // Simple client-side filtering
            $("#searchInput").on("keyup", function() {
                var value = $(this).val().toLowerCase();
                $(".car-table tbody tr").filter(function() {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                });
            });
            
            // Brand filtering
            $("#brandFilter").on("change", function() {
                var value = $(this).val().toLowerCase();
                if (value === "") {
                    $(".car-table tbody tr").show();
                } else {
                    $(".car-table tbody tr").filter(function() {
                        return $(this).children("td:nth-child(4)").text().toLowerCase() === value;
                    }).show();
                    $(".car-table tbody tr").filter(function() {
                        return $(this).children("td:nth-child(4)").text().toLowerCase() !== value;
                    }).hide();
                }
            });
        });
        
        // Confirm delete function
        function confirmDelete(carId) {
            if (confirm("Are you sure you want to delete this car?")) {
                window.location.href = "${pageContext.request.contextPath}/admin/car/delete?id=" + carId;
            }
        }
    </script>
</body>
</html> 