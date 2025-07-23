<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - DriverXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/carlist.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@200;300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        html, body { height: 100%; }
        body { display: flex; flex-direction: column; min-height: 100vh; }
        .container { flex: 1 0 auto; max-width: 800px; margin: 60px auto 30px auto; padding: 0 15px; }
        footer { flex-shrink: 0; }
        .checkout-header {
            text-align: center;
            margin: 60px 0 30px 0;
        }
        .checkout-title {
            font-size: 32px;
            font-weight: 300;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 10px;
        }
        .checkout-subtitle {
            font-size: 13px;
            color: #777;
            font-weight: 300;
            line-height: 1.6;
            max-width: 500px;
            margin: 0 auto;
        }
        .checkout-section {
            background: #fcfcfc;
            border: 1px solid #f0f0f0;
            border-radius: 4px;
            padding: 30px 40px;
        }
        .checkout-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 24px;
            background: #fff;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .checkout-table th, .checkout-table td {
            padding: 14px 10px;
            text-align: left;
        }
        .checkout-table th {
            background: #f0f0f0;
            font-weight: 500;
            font-size: 14px;
        }
        .checkout-table tr:not(:last-child) {
            border-bottom: 1px solid #eee;
        }
        .checkout-table td {
            font-size: 14px;
        }
        .total-row td {
            font-weight: 600;
            font-size: 16px;
            background: #fafafa;
        }
        .pay-btn {
            width: 100%;
            background: #000;
            color: #fff;
            border: none;
            border-radius: 4px;
            padding: 14px 0;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            margin-top: 16px;
            transition: background 0.2s;
        }
        .pay-btn:hover { background: #333; }
        .back-link {
            display: inline-block;
            margin-bottom: 18px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
            transition: color 0.2s;
        }
        .back-link:hover { text-decoration: underline; color: #000; }
        .checkout-empty {
            text-align: center;
            padding: 60px 0;
            color: #888;
            font-size: 18px;
        }
        @media (max-width: 900px) {
            .checkout-section { padding: 20px 10px; }
        }
    </style>
</head>
<body>
<jsp:include page="/components/navbar.jsp"/>
<div class="container" style="padding-top:100px;">
    <div class="checkout-header">
        <h1 class="checkout-title">Checkout</h1>
        <p class="checkout-subtitle">Review your order and complete your purchase.</p>
    </div>
    <section class="checkout-section">
        <a href="cart" class="back-link"><i class="fa fa-arrow-left"></i> Back to Cart</a>
        <c:if test="${empty partList}">
            <div class="checkout-empty">Your cart is empty.</div>
        </c:if>
        <c:if test="${not empty partList}">
            <table class="checkout-table">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${partList}">
                        <tr>
                            <td>${item.partName}</td>
                            <td><fmt:formatNumber value="${item.partPrice}" type="currency" currencySymbol="$"/></td>
                            <td>${item.quantityInCart}</td>
                            <td><fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="$"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr class="total-row">
                        <td colspan="3" style="text-align:right;">Total:</td>
                        <td><fmt:formatNumber value="${totalPrice}" type="currency" currencySymbol="$"/></td>
                    </tr>
                </tfoot>
            </table>
            <form method="post" action="checkout">
                <button type="submit" class="pay-btn">PAY</button>
            </form>
        </c:if>
    </section>
</div>
<jsp:include page="/components/footer.jsp"/>
</body>
</html> 