<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
    <title>Checkout</title>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
        body { font-family: 'Inter', sans-serif; background: #f8f8f8; margin: 0; }
        .container { max-width: 700px; margin: 40px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); padding: 32px; }
        h2 { margin-top: 0; font-size: 28px; font-weight: 600; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 24px; }
        th, td { padding: 12px 8px; text-align: left; }
        th { background: #f0f0f0; font-weight: 500; }
        tr:not(:last-child) { border-bottom: 1px solid #eee; }
        .total-row td { font-weight: 600; font-size: 16px; }
        .pay-btn { width: 100%; background: #000; color: #fff; border: none; border-radius: 4px; padding: 14px 0; font-size: 16px; font-weight: 500; cursor: pointer; margin-top: 16px; }
        .pay-btn:hover { background: #333; }
        .back-link { display: inline-block; margin-bottom: 18px; color: #333; text-decoration: none; font-size: 14px; }
        .back-link:hover { text-decoration: underline; }
        </style>
    </head>
    <body>
            <div class="container">
        <a href="cart" class="back-link"><i class="fa fa-arrow-left"></i> Back to Cart</a>
        <h2>Checkout</h2>
        <c:if test="${empty partList}">
            <p>Your cart is empty.</p>
        </c:if>
        <c:if test="${not empty partList}">
            <table>
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
            </div>
    </body>
</html> 