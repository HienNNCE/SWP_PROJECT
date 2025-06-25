<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty car ? 'Add New Car' : 'Edit Car'} - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #555;
        }
        
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 14px;
            transition: border-color 0.2s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .form-text {
            margin-top: 5px;
            font-size: 12px;
            color: #777;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 0;
        }
        
        .form-row .form-group {
            flex: 1;
        }
        
        .required-field::after {
            content: " *";
            color: #e74c3c;
        }
        
        .preview-container {
            margin-top: 10px;
            padding: 10px;
            background-color: #f8f9fa;
            border-radius: 4px;
            text-align: center;
        }
        
        .car-preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
            border-radius: 4px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            object-fit: cover;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
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
                            <h1 class="page-title">${empty car ? 'Add New Car' : 'Edit Car #'.concat(car.carId)}</h1>
                        </div>
                        <div class="col">
                            <ol class="breadcrumb float-right">
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/car">Cars</a></li>
                                <li class="breadcrumb-item active">${empty car ? 'Add New Car' : 'Edit Car'}</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title">${empty car ? 'Add New Car' : 'Edit Car Details'}</h5>
                        <div class="card-tools">
                            <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/car'">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
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
                        
                        <form action="${empty car ? pageContext.request.contextPath.concat('/admin/car/add') : pageContext.request.contextPath.concat('/admin/car/edit')}" method="post" enctype="multipart/form-data">
                            <c:if test="${not empty car}">
                                <input type="hidden" name="carId" value="${car.carId}">
                            </c:if>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="carName" class="form-label required-field">Car Name</label>
                                    <input type="text" class="form-control" id="carName" name="carName" value="${car.carName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="carBrand" class="form-label required-field">Brand</label>
                                    <select class="form-control" id="carBrand" name="carBrand" required>
                                        <option value="">Select Brand</option>
                                        <c:forEach var="brand" items="${brandList}">
                                            <option value="${brand}" ${car.carBrand eq brand ? 'selected' : ''}>${brand}</option>
                                        </c:forEach>
                                        <option value="other">Other Brand</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div id="newBrandGroup" class="form-group" style="display: none;">
                                <label for="newBrand" class="form-label required-field">New Brand Name</label>
                                <input type="text" class="form-control" id="newBrand" name="newBrand">
                                <div class="form-text">Enter new brand name if not found in the list above.</div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="model" class="form-label required-field">Model</label>
                                    <input type="text" class="form-control" id="model" name="model" value="${car.model}" required>
                                </div>
                                <div class="form-group">
                                    <label for="carYear" class="form-label required-field">Year</label>
                                    <input type="number" class="form-control" id="carYear" name="carYear" min="1900" max="2099" step="1" value="${empty car ? '' : car.carYear.getYear() + 1900}" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="carPrice" class="form-label required-field">Price ($)</label>
                                    <input type="number" class="form-control" id="carPrice" name="carPrice" min="0" step="0.01" value="${car.carPrice}" required>
                                </div>
                                <div class="form-group">
                                    <label for="carStock" class="form-label required-field">Stock</label>
                                    <input type="number" class="form-control" id="carStock" name="carStock" min="0" value="${empty car ? '0' : car.carStock}" required>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="carOdo" class="form-label">Mileage (miles)</label>
                                    <input type="number" class="form-control" id="carOdo" name="carOdo" min="0" step="0.1" value="${car.carOdo}">
                                </div>
                                <div class="form-group">
                                    <label for="fuelType" class="form-label required-field">Fuel Type</label>
                                    <select class="form-control" id="fuelType" name="fuelType" required>
                                        <option value="">Select Fuel Type</option>
                                        <option value="Gasoline" ${car.fuelType eq 'Gasoline' ? 'selected' : ''}>Gasoline</option>
                                        <option value="Diesel" ${car.fuelType eq 'Diesel' ? 'selected' : ''}>Diesel</option>
                                        <option value="Electric" ${car.fuelType eq 'Electric' ? 'selected' : ''}>Electric</option>
                                        <option value="Hybrid" ${car.fuelType eq 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                                        <option value="Plug-in Hybrid" ${car.fuelType eq 'Plug-in Hybrid' ? 'selected' : ''}>Plug-in Hybrid</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="displacement" class="form-label">Engine Displacement (L)</label>
                                    <input type="number" class="form-control" id="displacement" name="displacement" min="0" step="0.1" value="${car.displacement}">
                                    <div class="form-text">Leave empty for electric vehicles.</div>
                                </div>
                                <div class="form-group">
                                    <label for="categoryId" class="form-label required-field">Category</label>
                                    <select class="form-control" id="categoryId" name="categoryId" required>
                                        <option value="1" ${car.categoryId eq 1 ? 'selected' : ''}>Sedan</option>
                                        <option value="2" ${car.categoryId eq 2 ? 'selected' : ''}>SUV</option>
                                        <option value="3" ${car.categoryId eq 3 ? 'selected' : ''}>Truck</option>
                                        <option value="4" ${car.categoryId eq 4 ? 'selected' : ''}>Sports Car</option>
                                        <option value="5" ${car.categoryId eq 5 ? 'selected' : ''}>Luxury</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="carImg" class="form-label">Car Image</label>
                                <input type="file" class="form-control" id="carImg" name="carImg" accept="image/*">
                                <input type="hidden" name="carImgText" value="${car.carImg}">
                                <div class="form-text">Select an image file to upload. Supported formats: JPG, PNG, GIF. <strong>Max size: 10MB</strong>. Images will be automatically resized if too large.</div>
                                
                                <c:if test="${not empty car.carImg}">
                                    <div class="preview-container">
                                        <p>Current image:</p>
                                        <img src="${pageContext.request.contextPath}/asset/img/cars/${car.carImg}" alt="${car.carName}" class="car-preview">
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="card-footer">
                                <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/car'">Cancel</button>
                                <button type="submit" class="btn btn-primary float-right">
                                    <i class="fas fa-save"></i> ${empty car ? 'Add Car' : 'Update Car'}
                                </button>
                            </div>
                        </form>
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
            
            // Show/hide new brand input based on selection
            $('#carBrand').on('change', function() {
                if ($(this).val() === 'other') {
                    $('#newBrandGroup').show();
                    $('#newBrand').prop('required', true);
                } else {
                    $('#newBrandGroup').hide();
                    $('#newBrand').prop('required', false);
                }
            });
            
            // Handle fuel type change
            $('#fuelType').on('change', function() {
                if ($(this).val() === 'Electric') {
                    $('#displacement').val('');
                    $('#displacement').prop('disabled', true);
                } else {
                    $('#displacement').prop('disabled', false);
                }
            });
            
            // Initialize fuel type change if Electric is selected
            if ($('#fuelType').val() === 'Electric') {
                $('#displacement').val('');
                $('#displacement').prop('disabled', true);
            }
            
            // Form validation
            $('form').on('submit', function(e) {
                var isValid = true;
                
                // Basic validation
                if ($('#carName').val().trim() === '') {
                    alert('Please enter car name');
                    isValid = false;
                }
                
                if ($('#carBrand').val() === '') {
                    alert('Please select a brand');
                    isValid = false;
                }
                
                if ($('#carBrand').val() === 'other' && $('#newBrand').val().trim() === '') {
                    alert('Please enter new brand name');
                    isValid = false;
                }
                
                // Check image file size
                var fileInput = $('#carImg')[0];
                if (fileInput.files.length > 0) {
                    var fileSize = fileInput.files[0].size; // size in bytes
                    var maxSize = 10 * 1024 * 1024; // 10MB
                    
                    if (fileSize > maxSize) {
                        alert('Image size is too large. Please select an image smaller than 10MB.');
                        isValid = false;
                    }
                    
                    // Check file format
                    var fileName = fileInput.files[0].name;
                    var fileExt = fileName.split('.').pop().toLowerCase();
                    var allowedExts = ['jpg', 'jpeg', 'png', 'gif'];
                    
                    if (!allowedExts.includes(fileExt)) {
                        alert('Unsupported file format. Please select an image file with format: JPG, JPEG, PNG, GIF.');
                        isValid = false;
                    }
                }
                
                if (!isValid) {
                    e.preventDefault();
                } else {
                    // Show processing message
                    if (fileInput.files.length > 0) {
                        $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Processing...');
                    }
                }
            });
            
            // Image preview when selecting a file
            $('#carImg').on('change', function() {
                var fileInput = this;
                if (fileInput.files && fileInput.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var previewContainer = $('.preview-container');
                        if (previewContainer.length === 0) {
                            $('<div class="preview-container"><p>Selected image:</p><img src="' + e.target.result + '" class="car-preview"></div>').insertAfter('#carImg');
                        } else {
                            previewContainer.html('<p>Selected image:</p><img src="' + e.target.result + '" class="car-preview">');
                        }
                    };
                    reader.readAsDataURL(fileInput.files[0]);
                }
            });
        });
    </script>
</body>
</html> 