<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<% if (request.getAttribute("services") == null) {
        response.sendRedirect(request.getContextPath() + "/services");
        return;
    }%>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Services Listing - DriverXO</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .page-title-section {
                background-color: #f8f9fa;
                padding: 30px 0;
            }
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.3s;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            }

            .service-img {
                width: 100%;
                height: 200px;
                object-fit: contain;
                background-color: #f8f9fa; /* Avoid white background if the image is small */
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                padding: 10px;
            }

            .filter-section {
                background-color: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/navbar.jsp" />

        <div class="container" style="padding-top: 100px">

            <!-- Search and Filter -->
            <div class="filter-section">
                <form class="row g-3" action="${pageContext.request.contextPath}/services/filter" method="get">
                    <div class="row g-3">
                        <div class="col-md-3">
                            <label class="form-label fw-bold">Search by Name</label>
                            <input type="text" name="keyword" value="${param.keyword}" class="form-control" placeholder="e.g., Oil Change">
                        </div>

                        <div class="col-md-2">
                            <label class="form-label fw-bold">Service Type</label>
                            <select name="serviceType" class="form-select">
                                <option value="">All Types</option>
                                <c:forEach var="type" items="${serviceTypes}">
                                    <option value="${type}" ${param.serviceType == type ? 'selected' : ''}>${type}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-2">
                            <label class="form-label fw-bold">Sort by Price</label>
                            <select name="sort" class="form-select">
                                <option value="">No Sort</option>
                                <option value="asc" ${param.sort == 'asc' ? 'selected' : ''}>Low to High</option>
                                <option value="desc" ${param.sort == 'desc' ? 'selected' : ''}>High to Low</option>
                            </select>
                        </div>

                        <div class="col-md-3 align-self-end">
                            <div class="d-flex gap-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-filter"></i> Apply
                                </button>
                                <a href="${pageContext.request.contextPath}/services" class="btn btn-secondary w-100">
                                    <i class="fas fa-undo"></i> Reset
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Services Grid -->
            <div class="row g-4">
                <c:forEach var="service" items="${services}">
                    <div class="col-md-4 col-lg-3">
                        <div class="card h-150">
                            <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" class="service-img" alt="${service.serviceName}">
                            <div class="card-body">
                                <h5 class="card-title">${service.serviceName}</h5>
                                <p class="card-text text-muted">${service.serviceType}</p>
                                <p class="card-text"><strong>$<c:out value="${service.servicePrice}" /></strong></p>
                                <p class="card-text"><i class="fas fa-clock"></i> Estimate Time: ${service.estimateTime}</p>
                            </div>
                            <div class="card-footer bg-transparent border-0 d-flex flex-column gap-2">
                                <a href="${pageContext.request.contextPath}/service/detail?id=${service.serviceId}" class="btn btn-outline-secondary w-100">
                                    <i class="fas fa-info-circle"></i> View Details
                                </a>
                                <button class="btn btn-primary w-100 add_to_cart" service-Id ='${service.serviceId}' type="button"> Add to Cart</button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty services}">
                    <div class="alert alert-warning text-center mt-4">No services found.</div>
                </c:if>
            </div>
        </div>

        <jsp:include page="/components/footer.jsp" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            window.addEventListener('scroll', function () {
                const header = document.querySelector('.header');
                const logoWhite = document.querySelector('.logo-white');
                const logoDark = document.querySelector('.logo-dark');

                if (window.scrollY > 50) {
                    header.classList.add('scrolled');
                    if (logoWhite)
                        logoWhite.style.display = 'none';
                    if (logoDark)
                        logoDark.style.display = 'block';
                } else {
                    header.classList.remove('scrolled');
                    if (logoWhite)
                        logoWhite.style.display = 'block';
                    if (logoDark)
                        logoDark.style.display = 'none';
                }
            });
        </script>
    </body>
</html>
