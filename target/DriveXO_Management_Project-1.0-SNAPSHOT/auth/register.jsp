<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - DriverXO</title>
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>
    <section class="auth-section">
        <img src="../asset/img/hero-car.png" alt="Hero Car" class="auth-hero-img">
        <form class="auth-card register" action="../home.jsp" method="get">
            <a href="../home.jsp" class="auth-home-btn" title="Back to Home"><i class="fas fa-home"></i></a>
            <div class="auth-logo-inline">
                <img src="../asset/img/driverxo-logo.png" alt="DriverXO Logo" class="auth-logo-img-inline">
                <span class="auth-logo-text-inline">DriverXO</span>
            </div>
            <h2>Create Your Account</h2>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-user"></i>
                    <input type="text" id="fullname" name="fullname" placeholder="Full Name" required>
                </div>
            </div>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-envelope"></i>
                    <input type="email" id="email" name="email" placeholder="Email" required>
                </div>
            </div>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-user-circle"></i>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </div>
            </div>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>
            </div>
            <div class="form-group">
                <div class="input-icon">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="confirm" name="confirm" placeholder="Confirm Password" required>
                </div>
            </div>
            <button type="submit" class="auth-btn">Register</button>
            <a href="login.jsp" class="auth-link">Already have an account? Login</a>
        </form>
    </section>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const heroImg = document.querySelector('.auth-hero-img');
            if(heroImg) {
                heroImg.style.transition = 'transform 1.2s cubic-bezier(.68,-0.55,.27,1.55)';
                heroImg.style.transform = 'scale(0.85)';
                setTimeout(()=>{ heroImg.style.transform = 'scale(1.08)'; }, 300);
            }
        });
    </script>
</body>
</html> 