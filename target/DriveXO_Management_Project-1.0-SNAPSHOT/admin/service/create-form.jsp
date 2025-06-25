<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Service</title>
        <link rel="stylesheet" href="../../asset/css/style.css">
        <link rel="stylesheet" href="../../asset/css/adminstyle.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .card {
                max-width: 600px;
                margin: 30px auto;
                padding: 30px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                border-radius: 10px;
            }
            label {
                font-weight: bold;
            }
            input, select, textarea {
                width: 100%;
                padding: 10px 15px;
                border-radius: 8px;
                border: 1px solid #ccc;
                font-size: 16px;
            }
            .btn {
                padding: 10px 20px;
                border-radius: 8px;
            }
            .error {
                color: red;
                font-size: 14px;
                margin-top: 3px;
            }
        </style>
    </head>
    <body class="admin-panel">

        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="card">
                <h1>Create New Service</h1>

                <form action="${pageContext.request.contextPath}/admin/service/create" method="post" enctype="multipart/form-data">

                    <label>Name:</label>
                    <input type="text" name="serviceName" value="${oldService.serviceName}" />
                    <c:if test="${errors.serviceName != null}"><div class="error">${errors.serviceName}</div></c:if>

                    <label>Description:</label>
                    <textarea name="serviceDescription" rows="3">${oldService.serviceDescription}</textarea>
                    <c:if test="${errors.serviceDescription != null}"><div class="error">${errors.serviceDescription}</div></c:if>

                    <label>Price ($):</label>
                    <input type="number" name="servicePrice" step="0.01" value="${oldService.servicePrice}" />
                    <c:if test="${errors.servicePrice != null}"><div class="error">${errors.servicePrice}</div></c:if>

                    <label>Image (optional):</label>
                    <input type="file" name="serviceImg" onchange="previewImage(event)" />
                    <img id="imgPreview" style="display:none; width:200px; margin-top:10px; border-radius:10px;"/>

                    <label>Estimate Time:</label>
                    <input type="datetime-local" name="estimateTime" value="${fn:formatDate(oldService.estimateTime, 'yyyy-MM-dd\'T\'HH:mm')}" />
                    <c:if test="${errors.estimateTime != null}"><div class="error">${errors.estimateTime}</div></c:if>

                    <div style="text-align:center; margin-top:15px;">
                        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Create</button>
                        <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                    </div>
                </form>
            </div>

            <jsp:include page="/components/dashboardFooter.jsp" />
        </div>

        <script>
            function previewImage(event) {
                const reader = new FileReader();
                reader.onload = function () {
                    document.getElementById('imgPreview').src = reader.result;
                    document.getElementById('imgPreview').style.display = 'block';
                };
                reader.readAsDataURL(event.target.files[0]);
            }
        </script>
    </body>
</html>
