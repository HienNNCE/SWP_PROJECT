<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty car ? 'Thêm xe mới' : 'Chỉnh sửa xe'} - DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        :root {
            --primary-color: #3498db;
            --primary-dark: #2980b9;
            --secondary-color: #e74c3c;
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
        
        .card-header {
            background-color: var(--light-gray);
            padding: 15px 20px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-title {
            margin: 0;
            font-size: 18px;
            font-weight: 600;
        }
        
        .card-body {
            padding: 25px;
        }
        
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
        
        .btn {
            padding: 10px 16px;
            border-radius: 4px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            font-size: 14px;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: #fff;
        }
        
        .btn-primary:hover {
            background-color: var(--primary-dark);
        }
        
        .btn-secondary {
            background-color: #f5f5f5;
            color: #333;
            border: 1px solid #ddd;
        }
        
        .btn-secondary:hover {
            background-color: #e5e5e5;
        }
        
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
        }
        
        .car-preview {
            max-width: 300px;
            max-height: 200px;
            margin-top: 10px;
            border-radius: 4px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            object-fit: cover;
        }
        
        .required-field::after {
            content: " *";
            color: var(--secondary-color);
        }
        
        .preview-container {
            margin-top: 10px;
            padding: 10px;
            background-color: var(--light-gray);
            border-radius: 4px;
            text-align: center;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 0;
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
            <h1>${empty car ? 'Thêm xe mới' : 'Chỉnh sửa xe #'.concat(car.carId)}</h1>
            <a href="${pageContext.request.contextPath}/admin/car" class="back-btn">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách
            </a>
        </div>

        <div class="card">
            <div class="card-body">
                <!-- Hiển thị thông báo lỗi/thành công nếu có -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success" style="background-color: #d4edda; color: #155724; padding: 15px; margin-bottom: 20px; border-radius: 4px; border: 1px solid #c3e6cb;">
                        ${sessionScope.successMessage}
                        <c:remove var="successMessage" scope="session" />
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger" style="background-color: #f8d7da; color: #721c24; padding: 15px; margin-bottom: 20px; border-radius: 4px; border: 1px solid #f5c6cb;">
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
                            <label for="carName" class="form-label required-field">Tên xe</label>
                            <input type="text" class="form-control" id="carName" name="carName" value="${car.carName}" required>
                        </div>
                        <div class="form-group">
                            <label for="carBrand" class="form-label required-field">Thương hiệu</label>
                            <select class="form-control" id="carBrand" name="carBrand" required>
                                <option value="">Chọn thương hiệu</option>
                                <c:forEach var="brand" items="${brandList}">
                                    <option value="${brand}" ${car.carBrand eq brand ? 'selected' : ''}>${brand}</option>
                                </c:forEach>
                                <option value="other">Thương hiệu khác</option>
                            </select>
                        </div>
                    </div>
                    
                    <div id="newBrandGroup" class="form-group" style="display: none;">
                        <label for="newBrand" class="form-label required-field">Tên thương hiệu mới</label>
                        <input type="text" class="form-control" id="newBrand" name="newBrand">
                        <div class="form-text">Nhập tên thương hiệu mới nếu không có trong danh sách trên.</div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="model" class="form-label required-field">Model</label>
                            <input type="text" class="form-control" id="model" name="model" value="${car.model}" required>
                        </div>
                        <div class="form-group">
                            <label for="carYear" class="form-label required-field">Năm sản xuất</label>
                            <input type="number" class="form-control" id="carYear" name="carYear" min="1900" max="2099" step="1" value="${empty car ? '' : car.carYear.getYear() + 1900}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="carPrice" class="form-label required-field">Giá ($)</label>
                            <input type="number" class="form-control" id="carPrice" name="carPrice" min="0" step="0.01" value="${car.carPrice}" required>
                        </div>
                        <div class="form-group">
                            <label for="carStock" class="form-label required-field">Số lượng</label>
                            <input type="number" class="form-control" id="carStock" name="carStock" min="0" value="${empty car ? '0' : car.carStock}" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="carOdo" class="form-label">Số km đã đi (miles)</label>
                            <input type="number" class="form-control" id="carOdo" name="carOdo" min="0" step="0.1" value="${car.carOdo}">
                        </div>
                        <div class="form-group">
                            <label for="fuelType" class="form-label required-field">Loại nhiên liệu</label>
                            <select class="form-control" id="fuelType" name="fuelType" required>
                                <option value="">Chọn loại nhiên liệu</option>
                                <option value="Gasoline" ${car.fuelType eq 'Gasoline' ? 'selected' : ''}>Xăng</option>
                                <option value="Diesel" ${car.fuelType eq 'Diesel' ? 'selected' : ''}>Dầu diesel</option>
                                <option value="Electric" ${car.fuelType eq 'Electric' ? 'selected' : ''}>Điện</option>
                                <option value="Hybrid" ${car.fuelType eq 'Hybrid' ? 'selected' : ''}>Hybrid</option>
                                <option value="Plug-in Hybrid" ${car.fuelType eq 'Plug-in Hybrid' ? 'selected' : ''}>Plug-in Hybrid</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="displacement" class="form-label">Dung tích động cơ (L)</label>
                            <input type="number" class="form-control" id="displacement" name="displacement" min="0" step="0.1" value="${car.displacement}">
                            <div class="form-text">Để trống đối với xe điện.</div>
                        </div>
                        <div class="form-group">
                            <label for="categoryId" class="form-label required-field">Phân loại</label>
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
                        <label for="carImg" class="form-label">Hình ảnh xe</label>
                        <input type="file" class="form-control" id="carImg" name="carImg" accept="image/*">
                        <input type="hidden" name="carImgText" value="${car.carImg}">
                        <div class="form-text">Chọn file ảnh để tải lên. Định dạng hỗ trợ: JPG, PNG, GIF. <strong>Kích thước tối đa: 10MB</strong>. Ảnh sẽ được tự động thu nhỏ nếu quá lớn.</div>
                        
                        <c:if test="${not empty car.carImg}">
                            <div class="preview-container">
                                <p>Ảnh hiện tại:</p>
                                <img src="${pageContext.request.contextPath}/asset/img/cars/${car.carImg}" alt="${car.carName}" class="car-preview">
                            </div>
                        </c:if>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/car'">Hủy</button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> ${empty car ? 'Thêm xe' : 'Cập nhật xe'}
                        </button>
                    </div>
                </form>
            </div>
        </div>
        
        <div style="text-align: center; margin-top: 20px; color: #777; font-size: 12px;">
            Copyright © 2025 DriverXO | Version 1.0.0
        </div>
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
        $(document).ready(function() {
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
                    alert('Vui lòng nhập tên xe');
                    isValid = false;
                }
                
                if ($('#carBrand').val() === '') {
                    alert('Vui lòng chọn thương hiệu');
                    isValid = false;
                }
                
                if ($('#carBrand').val() === 'other' && $('#newBrand').val().trim() === '') {
                    alert('Vui lòng nhập tên thương hiệu mới');
                    isValid = false;
                }
                
                // Kiểm tra kích thước file ảnh
                var fileInput = $('#carImg')[0];
                if (fileInput.files.length > 0) {
                    var fileSize = fileInput.files[0].size; // kích thước tính bằng bytes
                    var maxSize = 10 * 1024 * 1024; // 10MB
                    
                    if (fileSize > maxSize) {
                        alert('Kích thước ảnh quá lớn. Vui lòng chọn ảnh nhỏ hơn 10MB.');
                        isValid = false;
                    }
                    
                    // Kiểm tra định dạng file
                    var fileName = fileInput.files[0].name;
                    var fileExt = fileName.split('.').pop().toLowerCase();
                    var allowedExts = ['jpg', 'jpeg', 'png', 'gif'];
                    
                    if (!allowedExts.includes(fileExt)) {
                        alert('Định dạng file không được hỗ trợ. Vui lòng chọn file ảnh có định dạng: JPG, JPEG, PNG, GIF.');
                        isValid = false;
                    }
                }
                
                if (!isValid) {
                    e.preventDefault();
                } else {
                    // Hiển thị thông báo đang xử lý
                    if (fileInput.files.length > 0) {
                        $('button[type="submit"]').prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Đang xử lý...');
                    }
                }
            });
            
            // Hiển thị preview ảnh khi chọn file
            $('#carImg').on('change', function() {
                var fileInput = this;
                if (fileInput.files && fileInput.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        var previewContainer = $('.preview-container');
                        if (previewContainer.length === 0) {
                            $('<div class="preview-container"><p>Ảnh đã chọn:</p><img src="' + e.target.result + '" class="car-preview"></div>').insertAfter('#carImg');
                        } else {
                            previewContainer.html('<p>Ảnh đã chọn:</p><img src="' + e.target.result + '" class="car-preview">');
                        }
                    };
                    reader.readAsDataURL(fileInput.files[0]);
                }
            });
        });
    </script>
</body>
</html> 