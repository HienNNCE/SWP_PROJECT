<%-- 
    Document   : profile
    Created on : May 28, 2025, 09:15:00 AM
    Author     : giahuy
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Profile - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .profile-section {
                padding: 60px 0;
            }

            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }

            .profile-wrapper {
                display: grid;
                grid-template-columns: 1fr 3fr;
                gap: 30px;
            }

            @media (max-width: 992px) {
                .profile-wrapper {
                    grid-template-columns: 1fr;
                }
            }

            .profile-sidebar {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                overflow: hidden;
            }

            .profile-header {
                padding: 30px 20px;
                text-align: center;
                background-color: var(--primary-color);
                color: #fff;
            }

            .profile-avatar {
                width: 100px;
                height: 100px;
                margin: 0 auto 15px;
                border-radius: 50%;
                overflow: hidden;
                border: 3px solid #fff;
                box-shadow: 0 2px 10px rgba(0,0,0,0.2);
            }

            .profile-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .profile-name {
                font-size: 20px;
                font-weight: 600;
                margin: 0 0 5px;
            }

            .profile-member-since {
                font-size: 14px;
                opacity: 0.8;
            }

            .profile-nav {
                padding: 15px 0;
            }

            .profile-nav-item {
                padding: 15px 20px;
                display: flex;
                align-items: center;
                gap: 12px;
                color: #333;
                text-decoration: none;
                transition: all 0.3s;
                border-left: 3px solid transparent;
            }

            .profile-nav-item:hover {
                background-color: rgba(7, 46, 176, 0.05);
                color: var(--primary-color);
            }

            .profile-nav-item.active {
                background-color: rgba(7, 46, 176, 0.08);
                color: var(--primary-color);
                border-left: 3px solid var(--primary-color);
            }

            .profile-nav-item i {
                font-size: 18px;
                width: 24px;
                text-align: center;
            }

            .profile-content {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.1);
                padding: 30px;
            }

            .profile-section-title {
                font-size: 20px;
                font-weight: 600;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
                color: #333;
            }

            .profile-form {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                gap: 25px;
            }

            @media (max-width: 768px) {
                .profile-form {
                    grid-template-columns: 1fr;
                }
            }

            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #555;
            }

            .form-control {
                display: block;
                width: 100%;
                padding: 12px 15px;
                font-size: 15px;
                border: 1px solid #ddd;
                border-radius: 5px;
                transition: border-color 0.3s;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                outline: none;
                box-shadow: 0 0 0 3px rgba(7, 46, 176, 0.15);
            }

            .profile-actions {
                padding-top: 20px;
                margin-top: 20px;
                border-top: 1px solid #eee;
                display: flex;
                justify-content: flex-end;
                gap: 15px;
            }

            .btn {
                padding: 12px 24px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .btn-secondary {
                background-color: #f5f5f5;
                color: #333;
                border: 1px solid #ddd;
            }

            .btn-secondary:hover {
                background-color: #e9e9e9;
            }

            .btn-primary {
                background-color: var(--primary-color);
                color: #fff;
                border: none;
            }

            .btn-primary:hover {
                background-color: var(--secondary-color);
            }

            .form-full-width {
                grid-column: span 2;
            }

            @media (max-width: 768px) {
                .form-full-width {
                    grid-column: span 1;
                }
            }

            .address-card {
                background-color: #f8f9fa;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid #eee;
            }

            .address-card h4 {
                font-size: 18px;
                margin: 0 0 10px;
            }

            .address-card p {
                margin: 0 0 10px;
                color: #555;
                line-height: 1.5;
            }

            .address-actions {
                display: flex;
                gap: 10px;
                margin-top: 10px;
            }

            .address-btn {
                padding: 6px 12px;
                font-size: 14px;
                font-weight: 500;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .edit-address {
                background-color: #f0f0f0;
                color: #333;
                border: 1px solid #ddd;
            }

            .delete-address {
                background-color: #fff0f0;
                color: #dc3545;
                border: 1px solid #ffccd5;
            }

            .add-address {
                display: block;
                width: 100%;
                padding: 12px;
                text-align: center;
                background-color: #f8f9fa;
                border: 2px dashed #ddd;
                border-radius: 8px;
                color: #555;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s;
            }

            .add-address:hover {
                background-color: #f0f0f0;
                border-color: #ccc;
            }

            .tab-content {
                display: none;
            }

            .tab-content.active {
                display: block;
            }

            .password-form {
                max-width: 600px;
            }

            .notification-preference {
                margin-bottom: 20px;
                padding: 15px;
                border-bottom: 1px solid #eee;
            }

            .notification-preference:last-child {
                border-bottom: none;
            }

            .preference-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
            }

            .preference-title {
                font-weight: 600;
                font-size: 16px;
            }

            .toggle-switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 26px;
            }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 34px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }

            input:checked + .toggle-slider {
                background-color: var(--primary-color);
            }

            input:checked + .toggle-slider:before {
                transform: translateX(24px);
            }

            .preference-description {
                color: #777;
                font-size: 14px;
                margin-top: 5px;
            }

            .delete-account {
                margin-top: 30px;
                padding-top: 30px;
                border-top: 1px solid #eee;
            }

            .delete-account-btn {
                background-color: #fff0f0;
                color: #dc3545;
                border: 1px solid #ffccd5;
                padding: 10px 20px;
                font-size: 14px;
                font-weight: 500;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s;
            }

            .delete-account-btn:hover {
                background-color: #ffecec;
            }

            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                color: #fff;
            }
            .alert-success {
                background-color: #28a745;
            }
            .alert-error {
                background-color: #dc3545;
            }

            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                justify-content: center;
                align-items: center;
            }

            .modal-content {
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                width: 500px;
                max-width: 90%;
                position: relative;
                animation: fadeIn 0.3s ease-in-out;
            }

            .modal .close {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 24px;
                color: #888;
                cursor: pointer;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }
                to   {
                    opacity: 1;
                    transform: scale(1);
                }
            }
        </style>
    </head>
    <body>
        <!-- Check if user is logged in -->
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <h1>My Profile</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Profile</span>
                </div>
            </div>
        </section>

        <!-- Profile Section -->
        <section class="profile-section">
            <div class="container">
                <div class="profile-wrapper">
                    <!-- Profile Sidebar -->
                    <div class="profile-sidebar">
                        <div class="profile-header">
                            <div class="profile-avatar">
                                <img src="asset/img/avt/user-avatar.png" alt="User Avatar">
                            </div>
                            <h3 class="profile-name">${sessionScope.user.fullName}</h3>
                            <div class="profile-member-since">${sessionScope.user.userName}</div>
                        </div>
                        <div class="profile-nav">
                            <a href="#" class="profile-nav-item active" data-tab="personal-info">
                                <i class="fas fa-user"></i> Personal Information
                            </a>
