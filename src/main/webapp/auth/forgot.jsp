<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - DriverXO</title>
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
            margin-bottom: 0.5rem;
            color: #111;
        }
        
        .auth-subheading {
            font-size: 0.875rem;
            color: #555;
            margin-bottom: 1.5rem;
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
        
        /* Verification code inputs */
        .verification-code {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            justify-content: center;
        }
        
        .code-input {
            width: 3rem;
            height: 3rem;
            text-align: center;
            font-size: 1.25rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            transition: all 0.2s;
        }
        
        .code-input:focus {
            border-color: #111;
            outline: none;
            box-shadow: 0 0 0 2px rgba(0,0,0,0.05);
        }
        
        .code-label {
            text-align: center;
            margin-bottom: 1rem;
            font-size: 0.875rem;
            color: #555;
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
                <h2>Reset Password</h2>
                <p>We'll help you get back into your account in just a few steps.</p>
            </div>
        </div>
        
        <div class="auth-form-container">
            <div class="auth-form">
                <div class="auth-logo">
                    <img src="../asset/img/driverxo-logo.png" alt="DriverXO Logo">
                    <span>DriverXO</span>
                </div>
                
                <div id="emailSection">
                    <h1 class="auth-heading">Forgot your password?</h1>
                    <p class="auth-subheading">Enter your email address and we'll send you a code to reset your password.</p>
                    
                    <form id="forgotForm" onsubmit="return false;">
                        <div class="form-group">
                            <label class="form-label" for="email">Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        
                        <button type="button" id="sendCodeBtn" class="btn-auth">Send Reset Code</button>
                        
                        <div class="auth-footer">
                            <a href="login.jsp" class="auth-link">Back to Login</a>
                        </div>
                    </form>
                </div>
                
                <div id="codeSection" style="display:none;">
                    <h1 class="auth-heading">Enter verification code</h1>
                    <p class="auth-subheading">We've sent a 5-digit code to your email address.</p>
                    
                    <div class="code-label">Enter the code below:</div>
                    <div class="verification-code">
                        <input type="text" maxlength="1" class="code-input" inputmode="numeric" pattern="[0-9]*">
                        <input type="text" maxlength="1" class="code-input" inputmode="numeric" pattern="[0-9]*">
                        <input type="text" maxlength="1" class="code-input" inputmode="numeric" pattern="[0-9]*">
                        <input type="text" maxlength="1" class="code-input" inputmode="numeric" pattern="[0-9]*">
                        <input type="text" maxlength="1" class="code-input" inputmode="numeric" pattern="[0-9]*">
                    </div>
                    
                    <button type="button" class="btn-auth">Verify Code</button>
                    
                    <div class="auth-footer">
                        Didn't receive a code? <a href="#" class="auth-link" id="resendCodeBtn">Resend</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Switch to code verification section
            document.getElementById('sendCodeBtn').addEventListener('click', function() {
                document.getElementById('emailSection').style.display = 'none';
                document.getElementById('codeSection').style.display = 'block';
                document.querySelector('.code-input').focus();
            });
            
            // Handle code inputs
            const codeInputs = document.querySelectorAll('.code-input');
            codeInputs.forEach((input, index) => {
                // Only allow numbers
                input.addEventListener('input', function() {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    
                    // Auto focus next input
                    if (this.value && index < codeInputs.length - 1) {
                        codeInputs[index + 1].focus();
                    }
                });
                
                // Handle backspace
                input.addEventListener('keydown', function(e) {
                    if (e.key === 'Backspace' && !this.value && index > 0) {
                        codeInputs[index - 1].focus();
                    }
                });
            });
            
            // Handle resend code
            document.getElementById('resendCodeBtn').addEventListener('click', function(e) {
                e.preventDefault();
                alert('A new code has been sent to your email.');
            });
        });
    </script>
</body>
</html> 