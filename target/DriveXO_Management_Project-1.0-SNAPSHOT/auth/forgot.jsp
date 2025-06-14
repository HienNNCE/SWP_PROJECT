<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - DriverXO</title>
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .reset-code-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-bottom: 18px;
        }
        .reset-code-input {
            width: 38px;
            height: 44px;
            font-size: 1.3rem;
            text-align: center;
            border: 1.5px solid var(--border-color);
            border-radius: 8px;
            outline: none;
            transition: border 0.2s;
        }
        .reset-code-input:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 2px rgba(7,46,176,0.08);
        }
        .reset-code-label {
            text-align: center;
            font-size: 1rem;
            color: var(--primary-color);
            margin-bottom: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <section class="auth-section">
        <img src="../asset/img/hero-car.png" alt="Hero Car" class="auth-hero-img">
        <form class="auth-card login" id="forgotForm" action="#" method="post" autocomplete="off" onsubmit="return false;">
            <a href="../home.jsp" class="auth-home-btn" title="Back to Home"><i class="fas fa-home"></i></a>
            <div class="auth-logo-inline">
                <img src="../asset/img/driverxo-logo.png" alt="DriverXO Logo" class="auth-logo-img-inline">
                <span class="auth-logo-text-inline">DriverXO</span>
            </div>
            <h2>Forgot Password</h2>
            <div id="emailSection">
                <div class="form-group">
                    <div class="input-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" placeholder="Enter your email" required>
                    </div>
                </div>
                <button type="button" class="auth-btn" id="sendCodeBtn">Send Reset Link</button>
                <a href="login.jsp" class="auth-link">Back to Login</a>
            </div>
            <div id="codeSection" style="display:none;">
                <div class="reset-code-label">Enter the 5-digit code sent to your email</div>
                <div class="reset-code-group">
                    <input type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                </div>
                <button type="submit" class="auth-btn">Verify Code</button>
            </div>
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

            // Hiện form nhập code khi nhấn gửi email
            document.getElementById('sendCodeBtn').onclick = function() {
                document.getElementById('emailSection').style.display = 'none';
                document.getElementById('codeSection').style.display = 'block';
                document.querySelector('.reset-code-input').focus();
            };

            // Tự động focus sang ô tiếp theo khi nhập số
            document.querySelectorAll('.reset-code-input').forEach((input, idx, arr) => {
                input.addEventListener('input', function(e) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                    if(this.value && idx < arr.length-1) arr[idx+1].focus();
                });
                input.addEventListener('keydown', function(e) {
                    if(e.key === 'Backspace' && !this.value && idx > 0) arr[idx-1].focus();
                });
            });
        });
    </script>
</body>
</html> 