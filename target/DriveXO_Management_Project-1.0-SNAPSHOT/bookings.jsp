<%-- 
    Document   : bookings
    Created on : May 27, 2025, 11:30:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Bookings - DriverXO</title>
        <link rel="stylesheet" href="asset/css/style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <style>
            .bookings-section {
                padding: 60px 0;
            }
            
            .page-title {
                font-size: 32px;
                font-weight: 700;
                margin-bottom: 30px;
                color: var(--primary-color);
            }
            
            .bookings-tabs {
                display: flex;
                margin-bottom: 30px;
                border-bottom: 1px solid #ddd;
            }
            
            .tab-button {
                padding: 15px 30px;
                font-size: 16px;
                font-weight: 600;
                background: none;
                border: none;
                color: #777;
                cursor: pointer;
                position: relative;
                transition: color 0.3s;
            }
            
            .tab-button.active {
                color: var(--primary-color);
            }
            
            .tab-button.active:after {
                content: "";
                position: absolute;
                bottom: -1px;
                left: 0;
                width: 100%;
                height: 3px;
                background-color: var(--primary-color);
            }
            
            .tab-content {
                display: none;
            }
            
            .tab-content.active {
                display: block;
            }
            
            .booking-card {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.08);
                margin-bottom: 20px;
                overflow: hidden;
                transition: transform 0.3s, box-shadow 0.3s;
            }
            
            .booking-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.12);
            }
            
            .booking-header {
                padding: 20px;
                background-color: #f8f9fa;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .booking-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin: 0;
            }
            
            .booking-status {
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                text-transform: uppercase;
            }
            
            .status-confirmed {
                background-color: #e3f8e3;
                color: #28a745;
            }
            
            .status-pending {
                background-color: #fff7e0;
                color: #ffc107;
            }
            
            .status-completed {
                background-color: #e9ecef;
                color: #6c757d;
            }
            
            .status-cancelled {
                background-color: #ffe0e0;
                color: #dc3545;
            }
            
            .booking-body {
                padding: 20px;
            }
            
            .booking-info {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 20px;
                margin-bottom: 20px;
            }
            
            .booking-info-item {
                display: flex;
                flex-direction: column;
            }
            
            .info-label {
                font-size: 14px;
                color: #777;
                margin-bottom: 5px;
            }
            
            .info-value {
                font-size: 16px;
                font-weight: 500;
                color: #333;
            }
            
            .car-details {
                display: flex;
                align-items: center;
                gap: 15px;
                padding: 15px;
                background-color: #f8f9fa;
                border-radius: 8px;
                margin-bottom: 20px;
            }
            
            .car-image {
                width: 100px;
                height: 70px;
                border-radius: 5px;
                overflow: hidden;
                background-color: #eee;
            }
            
            .car-image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .car-info h4 {
                font-size: 16px;
                margin: 0 0 5px;
            }
            
            .car-info .car-brand {
                color: #777;
                font-size: 14px;
            }
            
            .booking-actions {
                display: flex;
                gap: 10px;
            }
            
            .booking-action-btn {
                padding: 8px 16px;
                font-weight: 500;
                font-size: 14px;
                border-radius: 4px;
                cursor: pointer;
                transition: all 0.3s;
            }
            
            .view-details-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .view-details-btn:hover {
                background-color: var(--secondary-color);
            }
            
            .reschedule-btn {
                background-color: #fff;
                color: #6c757d;
                border: 1px solid #6c757d;
            }
            
            .reschedule-btn:hover {
                background-color: #f8f9fa;
            }
            
            .cancel-btn {
                background-color: #fff;
                color: #dc3545;
                border: 1px solid #dc3545;
            }
            
            .cancel-btn:hover {
                background-color: #fff7f7;
            }
            
            .empty-bookings {
                text-align: center;
                padding: 60px 20px;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            }
            
            .empty-icon {
                font-size: 80px;
                color: #ddd;
                margin-bottom: 20px;
            }
            
            .empty-message {
                font-size: 24px;
                color: #666;
                margin-bottom: 30px;
            }
            
            .book-now-btn {
                display: inline-block;
                padding: 12px 30px;
                background-color: var(--primary-color);
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            
            .book-now-btn:hover {
                background-color: var(--secondary-color);
            }
            
            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                overflow: auto;
            }
            
            .modal-content {
                background-color: #fff;
                margin: 50px auto;
                width: 100%;
                max-width: 600px;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                animation: modalFadeIn 0.3s;
            }
            
            @keyframes modalFadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            
            .modal-header {
                padding: 20px;
                border-bottom: 1px solid #eee;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            
            .modal-title {
                font-size: 20px;
                font-weight: 600;
                color: var(--primary-color);
                margin: 0;
            }
            
            .close-modal {
                background: none;
                border: none;
                font-size: 22px;
                color: #999;
                cursor: pointer;
            }
            
            .modal-body {
                padding: 20px;
            }
            
            .modal-footer {
                padding: 15px 20px;
                border-top: 1px solid #eee;
                text-align: right;
            }
            
            .modal-footer .btn {
                padding: 8px 16px;
                margin-left: 10px;
                border-radius: 4px;
                font-weight: 500;
                cursor: pointer;
            }
            
            .btn-secondary {
                background-color: #f8f9fa;
                color: #333;
                border: 1px solid #ddd;
            }
            
            .btn-primary {
                background-color: var(--primary-color);
                color: white;
                border: none;
            }
            
            .btn-primary:hover {
                background-color: var(--secondary-color);
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="/components/navbar.jsp" />

        <!-- Page Title Section -->
        <section class="page-title-section">
            <div class="container">
                <h1>Your Bookings</h1>
                <div class="breadcrumb">
                    <a href="home">Home</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <a href="profile">My Account</a>
                    <span><i class="fas fa-angle-right"></i></span>
                    <span>Bookings</span>
                </div>
            </div>
        </section>

        <!-- Bookings Section -->
        <section class="bookings-section">
            <div class="container">
                <div class="bookings-tabs">
                    <button class="tab-button active" data-tab="test-drives">Test Drives</button>
                    <button class="tab-button" data-tab="services">Service Appointments</button>
                    <button class="tab-button" data-tab="history">Booking History</button>
                </div>
                
                <!-- Test Drives Tab -->
                <div class="tab-content active" id="test-drives">
                    <!-- For demo purposes, assuming there are bookings -->
                    <div class="booking-card">
                        <div class="booking-header">
                            <h3 class="booking-title">Test Drive - #TD12345</h3>
                            <span class="booking-status status-confirmed">Confirmed</span>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="booking-info-item">
                                    <span class="info-label">Date</span>
                                    <span class="info-value">June 5, 2025</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Time</span>
                                    <span class="info-value">10:30 AM</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Location</span>
                                    <span class="info-value">DriverXO Showroom - Downtown</span>
                                </div>
                            </div>
                            
                            <div class="car-details">
                                <div class="car-image">
                                    <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                </div>
                                <div class="car-info">
                                    <h4>Chevrolet CamFó Explorer</h4>
                                    <span class="car-brand">Chevrolet</span>
                                </div>
                            </div>
                            
                            <div class="booking-actions">
                                <button class="booking-action-btn view-details-btn" data-id="TD12345">View Details</button>
                                <button class="booking-action-btn reschedule-btn">Reschedule</button>
                                <button class="booking-action-btn cancel-btn">Cancel</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="booking-card">
                        <div class="booking-header">
                            <h3 class="booking-title">Test Drive - #TD12346</h3>
                            <span class="booking-status status-pending">Pending</span>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="booking-info-item">
                                    <span class="info-label">Date</span>
                                    <span class="info-value">June 10, 2025</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Time</span>
                                    <span class="info-value">3:00 PM</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Location</span>
                                    <span class="info-value">DriverXO Showroom - Westside</span>
                                </div>
                            </div>
                            
                            <div class="car-details">
                                <div class="car-image">
                                    <img src="asset/img/cars/alfa-romeo.png" alt="Nissan Alfa Romeo">
                                </div>
                                <div class="car-info">
                                    <h4>Nissan Alfa Romeo</h4>
                                    <span class="car-brand">Nissan</span>
                                </div>
                            </div>
                            
                            <div class="booking-actions">
                                <button class="booking-action-btn view-details-btn" data-id="TD12346">View Details</button>
                                <button class="booking-action-btn reschedule-btn">Reschedule</button>
                                <button class="booking-action-btn cancel-btn">Cancel</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- View All link -->
                    <div style="text-align: right; margin-top: 20px;">
                        <a href="order-history" style="color: var(--primary-color); font-weight: 600; text-decoration: none;">View All Orders <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <!-- Service Appointments Tab -->
                <div class="tab-content" id="services">
                    <div class="booking-card">
                        <div class="booking-header">
                            <h3 class="booking-title">Service Appointment - #SV45678</h3>
                            <span class="booking-status status-confirmed">Confirmed</span>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="booking-info-item">
                                    <span class="info-label">Date</span>
                                    <span class="info-value">June 15, 2025</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Time</span>
                                    <span class="info-value">9:00 AM</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Service Type</span>
                                    <span class="info-value">Regular Maintenance</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Location</span>
                                    <span class="info-value">DriverXO Service Center - Main</span>
                                </div>
                            </div>
                            
                            <div class="car-details">
                                <div class="car-image">
                                    <img src="asset/img/cars/corvette-z51.png" alt="Honda Shevrolet Corvette Z51">
                                </div>
                                <div class="car-info">
                                    <h4>Honda Shevrolet Corvette Z51</h4>
                                    <span class="car-brand">Honda</span>
                                </div>
                            </div>
                            
                            <div class="booking-actions">
                                <button class="booking-action-btn view-details-btn" data-id="SV45678">View Details</button>
                                <button class="booking-action-btn reschedule-btn">Reschedule</button>
                                <button class="booking-action-btn cancel-btn">Cancel</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- View All link -->
                    <div style="text-align: right; margin-top: 20px;">
                        <a href="order-history" style="color: var(--primary-color); font-weight: 600; text-decoration: none;">View All Orders <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <!-- Booking History Tab -->
                <div class="tab-content" id="history">
                    <div class="booking-card">
                        <div class="booking-header">
                            <h3 class="booking-title">Test Drive - #TD12340</h3>
                            <span class="booking-status status-completed">Completed</span>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="booking-info-item">
                                    <span class="info-label">Date</span>
                                    <span class="info-value">May 20, 2025</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Time</span>
                                    <span class="info-value">2:30 PM</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Location</span>
                                    <span class="info-value">DriverXO Showroom - Downtown</span>
                                </div>
                            </div>
                            
                            <div class="car-details">
                                <div class="car-image">
                                    <img src="asset/img/cars/bmw-portofino.png" alt="BMW Camé Ferrari Portofino">
                                </div>
                                <div class="car-info">
                                    <h4>BMW Camé Ferrari Portofino</h4>
                                    <span class="car-brand">BMW</span>
                                </div>
                            </div>
                            
                            <div class="booking-actions">
                                <button class="booking-action-btn view-details-btn" data-id="TD12340">View Details</button>
                            </div>
                        </div>
                    </div>
                    
                    <div class="booking-card">
                        <div class="booking-header">
                            <h3 class="booking-title">Service Appointment - #SV45670</h3>
                            <span class="booking-status status-cancelled">Cancelled</span>
                        </div>
                        <div class="booking-body">
                            <div class="booking-info">
                                <div class="booking-info-item">
                                    <span class="info-label">Date</span>
                                    <span class="info-value">May 10, 2025</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Time</span>
                                    <span class="info-value">11:00 AM</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Service Type</span>
                                    <span class="info-value">Tire Replacement</span>
                                </div>
                                <div class="booking-info-item">
                                    <span class="info-label">Location</span>
                                    <span class="info-value">DriverXO Service Center - East</span>
                                </div>
                            </div>
                            
                            <div class="car-details">
                                <div class="car-image">
                                    <img src="asset/img/cars/atra-benz-black.png" alt="Hyundai Altra Benz C-Class">
                                </div>
                                <div class="car-info">
                                    <h4>Hyundai Altra Benz C-Class</h4>
                                    <span class="car-brand">Hyundai</span>
                                </div>
                            </div>
                            
                            <div class="booking-actions">
                                <button class="booking-action-btn view-details-btn" data-id="SV45670">View Details</button>
                            </div>
                        </div>
                    </div>
                    
                    <!-- View All link -->
                    <div style="text-align: right; margin-top: 20px;">
                        <a href="order-history" style="color: var(--primary-color); font-weight: 600; text-decoration: none;">View All Orders <i class="fas fa-arrow-right"></i></a>
                    </div>
                </div>
                
                <!-- Empty state (will be shown conditionally with JSTL) -->
                <c:if test="${empty testDrives && empty serviceAppointments && empty bookingHistory}">
                    <div class="empty-bookings">
                        <i class="fas fa-calendar-alt empty-icon"></i>
                        <h2 class="empty-message">You have no bookings</h2>
                        <p>Schedule a test drive or service appointment to get started.</p>
                        <a href="car/list" class="book-now-btn">Book Now</a>
                    </div>
                </c:if>
            </div>
        </section>
        
        <!-- Booking Details Modal -->
        <div class="modal" id="bookingDetailsModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Booking Details</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <!-- Content will be loaded dynamically -->
                    <div class="booking-details-content"></div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary close-btn">Close</button>
                    <button class="btn btn-primary add-to-calendar">Add to Calendar</button>
                </div>
            </div>
        </div>
        
        <!-- Reschedule Modal -->
        <div class="modal" id="rescheduleModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Reschedule Booking</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <form id="rescheduleForm">
                        <div class="form-group">
                            <label>Select Date</label>
                            <input type="date" name="newDate" required>
                        </div>
                        <div class="form-group">
                            <label>Select Time</label>
                            <select name="newTime" required>
                                <option value="">Select a time</option>
                                <option value="09:00">9:00 AM</option>
                                <option value="10:00">10:00 AM</option>
                                <option value="11:00">11:00 AM</option>
                                <option value="12:00">12:00 PM</option>
                                <option value="13:00">1:00 PM</option>
                                <option value="14:00">2:00 PM</option>
                                <option value="15:00">3:00 PM</option>
                                <option value="16:00">4:00 PM</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Reason for Rescheduling (Optional)</label>
                            <textarea name="reason" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary close-btn">Cancel</button>
                    <button class="btn btn-primary submit-reschedule">Submit</button>
                </div>
            </div>
        </div>
        
        <!-- Cancel Booking Modal -->
        <div class="modal" id="cancelBookingModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Cancel Booking</h2>
                    <button class="close-modal">&times;</button>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to cancel this booking? This action cannot be undone.</p>
                    <form id="cancelForm">
                        <div class="form-group">
                            <label>Reason for Cancellation</label>
                            <select name="cancelReason" required>
                                <option value="">Select a reason</option>
                                <option value="schedule_conflict">Schedule Conflict</option>
                                <option value="changed_mind">Changed My Mind</option>
                                <option value="found_alternative">Found Alternative</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                        <div class="form-group" id="otherReasonGroup" style="display:none;">
                            <label>Please Specify</label>
                            <textarea name="otherReason" rows="3"></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary close-btn">No, Keep It</button>
                    <button class="btn btn-primary confirm-cancel">Yes, Cancel Booking</button>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="/components/footer.jsp" />

        <!-- JavaScript -->
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                // Tab functionality
                const tabButtons = document.querySelectorAll('.tab-button');
                const tabContents = document.querySelectorAll('.tab-content');
                
                tabButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        // Remove active class from all buttons
                        tabButtons.forEach(btn => btn.classList.remove('active'));
                        
                        // Add active class to clicked button
                        button.classList.add('active');
                        
                        // Hide all tab content
                        tabContents.forEach(content => content.classList.remove('active'));
                        
                        // Show the selected tab content
                        const tabId = button.getAttribute('data-tab');
                        document.getElementById(tabId).classList.add('active');
                    });
                });
                
                // Modal functionality
                const modals = document.querySelectorAll('.modal');
                const closeButtons = document.querySelectorAll('.close-modal, .close-btn');
                
                // View details button
                const viewDetailsButtons = document.querySelectorAll('.view-details-btn');
                viewDetailsButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        const bookingId = button.getAttribute('data-id');
                        openBookingDetails(bookingId);
                    });
                });
                
                // Reschedule buttons
                const rescheduleButtons = document.querySelectorAll('.reschedule-btn');
                rescheduleButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        document.getElementById('rescheduleModal').style.display = 'block';
                    });
                });
                
                // Cancel buttons
                const cancelButtons = document.querySelectorAll('.cancel-btn');
                cancelButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        document.getElementById('cancelBookingModal').style.display = 'block';
                    });
                });
                
                // Close modal
                closeButtons.forEach(button => {
                    button.addEventListener('click', () => {
                        modals.forEach(modal => {
                            modal.style.display = 'none';
                        });
                    });
                });
                
                // Close modal when clicking outside
                window.addEventListener('click', (e) => {
                    modals.forEach(modal => {
                        if (e.target === modal) {
                            modal.style.display = 'none';
                        }
                    });
                });
                
                // Handle other reason in cancel form
                const cancelReasonSelect = document.querySelector('select[name="cancelReason"]');
                const otherReasonGroup = document.getElementById('otherReasonGroup');
                
                if (cancelReasonSelect) {
                    cancelReasonSelect.addEventListener('change', () => {
                        if (cancelReasonSelect.value === 'other') {
                            otherReasonGroup.style.display = 'block';
                        } else {
                            otherReasonGroup.style.display = 'none';
                        }
                    });
                }
                
                // Submit handlers for the modals
                const submitRescheduleBtn = document.querySelector('.submit-reschedule');
                if (submitRescheduleBtn) {
                    submitRescheduleBtn.addEventListener('click', () => {
                        const form = document.getElementById('rescheduleForm');
                        if (form.checkValidity()) {
                            // Here you would submit the form data to the server
                            alert('Booking rescheduled successfully! A confirmation email has been sent.');
                            document.getElementById('rescheduleModal').style.display = 'none';
                        } else {
                            form.reportValidity();
                        }
                    });
                }
                
                const confirmCancelBtn = document.querySelector('.confirm-cancel');
                if (confirmCancelBtn) {
                    confirmCancelBtn.addEventListener('click', () => {
                        const form = document.getElementById('cancelForm');
                        if (form.checkValidity()) {
                            // Here you would submit the form data to the server
                            alert('Booking cancelled successfully! A confirmation email has been sent.');
                            document.getElementById('cancelBookingModal').style.display = 'none';
                            
                            // In a real app, you might want to reload the page or update the UI
                            // window.location.reload();
                        } else {
                            form.reportValidity();
                        }
                    });
                }
                
                // Function to fetch and display booking details
                function openBookingDetails(bookingId) {
                    const modal = document.getElementById('bookingDetailsModal');
                    const contentDiv = modal.querySelector('.booking-details-content');
                    
                    // In a real app, you would fetch this data from the server
                    // For demo purposes, we'll use static HTML
                    
                    const detailsHTML = `
                        <div class="booking-details">
                            <div class="details-section">
                                <h3>Booking Information</h3>
                                <div class="details-grid">
                                    <div class="details-item">
                                        <span class="details-label">Booking ID</span>
                                        <span class="details-value">${bookingId}</span>
                                    </div>
                                    <div class="details-item">
                                        <span class="details-label">Booking Type</span>
                                        <span class="details-value">${bookingId.startsWith('TD') ? 'Test Drive' : 'Service'}</span>
                                    </div>
                                    <div class="details-item">
                                        <span class="details-label">Date</span>
                                        <span class="details-value">June 5, 2025</span>
                                    </div>
                                    <div class="details-item">
                                        <span class="details-label">Time</span>
                                        <span class="details-value">10:30 AM</span>
                                    </div>
                                    <div class="details-item">
                                        <span class="details-label">Status</span>
                                        <span class="details-value">Confirmed</span>
                                    </div>
                                    <div class="details-item">
                                        <span class="details-label">Created On</span>
                                        <span class="details-value">May 25, 2025</span>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="details-section">
                                <h3>Location</h3>
                                <p>DriverXO Showroom - Downtown<br>
                                123 Main Street, Ho Chi Minh City<br>
                                Contact: (555) 123-4567</p>
                                <div class="map-placeholder" style="height: 200px; background-color: #f5f5f5; display: flex; align-items: center; justify-content: center; border-radius: 8px; margin-top: 10px;">
                                    <span>Map Placeholder</span>
                                </div>
                            </div>
                            
                            <div class="details-section">
                                <h3>Vehicle Information</h3>
                                <div class="car-details" style="margin-top: 15px;">
                                    <div class="car-image">
                                        <img src="asset/img/cars/camry-explorer.png" alt="Chevrolet CamFó Explorer">
                                    </div>
                                    <div class="car-info">
                                        <h4>Chevrolet CamFó Explorer</h4>
                                        <span class="car-brand">Chevrolet</span>
                                        <p style="margin-top: 5px;">2019 Model | Gasoline | Automatic</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    `;
                    
                    contentDiv.innerHTML = detailsHTML;
                    modal.style.display = 'block';
                }
                
                // Add to calendar button
                const addToCalendarBtn = document.querySelector('.add-to-calendar');
                if (addToCalendarBtn) {
                    addToCalendarBtn.addEventListener('click', () => {
                        // In a real app, this would generate an iCal file or use a calendar API
                        alert('Calendar event created successfully!');
                    });
                }
                
                // View detail buttons should redirect to order-detail.jsp
                const detailButtons = document.querySelectorAll('.view-details-btn');
                detailButtons.forEach(button => {
                    button.addEventListener('click', function(e) {
                        const bookingId = this.getAttribute('data-id');
                        // In a real app, we would use the ID to fetch the correct booking
                        // For demo purposes, we'll just show the modal
                        // In production, this would redirect to order-detail.jsp
                        // window.location.href = `order-detail?id=${bookingId}`;
                    });
                });
            });
        </script>
    </body>
</html> 