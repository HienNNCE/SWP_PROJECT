<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Service Detail</title>
        <link rel="stylesheet" href="../../asset/css/style.css">
        <link rel="stylesheet" href="../../asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .detail-container {
                max-width: 800px;
                margin: 30px auto;
                background: #fff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                display: flex;
                align-items: center;
            }
            .image-box {
                flex: 1;
                text-align: center;
            }
            .image-box img {
                max-width: 100%;
                max-height: 300px;
                border-radius: 10px;
                box-shadow: 0 0 5px rgba(0,0,0,0.2);
            }
            .info-box {
                flex: 2;
                margin-left: 30px;
            }
            .info-box .detail-row {
                margin: 10px 0;
                font-size: 16px;
            }
            .btn-area {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin: 30px auto;
                max-width: 800px;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            .btn-area a {
                font-size: 16px;
                padding: 10px 20px;
                border-radius: 5px;
                text-decoration: none;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .btn-warning {
                background-color: #ffc107;
                color: black;
            }
            .btn-warning:hover,
            .btn-secondary:hover {
                opacity: 0.85;
            }
            .detail-row input,
            .detail-row textarea {
                width: 100%;
                padding: 8px 12px;
                margin-top: 5px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
        </style>
    </head>
    <body class="admin-panel">

        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="detail-container">
                <div class="image-box">
                    <c:if test="${not empty service.serviceImg}">
                        <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" alt="${service.serviceName}">
                    </c:if>
                    <c:if test="${empty service.serviceImg}">
                        <img src="${pageContext.request.contextPath}/asset/img/services/default-service.png" alt="No Image">
                    </c:if>
                </div>

                <div class="info-box">
                    <c:choose>
                        <c:when test="${isEditMode}">
                            <form action="${pageContext.request.contextPath}/admin/service/edit" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="${service.serviceId}" />
                                <h2>Edit Service</h2>

                                <div class="detail-row">
                                    <strong>Name:</strong>
                                    <input type="text" name="serviceName" value="${service.serviceName}" required />
                                </div>

                                <div class="detail-row">
                                    <strong>Description:</strong>
                                    <textarea name="serviceDescription">${service.serviceDescription}</textarea>
                                </div>

                                <div class="detail-row">
                                    <strong>Price ($):</strong>
                                    <input type="number" name="servicePrice" value="${service.servicePrice}" step="0.01" required />
                                </div>

                                <div class="detail-row">
                                    <strong>Estimate Time:</strong>
                                    <input type="datetime-local" name="estimateTime" value="${fn:formatDate(service.estimateTime, 'yyyy-MM-dd\'T\'HH:mm')}" />
                                </div>

                                <div class="detail-row">
                                    <strong>Image:</strong>
                                    <input type="file" name="serviceImg" />
                                    <small>Leave blank to keep current image</small>
                                </div>

                                <div class="btn-area">
                                    <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Back to List
                                    </a>
                                    <button type="submit" class="btn btn-warning">
                                        <i class="fas fa-save"></i> Save Changes
                                    </button>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <h2>Service Detail</h2>
                            <div class="detail-row"><strong>Name:</strong> ${service.serviceName}</div>
                            <div class="detail-row"><strong>Description:</strong> ${service.serviceDescription}</div>
                            <div class="detail-row"><strong>Price:</strong> $${service.servicePrice}</div>
                            <div class="detail-row"><strong>Estimate Time:</strong> ${fn:formatDate(service.estimateTime, 'yyyy-MM-dd HH:mm')}</div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="btn-area">
                <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
                <a href="${pageContext.request.contextPath}/admin/service/edit?id=${service.serviceId}" class="btn btn-warning">
                    <i class="fas fa-edit"></i> Edit Service
                </a>
            </div>
            
            <jsp:include page="/components/dashboardFooter.jsp" />
        </div>
    </body>
</html>
