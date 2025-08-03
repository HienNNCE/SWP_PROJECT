<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Appt Management - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="../asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
    .custom-select {
                width: 100%;
                padding: 10px 12px;
                border-radius: 12px;
                border: 1px solid #ccc;
                appearance: none;
                background-color: #f9f9f9;
                font-size: 16px;
                box-shadow: inset 0 1px 2px rgba(0,0,0,0.1);
                transition: border-color 0.3s, box-shadow 0.3s;
                outline: none;
                background-image: url("data:image/svg+xml;utf8,<svg fill='%23666' height='24' viewBox='0 0 24 24' width='24' xmlns='http://www.w3.org/2000/svg'><path d='M7 10l5 5 5-5z'/></svg>");
                background-repeat: no-repeat;
                background-position: right 10px center;
                background-size: 16px 16px;
            }

            .custom-select:focus {
                border-color: #4CAF50;
                box-shadow: 0 0 3px rgba(76, 175, 80, 0.5);
                background-color: #fff;
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: rgba(0, 0, 0, 0.5);
                display: flex;
                align-items: center;
                justify-content: center;
                z-index: 1000;
            }

            .modal-content {
                background: white;
                padding: 20px 30px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.2);
                width: 300px;
                position: relative;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 20px;
                cursor: pointer;
            }

            .btn-save {
                padding: 8px 16px;
                background-color: #4CAF50;
                border: none;
                border-radius: 8px;
                color: white;
                cursor: pointer;
            }

            .btn-save:hover {
                background-color: #45a049;
            }
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
        
        .empty-message {
            text-align: center;
            padding: 30px;
            color: #666;
            font-style: italic;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body class="admin-panel">
    <!-- Import Sidebar -->
    <c:if test="${role == 1}">
        <jsp:include page="../../components/adminSidebar.jsp" />
    </c:if>
    <c:if test="${role == 4}">
        <jsp:include page="../../components/staffSidebar.jsp" />   
    </c:if>

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
                            <h1 class="page-title">Services Appointment Management</h1>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid">
                <!-- Display success or error messages if any -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success">
                        ${sessionScope.successMessage}
                        <c:remove var="successMessage" scope="session" />
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger">
                        ${sessionScope.errorMessage}
                        <c:remove var="errorMessage" scope="session" />
                    </div>
                </c:if>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">Appointment List</h5>
                    </div>
                    <div class="card-body">
                        <!-- Filters -->
                        <div class="filters">
                            <div class="filter-group">
                                <label>Brand:</label>
                                <select id="brandFilter">
                                    <option value="">All Brands</option>
                                    <c:forEach var="brand" items="${brandList}">
                                        <option value="${brand}">${brand}</option>
                                    </c:forEach>
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
                                        <th>User Name</th>
                                        <th>User Phone</th>
                                        <th>User Email</th>
                                        <th>Service Name</th>
                                        <th>Car Infor</th>
                                        <th>Appointmet Time</th>
                                        <th>Note</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty serviceAppointments}">
                                        <tr>
                                            <td colspan="10" class="empty-message">No car data available. Add your first car!</td>
                                        </tr>
                                    </c:if>
                                    
                                    <c:forEach var="service" items="${serviceAppointments}">
                                        <tr>
                                            <td class="car-name">${service.getUser().getFullName()}</td>
                                            <td class="car-name">${service.getUser().getPhone()}</td>
                                            <td class="car-name">${service.getUser().getEmail()}</td>
                                            <td class="car-name">${service.getServiceName()}</td>                                         
                                            <td>${service.getCarInfo()}</td>
                                            <td>${service.getFormattedSaDate()}</td>
                                            <td>${service.getSaNote()}</td>
                                            <td>${service.getSaStatus()}</td>
                                            <td>
                                                <div class="actions">                                                
                                                    <button 
                                                        class="action-btn edit-btn edit-service-btn" 
                                                        data-id="${service.getServiceAppointmentId()}" 
                                                        data-status="${service.getSaStatus()}">
                                                        <i class="fas fa-edit"></i>
                                                    </button>

                                                    <button class="btn btn-sm btn-danger" onclick="confirmDelete('${service.getServiceAppointmentId()}')">
                                                        <i class="fas fa-ban"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            <div id="editServiceModal" class="modal-overlay" style="display: none;">
                                <div class="modal-content">
                                    <span class="close-btn">&times;</span>
                                    <form action="${pageContext.request.contextPath}/admin/serviceAppointment" method="post">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="serviceAppointmentId" id="modalServiceId">
                                        <label for="statusSelectService">Select Status:</label>
                                        <select name="status" id="statusSelectService" class="custom-select" required>
                                            <option value="Pending">Pending</option>
                                            <option value="Confirmed">Confirmed</option>
                                            <option value="Cancelled">Cancelled</option>
                                            <option value="Completed">Completed</option>
                                        </select>
                                        <br><br>
                                        <button type="submit" class="btn-save">Update</button>
                                    </form>
                                </div>
                            </div>
                            </table>
                            <!-- Edit Status Modal for Service Appointment -->

                        </div>
                        
                        <!-- Pagination - Sẽ triển khai sau khi có phân trang -->
                        <%-- <c:if test="${not empty carList && carList.size() > 10}">
                            <div class="pagination">
                                <a href="#" class="active">1</a>
                                <a href="#">2</a>
                                <a href="#">3</a>
                                <a href="#">&raquo;</a>
                            </div>
                        </c:if> --%>
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
            
            // Simple client-side filtering for search
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
                    $(".car-table tbody tr").hide();
                    $(".car-table tbody tr").filter(function() {
                        return $(this).children("td:nth-child(4)").text().toLowerCase() === value;
                    }).show();
                }
            });
            
            // Sorting functionality
            $("#sortBy").on("change", function() {
                var value = $(this).val();
                var rows = $(".car-table tbody tr").toArray();
                
                rows.sort(function(a, b) {
                    var aValue, bValue;
                    
                    switch(value) {
                        case "name":
                            aValue = $(a).children("td:nth-child(3)").text().toLowerCase();
                            bValue = $(b).children("td:nth-child(3)").text().toLowerCase();
                            return aValue.localeCompare(bValue);
                            
                        case "price_asc":
                            aValue = parseFloat($(a).children("td:nth-child(6)").text().replace('$', '').replace(',', ''));
                            bValue = parseFloat($(b).children("td:nth-child(6)").text().replace('$', '').replace(',', ''));
                            return aValue - bValue;
                            
                        case "price_desc":
                            aValue = parseFloat($(a).children("td:nth-child(6)").text().replace('$', '').replace(',', ''));
                            bValue = parseFloat($(b).children("td:nth-child(6)").text().replace('$', '').replace(',', ''));
                            return bValue - aValue;
                            
                        case "year":
                            aValue = parseInt($(a).children("td:nth-child(7)").text());
                            bValue = parseInt($(b).children("td:nth-child(7)").text());
                            return bValue - aValue; // Newest first
                            
                        default:
                            return 0;
                    }
                });
                
                $.each(rows, function(index, row) {
                    $(".car-table tbody").append(row);
                });
            });
        });
        
        // Confirm delete function
        function confirmDelete(saId) {
            if (confirm("Bạn có chắc chắn muốn xóa xe này không? Hành động này không thể hoàn tác.")) {
                window.location.href = "${pageContext.request.contextPath}/admin/serviceAppointment?action=delete&id=" + saId;
            }
        }
        // Bắt sự kiện click nút edit
            document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.edit-service-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
            e.preventDefault();
            const serviceId = this.dataset.id;
            const status = this.dataset.status;

            // Kiểm tra console
            console.log("ID:", serviceId);
            console.log("Status:", status);

            document.getElementById('modalServiceId').value = serviceId;
            document.getElementById('statusSelectService').value = status;
            document.getElementById('editServiceModal').style.display = 'flex';
        });
    });

    // Đóng modal
    document.querySelectorAll('.close-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            btn.closest('.modal-overlay').style.display = 'none';
        });
    });

    window.addEventListener('click', (e) => {
        const modal = document.getElementById('editServiceModal');
        if (e.target === modal) {
            modal.style.display = 'none';
        }
    });
});


    </script>
    
</body>
</html> 