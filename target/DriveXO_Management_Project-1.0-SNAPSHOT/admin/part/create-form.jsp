<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Part</title>
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
                <h1>Create New Part</h1>

                <form action="${pageContext.request.contextPath}/admin/part/create" method="post" enctype="multipart/form-data">

                    <label>Name:</label>
                    <input type="text" name="name" value="${oldPart.partName}" />
                    <c:if test="${errors.name != null}"><div class="error">${errors.name}</div></c:if>

                        <label>Brand:</label>
                        <select name="brand">
                            <option value="">-- Select Brand --</option>
                        <c:forEach var="b" items="${brands}">
                            <option value="${b}" ${b == oldPart.partBrand ? 'selected' : ''}>${b}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${errors.brand != null}"><div class="error">${errors.brand}</div></c:if>

                        <label>Car Model:</label>
                        <input type="text" name="carModel" value="${oldPart.carModel}" />
                    <c:if test="${errors.carModel != null}"><div class="error">${errors.carModel}</div></c:if>

                        <label>Description:</label>
                        <textarea name="description" rows="3">${oldPart.description}</textarea>

                    <label>Image (optional):</label>
                    <input type="file" name="img" onchange="previewImage(event)" />
                    <img id="imgPreview" style="display:none; width:200px; margin-top:10px; border-radius:10px;"/>

                    <label>Stock:</label>
                    <input type="number" name="stock" value="${oldPart.partStock}" />
                    <c:if test="${errors.stock != null}"><div class="error">${errors.stock}</div></c:if>

                        <label>Price ($):</label>
                        <input type="number" name="price" step="0.01" value="${oldPart.partPrice}" />
                    <c:if test="${errors.price != null}"><div class="error">${errors.price}</div></c:if>

                        <div style="text-align:center; margin-top:15px;">
                            <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Create</button>
                            <a href="${pageContext.request.contextPath}/admin/part" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
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