<!--                            <a href="#" class="profile-nav-item" data-tab="addresses">
                                <i class="fas fa-map-marker-alt"></i> Addresses
                            </a>-->
                            <a href="#" class="profile-nav-item" data-tab="security">
                                <i class="fas fa-lock"></i> Security
                            </a>
<!--                            <a href="#" class="profile-nav-item" data-tab="notifications">
                                <i class="fas fa-bell"></i> Notifications
                            </a>
                            <a href="bookings" class="profile-nav-item">
                                <i class="fas fa-calendar-check"></i> My Bookings
                            </a>
                            <a href="order-history" class="profile-nav-item">
                                <i class="fas fa-history"></i> Order History
                            </a>
                            <a href="#" class="profile-nav-item" data-tab="payment-methods">
                                <i class="fas fa-credit-card"></i> Payment Methods
                            </a>-->
                            <a href="${pageContext.request.contextPath}/auth/LoginServlet?action=logout" class="profile-nav-item">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>

                    <!-- Profile Content -->
                    <div class="profile-content">
                        <!-- Personal Information Tab -->
                        <div class="tab-content active" id="personal-info">
                            <h2 class="profile-section-title">Personal Information</h2>
                            <c:if test="${not empty message}">
                                <div class="alert-box alert ${success ? 'alert-success' : 'alert-error'}">
                                    ${message}
                                </div>
                            </c:if>
                            <form class="profile-form" action="profile" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="userId" value="${sessionScope.user.userId}">

                                <div class="form-group">
                                    <label for="userName">Username</label>
                                    <input type="text" class="form-control" id="userName" name="userName" value="${sessionScope.user.userName}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${sessionScope.user.email}" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="fullName">Full Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" value="${sessionScope.user.fullName}" required>
                                </div>

                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="form-control" id="gender" name="gender" required>
                                        <option value="MALE" ${sessionScope.user.gender ? 'selected' : ''}>Male</option>
                                        <option value="FEMALE" ${!sessionScope.user.gender ? 'selected' : ''}>Female</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" name="dob" value="${sessionScope.user.dob}" required>
                                </div>

                                <div class="form-group">
                                    <label for="phone">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" value="${sessionScope.user.phone}">
                                </div>

                                <div class="form-group form-full-width">
                                    <label for="address">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="3">${sessionScope.user.address}</textarea>
                                </div>

                                <div class="form-group form-full-width">
                                    <label for="aboutMe">About Me</label>
                                    <textarea class="form-control" id="aboutMe" name="aboutMe" rows="3">${sessionScope.user.aboutMe}</textarea>
                                </div>

                                <div class="profile-actions form-full-width">
                                    <button type="button" class="btn btn-secondary" onclick="window.location.href = 'home'">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>

                        <!-- Addresses Tab -->
                        <div class="tab-content" id="addresses">
                            <h2 class="profile-section-title">My Addresses</h2>
                            <c:if test="${not empty message}">
                                <div class="alert-box alert ${success ? 'alert-success' : 'alert-error'}">
                                    ${message}
                                </div>
                            </c:if>
                            <div class="address-list">
                                <!-- List Addresses -->
                                <c:forEach var="address" items="${addresses}">
                                    <div class="address-card">
                                        <h4>${address.addressName}</h4>
                                        <p>
                                            ${sessionScope.user.userName}<br>
                                            ${address.addressDetails}<br>
                                            Phone: ${address.phone}
                                        </p>
                                        <div class="address-actions">
                                            <button class="address-btn edit-address"
                                                    onclick="showEditAddressForm(
                                                                    '${address.addressId}',
                                                                    '${fn:escapeXml(address.addressName)}',
                                                                    '${fn:escapeXml(address.addressDetails)}',
                                                                    '${fn:escapeXml(address.phone)}')">Edit</button>

                                            <form action="profile" method="post" style="display:inline;">
                                                <input type="hidden" name="action" value="deleteAddress">
                                                <input type="hidden" name="addressId" value="${address.addressId}">
                                                <input type="hidden" name="userId" value="${sessionScope.user.userId}">
                                                <button type="submit" class="address-btn delete-address"
                                                        onclick="return confirm('Are you sure you want to delete this address?')">Delete</button>
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Add Address Modal -->
                                <div id="add-address-modal" class="modal">
                                    <div class="modal-content">
                                        <span class="close" onclick="hideAddressForm()">&times;</span>
                                        <h4>Add New Address</h4>
                                        <form action="profile" method="post">
                                            <input type="hidden" name="action" value="addAddress">
                                            <input type="hidden" name="userId" value="${sessionScope.user.userId}">
                                            <div class="form-group">
                                                <label for="addressName">Address Name</label>
                                                <input type="text" class="form-control" id="addressName" name="addressName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="addressDetails">Address Details</label>
                                                <textarea class="form-control" id="addressDetails" name="addressDetails" rows="4" required></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="phone">Phone Number</label>
                                                <input type="tel" class="form-control" id="phone" name="phone">
                                            </div>
                                            <div class="address-actions">
                                                <button type="button" class="address-btn edit-address" onclick="hideAddressForm()">Cancel</button>
                                                <button type="submit" class="address-btn btn-primary">Save</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Edit Address Modal -->
                                <div id="edit-address-modal" class="modal">
                                    <div class="modal-content">
                                        <span class="close" onclick="hideAddressForm()">&times;</span>
                                        <h4>Edit Address</h4>
                                        <form action="profile" method="post">
                                            <input type="hidden" name="action" value="editAddress">
                                            <input type="hidden" name="addressId" id="editAddressId">
                                            <input type="hidden" name="userId" value="${sessionScope.user.userId}">
                                            <div class="form-group">
                                                <label for="editAddressName">Address Name</label>
                                                <input type="text" class="form-control" id="editAddressName" name="addressName" required>
                                            </div>
                                            <div class="form-group">
                                                <label for="editAddressDetails">Address Details</label>
                                                <textarea class="form-control" id="editAddressDetails" name="addressDetails" rows="4" required></textarea>
                                            </div>
                                            <div class="form-group">
                                                <label for="editPhone">Phone Number</label>
                                                <input type="tel" class="form-control" id="editPhone" name="phone">
                                            </div>
                                            <div class="address-actions">
                                                <button type="button" class="address-btn edit-address" onclick="hideAddressForm()">Cancel</button>
                                                <button type="submit" class="address-btn btn-primary">Save</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>

                                <!-- Add Address Button -->
                                <button class="add-address" onclick="showAddAddressForm()">
                                    <i class="fas fa-plus"></i> Add New Address
                                </button>
                            </div>
                        </div>

                        <!-- Security Tab -->
                        <div class="tab-content" id="security">
                            <h2 class="profile-section-title">Security Settings</h2>
                            <div class="password-form">
                                <c:if test="${not empty message}">
                                    <div class="alert-box alert ${success ? 'alert-success' : 'alert-error'}">
                                        ${message}
                                    </div>
                                </c:if>
                                <form action="profile" method="post">
                                    <input type="hidden" name="action" value="changePassword">
                                    <input type="hidden" name="userId" value="${sessionScope.user.userId}">
                                    <div class="form-group">
                                        <label for="currentPassword">Current Password</label>
                                        <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="newPassword">New Password</label>
                                        <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="confirmPassword">Confirm New Password</label>
                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    </div>
                                    <div class="profile-actions">
                                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'home'">Cancel</button>
                                        <button type="submit" class="btn btn-primary">Update Password</button>
                                    </div>
                                </form>

