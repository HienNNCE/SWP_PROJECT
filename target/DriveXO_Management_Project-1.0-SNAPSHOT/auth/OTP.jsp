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
        <form class="auth-card login" id="forgotForm" action="OTPServlet" method="post" autocomplete="off" >
            <a href="../home.jsp" class="auth-home-btn" title="Back to Home"><i class="fas fa-home"></i></a>
            
            <div id="codeSection">
                <div class="reset-code-label">Enter the 5-digit code sent to your email</div>
                <div class="reset-code-group">
                    <input name="otp1" type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input name="otp2" type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input name="otp3" type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input name="otp4" type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                    <input name="otp5" type="text" maxlength="1" class="reset-code-input" inputmode="numeric" pattern="[0-9]*" autocomplete="one-time-code">
                </div>
                <button type="submit" class="auth-btn">Verify Code</button>
                <div>${err}</div>
            </div>
        </form>
    </section>
</body>
</html> 