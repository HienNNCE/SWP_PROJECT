<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f8f8f8; margin: 0; }
        .container { max-width: 500px; margin: 60px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 40px 32px; text-align: center; }
        .icon-success { color: #27ae60; font-size: 48px; margin-bottom: 18px; }
        h2 { margin: 0 0 12px 0; font-size: 26px; font-weight: 600; }
        p { color: #555; font-size: 16px; margin-bottom: 28px; }
        .btn { display: inline-block; margin: 0 8px; padding: 12px 28px; border-radius: 4px; font-size: 15px; font-weight: 500; text-decoration: none; border: none; cursor: pointer; }
        .btn-home { background: #000; color: #fff; }
        .btn-home:hover { background: #333; }
        .btn-orders { background: #fff; color: #333; border: 1px solid #ddd; }
        .btn-orders:hover { border-color: #000; color: #000; }
    </style>
</head>
<body>
    <div class="container">
        <div class="icon-success"><i class="fa fa-check-circle"></i></div>
        <h2>Payment Successful!</h2>
        <p>Your order has been placed successfully.<br>Thank you for shopping with us.</p>
        <a href="home" class="btn btn-home">Back to Home</a>
        <a href="order" class="btn btn-orders">View My Orders</a>
    </div>
</body>
</html> 