<!--                                <div class="delete-account">
                                    <h3 class="profile-section-title">Delete Account</h3>
                                    <p>Once you delete your account, there is no going back. Please be certain.</p>
                                    <button class="delete-account-btn">Delete My Account</button>
                                </div>-->
                            </div>
                        </div>

                        <!-- Notifications Tab -->
                        <div class="tab-content" id="notifications">
                            <h2 class="profile-section-title">Notification Settings</h2>
                            <div class="notification-preferences">
                                <div class="notification-preference">
                                    <div class="preference-header">
                                        <span class="preference-title">Email Notifications</span>
                                        <label class="toggle-switch">
                                            <input type="checkbox" checked>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <p class="preference-description">Receive email notifications about your bookings, orders, and account activity.</p>
                                </div>
                                <div class="notification-preference">
                                    <div class="preference-header">
                                        <span class="preference-title">Newsletter Subscription</span>
                                        <label class="toggle-switch">
                                            <input type="checkbox" checked>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <p class="preference-description">Receive our weekly newsletter with new cars, promotions, and automotive news.</p>
                                </div>
                                <div class="notification-preference">
                                    <div class="preference-header">
                                        <span class="preference-title">Booking Reminders</span>
                                        <label class="toggle-switch">
                                            <input type="checkbox" checked>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <p class="preference-description">Receive reminders about upcoming test drives and service appointments.</p>
                                </div>
                                <div class="notification-preference">
                                    <div class="preference-header">
                                        <span class="preference-title">Special Offers</span>
                                        <label class="toggle-switch">
                                            <input type="checkbox">
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <p class="preference-description">Receive notifications about special offers, discounts, and promotions.</p>
                                </div>
                                <div class="notification-preference">
                                    <div class="preference-header">
                                        <span class="preference-title">SMS Notifications</span>
                                        <label class="toggle-switch">
                                            <input type="checkbox">
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <p class="preference-description">Receive text message notifications for important updates and reminders.</p>
                                </div>
                                <div class="profile-actions">
                                    <button type="button" class="btn btn-secondary">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Preferences</button>
                                </div>
                            </div>
                        </div>

                        <!-- Payment Methods Tab -->
                        <div class="tab-content" id="payment-methods">
                            <h2 class="profile-section-title">Payment Methods</h2>
                            <div class="payment-methods-list">
                                <!-- Credit Card -->
                                <div class="address-card">
                                    <h4><i class="fab fa-cc-visa"></i> Visa ending in 4242</h4>
                                    <p>Expires: 08/2027<br>
                                        ${sessionScope.user.userName}<br>
                                        Default payment method</p>
                                    <div class="address-actions">
                                        <button class="address-btn edit-address">Edit</button>
                                        <button class="address-btn delete-address">Delete</button>
                                    </div>
                                </div>

                                <!-- Another Credit Card -->
                                <div class="address-card">
                                    <h4><i class="fab fa-cc-mastercard"></i> MasterCard ending in 9876</h4>
                                    <p>Expires: 12/2028<br>
                                        ${sessionScope.user.userName}</p>
                                    <div class="address-actions">
                                        <button class="address-btn edit-address">Edit</button>
                                        <button class="address-btn delete-address">Delete</button>
                                    </div>
                                </div>

                                <button class="add-address">
                                    <i class="fas fa-plus"></i> Add New Payment Method
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            window.addEventListener('DOMContentLoaded', function () {
                const alerts = document.querySelectorAll('.alert-box');
                alerts.forEach(alert => {
                    setTimeout(() => {
                        alert.style.transition = 'opacity 0.5s ease';
                        alert.style.opacity = 0;
                        setTimeout(() => alert.remove(), 500);
                    }, 2000);
                });
            });
            document.addEventListener('DOMContentLoaded', function () {
                // Tab functionality
                const tabLinks = document.querySelectorAll('.profile-nav-item[data-tab]');
                const tabContents = document.querySelectorAll('.tab-content');

                tabLinks.forEach(link => {
                    link.addEventListener('click', function (e) {
                        e.preventDefault();
                        tabLinks.forEach(tab => tab.classList.remove('active'));
                        tabContents.forEach(content => content.classList.remove('active'));
                        this.classList.add('active');
                        const tabId = this.getAttribute('data-tab');
                        document.getElementById(tabId).classList.add('active');
                        hideAddressForm();
                    });
                });

                // Address form toggle
                window.showAddAddressForm = function () {
                    document.getElementById('add-address-modal').style.display = 'flex';
                    document.getElementById('addressName').value = '';
                    document.getElementById('addressDetails').value = '';
                    document.getElementById('phone').value = '';
                };

                window.showEditAddressForm = function (addressId, addressName, addressDetails, phone) {
                    document.getElementById('edit-address-modal').style.display = 'flex';
                    document.getElementById('editAddressId').value = addressId;
                    document.getElementById('editAddressName').value = addressName;
                    document.getElementById('editAddressDetails').value = addressDetails;
                    document.getElementById('editPhone').value = phone;
                };

                window.hideAddressForm = function () {
                    document.getElementById('add-address-modal').style.display = 'none';
                    document.getElementById('edit-address-modal').style.display = 'none';
                };

                // Delete account button
                const deleteAccountBtn = document.querySelector('.delete-account-btn');
                if (deleteAccountBtn) {
                    deleteAccountBtn.addEventListener('click', function () {
                        if (confirm('Bạn có chắc muốn xóa tài khoản? Hành động này không thể hoàn tác.')) {
                            console.log('Yêu cầu xóa tài khoản');
                        }
                    });
                }
            });
        </script>
    </body>
</html>