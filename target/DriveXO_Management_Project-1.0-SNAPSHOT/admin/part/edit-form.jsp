<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Edit Part</title>
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

        <jsp:include page="/components/adminSidebar.jsp" />
        <div class="main-content">
            <jsp:include page="/components/dashboardHeader.jsp" />

            <div class="card">
                <h1>Edit Part</h1>

                <form action="${pageContext.request.contextPath}/admin/part/edit" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${part.partId}"/>

                    <label>Name:</label>
                    <input type="text" name="name" value="${part.partName}" />
                    <c:if test="${errors.name != null}"><div class="error">${errors.name}</div></c:if>

                        <label>Brand:</label>
                        <select name="brand">
                            <option value="">-- Select Brand --</option>
                        <c:forEach var="b" items="${brands}">
                            <option value="${b}" ${b == part.partBrand ? 'selected' : ''}>${b}</option>
                        </c:forEach>
                    </select>
                    <c:if test="${errors.brand != null}"><div class="error">${errors.brand}</div></c:if>

                        <label>Car Model:</label>
                        <input type="text" name="carModel" value="${part.carModel}" />
                    <c:if test="${errors.carModel != null}"><div class="error">${errors.carModel}</div></c:if>

                        <label>Description:</label>
                        <textarea name="description" rows="3">${part.description}</textarea>

                    <label>Current Image:</label><br/>
                    <c:choose>
                        <c:when test="${not empty part.partImg}">
                            <img src="${pageContext.request.contextPath}/asset/img/parts/${part.partImg}" alt="${part.partName}">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/asset/img/parts/default.png" alt="No Image">
                        </c:otherwise>
                    </c:choose>

                    <label>Change Image (optional):</label>
                    <input type="file" name="img" onchange="previewImage(event)"/>
                    <img id="imgPreview" style="display:none; width:200px; border-radius:10px;"/>

                    <label>Stock:</label>
                    <input type="number" name="stock" value="${part.partStock}" />
                    <c:if test="${errors.stock != null}"><div class="error">${errors.stock}</div></c:if>

                        <label>Price ($):</label>
                        <input type="number" name="price" step="0.01" value="${part.partPrice}" />
                    <c:if test="${errors.price != null}"><div class="error">${errors.price}</div></c:if>

                        <div class="button-area">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Save
                            </button>

                            <a href="${pageContext.request.contextPath}/admin/part/detail?id=${part.partId}" class="btn btn-info-custom">
                            <i class="fas fa-eye"></i> Back to Detail
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/part" class="btn btn-secondary">
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
