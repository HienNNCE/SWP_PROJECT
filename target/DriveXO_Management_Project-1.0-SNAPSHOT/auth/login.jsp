<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - DriverXO</title>
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .auth-container {
            display: flex;
            min-height: 100vh;
            background-color: #f9f9f9;
        }
        
        .auth-image {
            flex: 1;
            background: linear-gradient(rgba(0, 0, 0, 0.65), rgba(0, 0, 0, 0.6)), url('../asset/img/sidelog.jpg');
            background-size: cover;
            background-position: center;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }
        
        .auth-image-content {
            text-align: center;
            max-width: 80%;
        }
        
        .auth-image-content h2 {
            font-size: 2.5rem;
            font-weight: 300;
            margin-bottom: 1rem;
            letter-spacing: 1px;
        }
        
        .auth-image-content p {
            font-size: 1rem;
            font-weight: 300;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .auth-form-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .auth-form {
            width: 100%;
            max-width: 400px;
        }
        
        .auth-logo {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
        }
        
        .auth-logo img {
            height: 28px;
            margin-right: 10px;
        }
        
        .auth-logo span {
            font-size: 20px;
            font-weight: 500;
            letter-spacing: 1px;
        }
        
        .auth-heading {
            font-size: 1.5rem;
            font-weight: 500;
            margin-bottom: 1.5rem;
            color: #111;
        }
        
        .form-group {
            margin-bottom: 1.2rem;
        }
        
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
            color: #555;
        }
        
        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            font-size: 0.875rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.2s;
            background-color: #fff;
        }
        
        .form-control:focus {
            border-color: #111;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,0,0,0.05);
        }
        
        .form-check {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }
        
        .form-check-label {
            font-size: 0.875rem;
            color: #555;
            display: flex;
            align-items: center;
        }
        
        .form-check-input {
            margin-right: 0.5rem;
        }
        
        .forgot-link {
            font-size: 0.875rem;
            color: #555;
            text-decoration: none;
            transition: color 0.2s;
        }
        
        .forgot-link:hover {
            color: #111;
        }
        
        .btn-auth {
            display: block;
            width: 100%;
            padding: 0.875rem;
            background-color: #111;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 0.875rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .btn-auth:hover {
            background-color: #000;
        }
        
        .auth-footer {
            text-align: center;
            font-size: 0.875rem;
            color: #555;
        }
        
        .auth-link {
            color: #111;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s;
        }
        
        .auth-link:hover {
            text-decoration: underline;
        }
        
        .home-link {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            color: #fff;
            font-size: 1.2rem;
            transition: opacity 0.2s;
        }
        
        .home-link:hover {
            opacity: 0.8;
        }
        
        @media (max-width: 992px) {
            .auth-image {
                display: none;
            }
            
            .auth-form-container {
                flex: 1;
            }
        }
    </style>
</head>
<body>
    <div class="auth-container">
        <div class="auth-image">
            <a href="../home" class="home-link">
                <i class="fas fa-arrow-left"></i>
            </a>
            <div class="auth-image-content">
                <h2>Welcome to DriverXO</h2>
                <p>Experience luxury driving with our premium collection of high-performance vehicles tailored to your lifestyle.</p>
            </div>
        </div>
        
        <div class="auth-form-container">
            <div class="auth-form">
                <div class="auth-logo">
                    <img src="../asset/img/driverxo-logo.png" alt="DriverXO Logo">
                    <span>DriverXO</span>
                </div>
                
                <h1 class="auth-heading">Sign in to your account</h1>
                
                <form action="../home" method="get">
                    <div class="form-group">
                        <label class="form-label" for="username">Username or Email</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="password">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    
                    <div class="form-check">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" name="remember">
                            Remember me
                        </label>
                        <a href="forgot.jsp" class="forgot-link">Forgot password?</a>
                    </div>
                    
                    <button type="submit" class="btn-auth">Sign In</button>
                    
                    <div class="auth-footer">
                        Don't have an account? <a href="register.jsp" class="auth-link">Create an account</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>