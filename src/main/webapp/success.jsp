<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body {
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #e0e7ef 100%);
            margin: 0;
        }
        .container {
            max-width: 480px;
            margin: 70px auto;
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.12);
            padding: 56px 36px 44px 36px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        .icon-success {
            color: #27ae60;
            font-size: 92px;
            margin-bottom: 24px;
            animation: popIn 0.7s cubic-bezier(.68,-0.55,.27,1.55) 0.1s both, rotateCheck 1.2s 0.2s ease-in-out;
            display: inline-block;
        }
        @keyframes popIn {
            0% { transform: scale(0.2); opacity: 0; }
            80% { transform: scale(1.15); opacity: 1; }
            100% { transform: scale(1); }
        }
        @keyframes rotateCheck {
            0% { transform: rotate(-30deg) scale(0.9); }
            60% { transform: rotate(10deg) scale(1.1); }
            100% { transform: rotate(0deg) scale(1); }
        }
        h2 {
            margin: 0 0 18px 0;
            font-size: 2.5rem;
            font-weight: 700;
            color: #222;
            letter-spacing: 0.5px;
        }
        p {
            color: #555;
            font-size: 1.18rem;
            margin-bottom: 36px;
            line-height: 1.6;
        }
        .btn {
            display: inline-block;
            margin: 0 10px;
            padding: 14px 36px;
            border-radius: 6px;
            font-size: 1.08rem;
            font-weight: 600;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: background 0.18s, color 0.18s, box-shadow 0.18s;
            box-shadow: 0 2px 8px rgba(39,174,96,0.08);
        }
        .btn-home {
            background: linear-gradient(90deg, #27ae60 60%, #219150 100%);
            color: #fff;
            box-shadow: 0 2px 12px rgba(39,174,96,0.13);
        }
        .btn-home:hover {
            background: linear-gradient(90deg, #219150 60%, #27ae60 100%);
            color: #fff;
        }
        .btn-orders {
            background: #fff;
            color: #27ae60;
            border: 2px solid #27ae60;
        }
        .btn-orders:hover {
            background: #27ae60;
            color: #fff;
        }
        @media (max-width: 600px) {
            .container { padding: 32px 8vw 28px 8vw; }
            .icon-success { font-size: 64px; }
            h2 { font-size: 1.5rem; }
            .btn { padding: 12px 18px; font-size: 1rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon-success"><i class="fa fa-check-circle"></i></div>
        <h2>Payment Successful!</h2>
        <p>Your order has been placed successfully.<br>Thank you for shopping with DriveXO.</p>
        <a href="home" class="btn btn-home">Back to Home</a>
        <a href="order" class="btn btn-orders">View My Orders</a>
        <div style="margin-top: 28px; color: #888; font-size: 0.98rem; letter-spacing: 0.2px;">
            Supported by <span style="color: #1a73e8; font-weight: 600;">VN PAY</span>
        </div>
    </div>
</body>
</html> 