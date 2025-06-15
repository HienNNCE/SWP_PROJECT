<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - DriveXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="auth-section">
        <div class="auth-card login">
            <a href="${pageContext.request.contextPath}/home" class="auth-home-btn"><i class="fas fa-home"></i></a>
            <div class="auth-logo-inline">
                <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo.png" alt="Logo" class="auth-logo-img-inline">
                <span class="auth-logo-text-inline">DriveXO</span>
            </div>
            <h2>Create new password</h2>
            
            <% if (request.getAttribute("err") != null) { %>
                <p style="color: red; text-align: center; margin-bottom: 15px;">${err}</p>
            <% } %>

            <form action="ResetPasswordServlet" method="post">
                <div class="form-group">
                    <div class="input-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="newPassword" placeholder="Enter new password" required>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" name="confirmPassword" placeholder="Confirm new password" required>
                    </div>
                </div>
                <button type="submit" class="auth-btn">Submit</button>
            </form>
        </div>
    </div>
</body>
</html>