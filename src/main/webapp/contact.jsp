<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contact & Appointment - DriverXO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/asset/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .banner-contact {
            width: 100%;
            height: 300px;
            background: url('${pageContext.request.contextPath}/asset/img/banner.jpg') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 36px;
            font-weight: bold;
            letter-spacing: 2px;
        }
        .appointment-form-container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 16px rgba(0,0,0,0.08);
            padding: 32px;
        }
        .appointment-form h2 {
            text-align: center;
            margin-bottom: 24px;
        }
        .appointment-form label {
            font-weight: 500;
            margin-bottom: 6px;
            display: block;
        }
        .appointment-form input, .appointment-form select, .appointment-form textarea {
            width: 100%;
            padding: 10px 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }
        .appointment-form button {
            width: 100%;
            padding: 12px;
            background: #111;
            color: #fff;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.2s;
        }
        .appointment-form button:hover {
            background: #333;
        }
    </style>
</head>
<body>
    <jsp:include page="components/navbar.jsp"/>
    <div class="banner-contact">
        Đặt lịch hẹn với DriverXO
    </div>
    <div class="appointment-form-container">
        <c:if test="${not empty successMsg}">
            <div style="background:#d4edda;color:#155724;padding:12px 20px;border-radius:8px;margin-bottom:18px;text-align:center;">
                ${successMsg}
            </div>
        </c:if>
        <form class="appointment-form" action="appointment" method="post">
            <h2>Đặt lịch hẹn cho xe</h2>
            <label for="fullname">Họ và tên</label>
            <input type="text" id="fullname" name="fullname" required>

            <label for="phone">Số điện thoại</label>
            <input type="text" id="phone" name="phone" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="serviceType">Loại dịch vụ</label>
            <select id="serviceType" name="serviceType" required>
                <option value="">-- Chọn loại dịch vụ --</option>
                <option value="testdrive">Lái thử xe</option>
                <option value="maintenance">Bảo dưỡng</option>
                <option value="repair">Sửa chữa</option>
                <option value="consult">Tư vấn mua xe</option>
            </select>

            <label for="car">Chọn xe</label>
            <input type="text" id="car" name="car" placeholder="Ví dụ: Mercedes S-Class" required>

            <label for="date">Ngày hẹn</label>
            <input type="date" id="date" name="date" required>

            <label for="time">Giờ hẹn</label>
            <input type="time" id="time" name="time" required>

            <label for="note">Ghi chú</label>
            <textarea id="note" name="note" rows="3"></textarea>

            <button type="submit">Đặt lịch hẹn</button>
        </form>
    </div>
    <jsp:include page="components/footer.jsp"/>
</body>
</html>