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
                <form class="appointment-form" method="post" action="carAppointment">
                    <h2>Car Appointment Booking</h2>
                    <label for="serviceType">Service Type</label>
                    <select id="serviceType" name="serviceType" required>
                        <option value="">-- Select Service Type --</option>
                        <option value="testdrive">Test Drive</option>
                        <option value="maintenance">Maintenance</option>
                        <option value="consult">Vehicle Consultation</option>
                    </select>

                    <label for="carName">Car Name</label>
                    <input type="text" id="carName" name="carName" value="${car.carName}" readonly class="form-control" style="background-color: #fff8dc;">

                    <label for="carModel">Car Model</label>
                    <input type="text" id="carModel" name="carModel" value="${car.model}" readonly class="form-control" style="background-color: #fff8dc;">

                    <input type="hidden" name="carModel" value="${car.model}">

                    <input type="hidden" name="carId" value="${car.carId}">

                    <label for="date">Appointment Date</label>
                    <input type="date" id="date" name="date" min="${minDate}" onkeydown="return false" required>

                    <label for="time">Appointment Time</label>
                    <input type="time" id="time" name="time" min="09:00" max="20:00" onkeydown="return false" required>

                    <label for="note">Notes</label>
                    <textarea id="note" name="note" rows="3"></textarea>

                    <button type="submit">Book Appointment</button>
                </form>
            </c:if>
        </div>
        <jsp:include page="components/footer.jsp"/>

        <!-- JS xử lý action động -->
        <%-- <script>
            document.querySelector('.appointment-form').addEventListener('submit', function (e) {
                const service = document.getElementById('serviceType').value;
                if (service === 'maintenance' || service === 'repair') {
                    this.action = 'booking';
                } else {
                    this.action = 'appointment';
                }
            });
        </script> --%>
        <%-- <script>
            function toggleRepairOptions() {
                const serviceType = document.getElementById('serviceType').value;
                const repairContainer = document.getElementById('repairTypeContainer');
                const repairSelect = document.getElementById('repairType');

                if (serviceType === 'repair') {
                    repairContainer.style.display = 'block';
                    repairSelect.setAttribute('required', 'required');
                } else {
                    repairContainer.style.display = 'none';
                    repairSelect.removeAttribute('required');
                    repairSelect.value = '';
                }
            }
            
        </script> --%>
    </body>
</html>

