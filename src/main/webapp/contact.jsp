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
            Book an Appointment with DriverXO
        </div>
        <div class="appointment-form-container">
            <c:if test="${not empty successMsg}">
                <div style="background:#d4edda;color:#155724;padding:12px 20px;border-radius:8px;margin-bottom:18px;text-align:center;">
                    ${successMsg}
                </div>
            </c:if>
            <c:if test="${empty successMsg}">
            <form class="appointment-form" method="post" action="serviceAppointment" onsubmit="..." novalidate>
                <input type="hidden" name="action" value="checkDate">
                <h2>Service Appointment Booking</h2>

                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" required>

                <label for="phone">Phone Number</label>

                <input type="text" id="phone" name="phone" required>

                <label for="email">Email</label>
                <input type="email" id="email" name="email" required>

                <div id="repairTypeContainer" style="margin-top: 10px;">
                    <label for="repairType">Repair Type:</label>
                    <c:choose>
                        <c:when test="${empty service}">
                            <select id="repairType" name="repairType" required>
                                <option value="">-- Select Repair Type --</option>
                                <option value="1">Oil Change</option>
                                <option value="2">Brake Inspection</option>
                                <option value="3">Tire Rotation</option>
                                <option value="4">Engine Tune-up</option>
                                <option value="5">Transmission Service</option>
                                <option value="6">Suspension Check</option>
                                <option value="7">Battery Replacement</option>
                                <option value="8">Exhaust Repair</option>
                                <option value="9">Cooling System Flush</option>
                                <option value="10">Brake Pad Replacement</option>
                                <option value="11">Wheel Alignment</option>
                                <option value="12">Air Filter Replacement</option>
                                <option value="13">Oil Filter Change</option>
                                <option value="14">Radiator Repair</option>
                                <option value="15">Clutch Adjustment</option>
                            </select>
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="repairType" value="${service.serviceId}" />
                            <input type="text" class="form-control" value="${service.serviceName}" style="background-color: #fff8dc;" readonly />
                        </c:otherwise>
                    </c:choose>
                </div>


                <label for="car">Car Infor</label>
                <input type="text" id="car" name="car" placeholder="e.g., Mercedes S-Class" required>

                <label for="date">Appointment Date</label>
                <input type="date" id="date" name="date" min="${minDate}" onkeydown="return false" required>

                <label for="time">Appointment Time</label>
                <input type="time" id="time" name="time" required min="09:00" max="20:00" onkeydown="return false">


                <label for="note">Notes</label>
                <textarea id="note" name="note" rows="3"></textarea>

                <button type="submit">Book Appointment</button>
            </form>
            </c:if>
        </div>
        <jsp:include page="components/footer.jsp"/>
    </body>
</html>

