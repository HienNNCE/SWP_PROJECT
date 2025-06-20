<%-- 
    Document   : car-list
    Created on : May 18, 2025, 10:00:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DriverXO - Car Collection</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <!-- Google Fonts - Montserrat -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <!-- Ultra Modern Minimalist Car Listing Page -->
        <div class="car-listing-page">
            <!-- Nút back về trang home -->
            <a href="${pageContext.request.contextPath}/home" class="back-to-home">
                <i class="fas fa-home"></i>
            </a>
            
            <div class="container">
                <!-- Header Section -->
                <div class="car-listing-header-container">
                    <!-- Minimal Header - Centered -->
                    <header class="car-listing-header">
                        <h1 class="car-listing-title">The Collection</h1>
                        <p class="car-listing-subtitle">Curated selection of premium vehicles for the modern connoisseur</p>
                    </header>
                </div>
                    
                <!-- Filter Section - Optimized -->
                    <section class="car-filter-section">
                        <!-- Main Categories -->
                        <div class="filter-categories">
                            <div class="filter-tabs-container">
                            <div class="filter-tabs">
                                    <!-- Hiển thị nửa đầu tiên của danh sách category -->
                                    <c:set var="middleIndex" value="${categoryList.size() / 2}" />
                                    <c:forEach items="${categoryList}" var="cat" varStatus="status">
                                        <c:if test="${status.index < middleIndex}">
                                    <div class="filter-tab ${cat eq selectedCategory ? 'active' : ''}" data-category="${cat}" id="filter-tab-${status.index}">${cat}</div>
                                        </c:if>
                                </c:forEach>
                                    
                                    <!-- Hiển thị All ở giữa -->
                                <div class="filter-tab ${empty selectedCategory ? 'active' : ''}" data-category="all" id="filter-tab-all">
                                    <img src="${pageContext.request.contextPath}/asset/img/pngtree-car-steering-wheel-png-image_9996073.png" alt="All Categories" class="steering-wheel-icon">
                                </div>
                                    
                                    <!-- Hiển thị nửa còn lại của danh sách category -->
                                    <c:forEach items="${categoryList}" var="cat" varStatus="status">
                                        <c:if test="${status.index >= middleIndex}">
                                    <div class="filter-tab ${cat eq selectedCategory ? 'active' : ''}" data-category="${cat}" id="filter-tab-${status.index + middleIndex}">${cat}</div>
                                        </c:if>
                                </c:forEach>
                                </div>
                            </div>
                        </div>
                        
                    <!-- Advanced Filter Section - Compact Design -->
                        <div class="filter-section">
                        <div class="filter-section-title">
                            <span>Refine Selection</span>
                        </div>
                        
                        <!-- Brand Carousel -->
                        <div class="brand-carousel-container">
                            <div class="brand-nav prev" id="brandPrev">
                                <i class="fas fa-chevron-left"></i>
                            </div>
                            
                            <div class="brand-carousel" id="brandCarousel">
                                <div class="brand-list">
                                    <div class="brand-item ${empty selectedBrand ? 'selected' : ''}" data-brand="all">All Brands</div>
                                        <c:choose>
                                            <c:when test="${not empty brandList}">
                                                <c:forEach items="${brandList}" var="b">
                                                <div class="brand-item ${b eq selectedBrand ? 'selected' : ''}" data-brand="${b}">${b}</div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                            <div class="brand-item" data-brand="Toyota">Toyota</div>
                                            <div class="brand-item" data-brand="Honda">Honda</div>
                                            <div class="brand-item" data-brand="BMW">BMW</div>
                                            <div class="brand-item" data-brand="Mercedes-Benz">Mercedes</div>
                                            <div class="brand-item" data-brand="Audi">Audi</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                            <div class="brand-nav next" id="brandNext">
                                <i class="fas fa-chevron-right"></i>
                                    </div>
                                </div>
                                
                        <div class="filter-groups" id="filterGroups">
                            <!-- Filter Sliders Container -->
                            <div class="filter-sliders-container">
                                <!-- Year Picker -->
                                <div class="year-filter">
                                    <div class="year-picker-header">
                                        <span class="year-picker-title">Model Year</span>
                                        <span class="year-picker-selected" id="yearDisplayValue">${not empty selectedYear ? selectedYear : 'All'}</span>
                                    </div>
                                    <div class="year-picker">
                                        <div class="year-input" id="yearInput">${not empty selectedYear ? selectedYear : 'Select Year'}</div>
                                        <div class="year-dropdown" id="yearDropdown">
                                            <div class="year-option ${empty selectedYear ? 'selected' : ''}" data-year="all">All Years</div>
                                            <div class="year-option ${selectedYear == '2023' ? 'selected' : ''}" data-year="2023">2023</div>
                                            <div class="year-option ${selectedYear == '2022' ? 'selected' : ''}" data-year="2022">2022</div>
                                            <div class="year-option ${selectedYear == '2021' ? 'selected' : ''}" data-year="2021">2021</div>
                                            <div class="year-option ${selectedYear == '2020' ? 'selected' : ''}" data-year="2020">2020</div>
                                            <div class="year-option ${selectedYear == '2019' ? 'selected' : ''}" data-year="2019">2019</div>
                                            <div class="year-option ${selectedYear == '2018' ? 'selected' : ''}" data-year="2018">2018</div>
                                    </div>
                                </div>
                                
                                    <!-- Search Box -->
                                    <div class="search-filter">
                                      
                                        <div class="search-input-container">
                                            <i class="fas fa-search search-icon"></i>
                                            <input type="text" class="search-input" id="carSearchInput" placeholder="e.g. Camry, X5, A4..." value="${param.search}">
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Fuel Type Filter -->
                                <div class="fuel-filter">
                                    <div class="fuel-filter-header">
                                        <span class="fuel-filter-title">Fuel Type</span>
                                    </div>
                                    <div class="fuel-options">
                                        <div class="fuel-option ${selectedFuelType == 'Gasoline' ? 'selected' : ''}" data-fuel="Gasoline">
                                            <i class="fas fa-gas-pump"></i>Gasoline
                                        </div>
                                        <div class="fuel-option ${selectedFuelType == 'Diesel' ? 'selected' : ''}" data-fuel="Diesel">
                                            <i class="fas fa-oil-can"></i>Diesel
                                        </div>
                                        <div class="fuel-option ${selectedFuelType == 'Electric' ? 'selected' : ''}" data-fuel="Electric">
                                            <i class="fas fa-bolt"></i>Electric
                                        </div>
                                        <div class="fuel-option ${selectedFuelType == 'Hybrid' ? 'selected' : ''}" data-fuel="Hybrid">
                                            <i class="fas fa-leaf"></i>Hybrid
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Price Range Slider -->
                                <div class="range-sliders-row">
                                <div class="price-filter">
                                        <div class="filter-slider-header">
                                            <span class="filter-slider-title">Price Range</span>
                                            <span class="filter-slider-value" id="priceValue">$${not empty param.price ? param.price.split('-')[1] : '125,000'}</span>
                                        </div>
                                    <div class="price-range">
                                        <input type="range" class="price-range-slider" id="priceRange" min="25000" max="125000" step="5000" value="${not empty param.price ? param.price.split('-')[1] : 125000}">
                                        <div class="price-labels">
                                                <span>$25k</span>
                                                <span>$125k</span>
                                        </div>
                                        <input type="hidden" id="minPrice" name="min_price" value="${not empty param.price ? param.price.split('-')[0] : 25000}">
                                        <input type="hidden" id="maxPrice" name="max_price" value="${not empty param.price ? param.price.split('-')[1] : 125000}">
                                    </div>
                                </div>
                                
                                    <!-- ODO Range Slider -->
                                    <div class="odo-filter">
                                        <div class="filter-slider-header">
                                            <span class="filter-slider-title">Mileage (mi)</span>
                                            <span class="filter-slider-value" id="odoValue">${not empty param.odo ? param.odo.split('-')[1] : '100,000'}</span>
                                </div>
                                        <div class="odo-range">
                                            <input type="range" class="odo-range-slider" id="odoRange" min="0" max="100000" step="1000" value="${not empty param.odo ? param.odo.split('-')[1] : 100000}">
                                            <div class="odo-labels">
                                                <span>0</span>
                                                <span>100k</span>
                            </div>
                                            <input type="hidden" id="minOdo" name="min_odo" value="${not empty param.odo ? param.odo.split('-')[0] : 0}">
                                            <input type="hidden" id="maxOdo" name="max_odo" value="${not empty param.odo ? param.odo.split('-')[1] : 100000}">
                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
                        
                        <!-- Đã di chuyển nút filter lên toolbar -->
                    </div>
                </section>
                
                <!-- Car List Section -->
                <section class="cars-container">
                    <div class="cars-toolbar">
                        <div class="cars-count"><strong>${totalCars}</strong> vehicles</div>
                        <div class="cars-view-options">
                            <!-- Filter Actions -->
                            <div class="filter-actions" id="filterActions_toolbar">
                                <button type="button" class="filter-button" id="resetFilters_toolbar">Reset</button>
                                <button type="button" class="filter-button primary" id="applyFilters_toolbar">Apply Filters</button>
                            </div>
                            
                            <select class="sort-select" id="sortCars">
                                <option value="newest">Newest First</option>
                                <option value="oldest">Oldest First</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                            </select>
                            <button class="view-button active" id="gridView">
                                <i class="fas fa-th-large"></i>
                            </button>
                            <button class="view-button" id="listView">
                                <i class="fas fa-list"></i>
                            </button>
                          
                           
                        </div>
                    </div>
                    
                    <!-- Car Grid/List View -->
                    <c:choose>
                        <c:when test="${not empty carList}">
                            <div class="cars-grid" id="carsGrid">
                                <c:forEach var="car" items="${carList}">
                                    <div class="car-item">
                                        <div class="car-image">
                                            <span class="car-tag">New</span>
                                            <img src="${pageContext.request.contextPath}/asset/img/cars/${not empty car.carImg ? car.carImg : car.carBrand.toLowerCase().replaceAll(' ', '_').concat('_').concat(car.carName.toLowerCase().replaceAll(' ', '_')).concat('.webp')}" 
                                                 onerror="this.src='${pageContext.request.contextPath}/asset/img/cars/default-car.png'" 
                                                 alt="${car.carName}">
                                            <div class="car-actions">
                                                <button class="car-action" title="Favorite">
                                                    <i class="far fa-heart"></i>
                                                </button>
                                                <button class="car-action" title="Compare">
                                                    <i class="fas fa-exchange-alt"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="car-content">
                                            <div class="car-brand">${not empty car.carBrand ? car.carBrand : 'Brand not specified'}</div>
                                            <h3 class="car-name">${car.carYear.getYear() + 1900} ${car.carName}</h3>
                                            <div class="car-price">
                                                $<fmt:formatNumber value="${car.carPrice}" type="number" pattern="#,###,###" />
                                            </div>
                                            <div class="car-specs">
                                                <div class="car-spec">
                                                    <i class="fas fa-tachometer-alt spec-icon"></i>
                                                    <span class="spec-value">
                                                        <fmt:formatNumber value="${car.carOdo}" type="number" pattern="#,###" /> mi
                                                    </span>
                                                </div>
                                                <div class="car-spec">
                                                    <i class="fas fa-gas-pump spec-icon"></i>
                                                    <span class="spec-value">${car.fuelType}</span>
                                                </div>
                                                <div class="car-spec">
                                                    <i class="fas fa-cog spec-icon"></i>
                                                    <span class="spec-value">${car.displacement} L</span>
                                                </div>
                                            </div>
                                            <div class="car-footer">
                                                <a href="${pageContext.request.contextPath}/car/detail?id=${car.carId}" class="car-more">
                                                    Details
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            
                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="pagination">
                                    <div class="page-item">
                                        <a class="page-link ${currentPage == 1 ? 'disabled' : ''}" 
                                           href="${pageContext.request.contextPath}/car/list?page=${currentPage - 1}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty selectedFuelType ? '&fuel='.concat(selectedFuelType) : ''}">
                                            <i class="fas fa-angle-left"></i>
                                        </a>
                                    </div>
                                    
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <div class="page-item">
                                            <a class="page-link ${i == currentPage ? 'active' : ''}" 
                                               href="${pageContext.request.contextPath}/car/list?page=${i}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty selectedFuelType ? '&fuel='.concat(selectedFuelType) : ''}">
                                                ${i}
                                            </a>
                                        </div>
                                    </c:forEach>
                                    
                                    <div class="page-item">
                                        <a class="page-link ${currentPage == totalPages ? 'disabled' : ''}" 
                                           href="${pageContext.request.contextPath}/car/list?page=${currentPage + 1}${not empty selectedCategory ? '&category='.concat(selectedCategory) : ''}${not empty selectedBrand ? '&brand='.concat(selectedBrand) : ''}${not empty selectedFuelType ? '&fuel='.concat(selectedFuelType) : ''}">
                                            <i class="fas fa-angle-right"></i>
                                        </a>
                                    </div>
                                </div>
                            </c:if>
                        </c:when>
                        <c:otherwise>
                            <!-- No Cars Found -->
                            <div class="no-cars-found">
                                <i class="fas fa-car-alt no-cars-icon"></i>
                                <h3 class="no-cars-title">No Vehicles Found</h3>
                                <p class="no-cars-text">
                                    We couldn't find any vehicles matching your search criteria. 
                                    Please try with different parameters or browse our complete collection.
                                </p>
                                <a href="${pageContext.request.contextPath}/car/list" class="browse-all-btn">
                                    View All Vehicles
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>
            </div>
        </div>

        <!-- Thêm khoảng cách trước footer -->
        <div style="margin-bottom: 120px;"></div>
        
        <!-- Footer -->
        <jsp:include page="components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            // Định nghĩa context path để main.js sử dụng
            window.contextPath = "${pageContext.request.contextPath}";
            
            // Định nghĩa hàm khởi tạo để kiểm tra nếu main.js không tải được
            window.initCarListFunctions = function() {
                console.log("main.js đã được tải thành công");
            };
            
            // Thêm JavaScript trực tiếp để kiểm tra các phần tử
            document.addEventListener('DOMContentLoaded', function() {
                console.log("DOM đã được tải xong trong trang car-list.jsp");
                
                // Kiểm tra các phần tử filter-tab
                const filterTabs = document.querySelectorAll('.filter-tab');
                console.log("Số lượng filter-tab:", filterTabs.length);
                
                // Thêm sự kiện click trực tiếp vào các phần tử filter-tab
                filterTabs.forEach(function(tab) {
                    tab.addEventListener('click', function(e) {
                        console.log("Filter tab được click:", this.getAttribute('data-category'));
                        e.preventDefault();
                        
                        // Remove active class from all tabs
                        filterTabs.forEach(t => t.classList.remove('active'));
                        
                        // Add active class to clicked tab
                        this.classList.add('active');
                        
                        // Get category from clicked tab
                        const category = this.getAttribute('data-category');
                        // Thực hiện các hành động khác khi chọn category
                    });
                });
                
                // Kiểm tra các phần tử brand-item
                const brandItems = document.querySelectorAll('.brand-item');
                console.log("Số lượng brand-item:", brandItems.length);
                
                // Thêm sự kiện click trực tiếp vào các phần tử brand-item
                brandItems.forEach(function(item) {
                    item.addEventListener('click', function() {
                        console.log("Brand item được click:", this.getAttribute('data-brand'));
                        
                        // Remove selected class from all items
                        brandItems.forEach(brand => brand.classList.remove('selected'));
                        
                        // Add selected class to clicked item
                        this.classList.add('selected');
                        
                        // Get brand from clicked item
                        const brand = this.getAttribute('data-brand');
                        // Thực hiện các hành động khác khi chọn brand
                    });
                });
            });
        </script>
        <script src="${pageContext.request.contextPath}/asset/js/main.js"></script>
    </body>
</html> 