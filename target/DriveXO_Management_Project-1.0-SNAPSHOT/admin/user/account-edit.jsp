<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User</title>
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
        input, select {
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
        <h1>Edit User</h1>
        <c:if test="${error != null}">
            <div class="error">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/users/edit" method="post">
            <input type="hidden" name="userId" value="${user.userId}" />

            <label>Username:</label>
            <input type="text" name="userName" value="${user.userName}" required />

            <label>Email:</label>
            <input type="email" name="email" value="${user.email}" required />

            <label>Password</label>
            <input type="password" name="password" value="${user.password}" />

            <label>Phone:</label>
            <input type="text" name="phone" value="${user.phone}" required />

            <label>Address:</label>
            <input type="text" name="address" value="${user.address}" required />

            <label>Role:</label>
            <select name="roleId" required>
                <option value="">-- Select Role --</option>
                <option value="1" ${user.roleId == 1 ? 'selected' : ''}>Admin</option>
                <option value="2" ${user.roleId == 2 ? 'selected' : ''}>Customer</option>
                
                <option value="4" ${user.roleId == 4 ? 'selected' : ''}>Staff</option>
            </select>

            <div style="text-align:center; margin-top:15px;">
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update</button>
                <button type="button" class="btn btn-secondary" onclick="location.href='${pageContext.request.contextPath}/admin/users'">Cancel</button>
            </div>
        </form>
    </div>

    <jsp:include page="/components/dashboardFooter.jsp" />
</div>
</body>
</html>
