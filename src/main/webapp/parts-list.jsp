<%@page contentType="text/html; charset=UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Parts Listing - DriverXO</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .card {
                border: none;
                border-radius: 15px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                transition: .3s;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.15);
            }
            .part-img {
                width: 100%;
                height: 200px;
                object-fit: contain;
                background: #f8f9fa;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                padding: 10px;
            }
            .filter-section {
                background: #f8f9fa;
                border-radius: 10px;
                padding: 20px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="/components/navbar.jsp"/>
        <div class="container" style="padding-top:100px">
            <div class="row">
                <div class="col-12 col-md-3">
                    <div class="filter-section">
                        <form action="${pageContext.request.contextPath}/parts" method="get">
                            <h6><strong>Car Model</strong></h6>
                            <c:forEach var="model" items="${carModels}">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="carModel" id="model-${model}" value="${model}" <c:if test="${param.carModel == model}">checked</c:if>>
                                    <label class="form-check-label" for="model-${model}">${model}</label>
                                </div>
                            </c:forEach>
                            <hr>
                            <h6><strong>Sort by Price</strong></h6>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="sort-asc" name="sort" value="asc" <c:if test="${param.sort == 'asc'}">checked</c:if>>
                                    <label class="form-check-label" for="sort-asc">Low to High</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" id="sort-desc" name="sort" value="desc" <c:if test="${param.sort == 'desc'}">checked</c:if>>
                                    <label class="form-check-label" for="sort-desc">High to Low</label>
                                </div>
                                <input type="hidden" name="brand" value="${param.brand}" />
                            <button class="btn btn-dark w-100 rounded-pill mt-3" type="submit">Apply Filters</button>
                        </form>
                    </div>
                </div>
                <div class="col-md-9">
                    <div class="row g-4">
                        <c:forEach var="part" items="${parts}">
                            <div class="col-md-4">
                                <div class="card h-100">
                                    <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" class="part-img" alt="${part.partName}">
                                    <div class="card-body">
                                        <h6 class="fw-semibold">${part.partName}</h6>
                                        <p class="text-muted small">${part.partBrand} • ${part.carModel}</p>
                                        <p class="fw-bold">$<c:out value="${part.partPrice}"/></p>
                                        <p class="small"><i class="fas fa-box"></i> Stock: ${part.partStock}</p>
                                    </div>
                                    <div class="card-footer bg-transparent border-0">
                                        <a href="${pageContext.request.contextPath}/part/detail?id=${part.partId}" class="btn btn-sm btn-outline-secondary w-100 mb-2">
                                            <i class="fas fa-info-circle"></i> Detail
                                        </a>
                                        <button type="button" part-id='${part.partId}' class="btn btn-primary w-100 add_to_cart"
                                                <c:if test="${part.partStock <= 0}">disabled</c:if>>
                                                    Add to Cart
                                                </button>
                                                </button>
                                        </div>
                                    </div>
                                </div>
                        </c:forEach>
                        <c:if test="${empty parts}">
                            <div class="alert alert-warning text-center">No parts found.</div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="/components/footer.jsp"/>
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