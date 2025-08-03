<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Service</title>
        <link rel="stylesheet" href="../../asset/css/style.css">
        <link rel="stylesheet" href="../../asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .card {
                max-width: 650px;
                margin: 30px auto;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 10px;
                background-color: #fff;
            }
            label {
                font-weight: bold;
                margin-top: 10px;
                display: block;
            }
            input, select, textarea {
                width: 100%;
                padding: 10px 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 16px;
                margin-top: 5px;
            }
            .btn {
                padding: 10px 20px;
                border-radius: 8px;
                font-size: 16px;
                margin: 5px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 5px;
                border: none;
                cursor: pointer;
            }
            .btn-primary {
                background-color: #007bff;
                color: #fff;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: #fff;
            }
            img {
                width: 150px;
                border-radius: 10px;
                margin-top: 10px;
            }
            .error {
                color: red;
                font-size: 14px;
                margin-top: 3px;
            }
            .button-area {
                text-align: center;
                margin-top: 20px;
            }
            .btn-info-custom {
                background-color: #17a2b8;
                color: white;
            }
            .btn-info-custom:hover {
                background-color: #138496;
            }

            .button-area a + a {
                margin-left: 10px;
            }

        </style>
    </head>
    <body class="admin-panel">

       <c:if test="${role == 1}">
        <jsp:include page="../../components/adminSidebar.jsp" />
    </c:if>
    <c:if test="${role == 4}">
        <jsp:include page="../../components/staffSidebar.jsp" />   
    </c:if>
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="card">
                <h1>Edit Service</h1>
                <c:if test="${not empty errors}">
                    <div class="alert alert-success">${errors}</div>
                </c:if>
                <form action="${pageContext.request.contextPath}/admin/service/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${service.serviceId}"/>

                    <label>Name:</label>

                    <input type="text" name="serviceName" value="${service.serviceName}" />
                    <c:if test="${errors.serviceName != null}"><div class="error">${errors.serviceName}</div></c:if>

                    <label>Description:</label>
                    <textarea name="serviceDescription" rows="3">${service.serviceDescription}</textarea>
                    <c:if test="${errors.serviceDescription != null}"><div class="error">${errors.serviceDescription}</div></c:if>

                    <label>Price ($):</label>
                    <input type="number" name="servicePrice" step="0.01" value="${service.servicePrice}" />
                    <c:if test="${errors.servicePrice != null}"><div class="error">${errors.servicePrice}</div></c:if>


                    <label>Service Type:</label>
                    <select name="serviceType">
                        <option value="">-- Select Type --</option>
                        <c:forEach var="type" items="${serviceTypes}">
                            <option value="${type}" ${type == service.serviceType ? 'selected' : ''}>${type}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${errors.serviceType != null}"><div class="error">${errors.serviceType}</div></c:if>

                    <label>Current Image:</label><br/>
                    <c:choose>
                        <c:when test="${not empty service.serviceImg}">
                            <img src="${pageContext.request.contextPath}/asset/img/services/${service.serviceImg}" alt="${service.serviceName}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/asset/img/services/default-service.png" alt="No Image">
                        </c:otherwise>
                    </c:choose>

                    <label>Change Image (optional):</label>

                    <input type="file" name="serviceImg" onchange="previewImage(event)"/>

                    <img id="imgPreview" style="display:none; width:200px; border-radius:10px;"/>

                    <label>Estimate Time:</label>
                    <input type="datetime-local" name="estimateTime" value="${estimateTimeStr}" />

                    
                    <c:if test="${errors.estimateTime != null}"><div class="error">${errors.estimateTime}</div></c:if>

                    <div class="button-area">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Save
                        </button>

                        <a href="${pageContext.request.contextPath}/admin/service/detail?id=${service.serviceId}" class="btn btn-info-custom">
                            <i class="fas fa-eye"></i> Back to Detail
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary">
                            <i class="fas fa-list"></i> Back to List
                        </a>
                    </div>
                </form>
            </div>
            <jsp:include page="/components/dashboardFooter.jsp" />
        </div>

        <script>
            function previewImage(event) {
                const reader = new FileReader();
                reader.onload = function () {
                    const img = document.getElementById('imgPreview');
                    img.src = reader.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </body>
</html>
