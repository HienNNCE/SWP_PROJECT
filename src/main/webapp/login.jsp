<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - DriverXO</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 40px;
            background-color: #f4f4f4;
        }

        .container {
            background: #fff;
            padding: 30px;
            max-width: 400px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin: 12px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
        }

        input[type="submit"] {
            background-color: #0066cc;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        input[type="submit"]:hover {
            background-color: #004a99;
        }

        .error-message {
            color: red;
            font-size: 14px;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Login to DriverXO</h2>

    <form method="post" action="login">
        <label for="username">Username or Email:</label>
        <input type="text" id="username" name="username" required />

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required />

        <input type="submit" value="Login" />
    </form>

    <c:if test="${not empty err}">
        <div class="error-message">${err}</div>
    </c:if>
</div>
</body>
</html>
