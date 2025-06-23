<%-- 
    Document   : car-list-ajax
    Created on : Jun 20, 2023, 10:00:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Cars Grid/List View - AJAX Response -->
<c:choose>
    <c:when test="${not empty carList}">
        <div id="carsGrid" class="cars-grid">
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
            <h3 class="no-cars-title">Không tìm thấy xe nào</h3>
            <p class="no-cars-text">
                Không tìm thấy xe nào phù hợp với tiêu chí tìm kiếm của bạn.
                Vui lòng thử lại với các tiêu chí khác hoặc xem toàn bộ danh sách xe.
            </p>
            <a href="${pageContext.request.contextPath}/car/list" class="browse-all-btn">
                Xem tất cả xe
            </a>
        </div>
    </c:otherwise>
</c:choose>

<!-- Cars Count for AJAX response -->
<div class="cars-count" style="display:none;"><strong>${totalCars}</strong> vehicles</div> 