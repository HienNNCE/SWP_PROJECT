<%-- 
    Document   : profile
    Created on : May 28, 2025, 09:15:00 AM
    Author     : giahuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        </style>
    </head>
    <body>
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
                            <h3 class="profile-name">John Doe</h3>
                            <div class="profile-member-since">Member since May 2025</div>
                        </div>
                        <div class="profile-nav">
                            <a href="#" class="profile-nav-item active" data-tab="personal-info">
                                <i class="fas fa-user"></i> Personal Information
                            </a>
                            <a href="#" class="profile-nav-item" data-tab="addresses">
                                <i class="fas fa-map-marker-alt"></i> Addresses
                            </a>
                            <a href="#" class="profile-nav-item" data-tab="security">
                                <i class="fas fa-lock"></i> Security
                            </a>
                            <a href="#" class="profile-nav-item" data-tab="notifications">
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
                            </a>
                            <a href="#" class="profile-nav-item">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </div>
                    
                    <!-- Profile Content -->
                    <div class="profile-content">
                        <!-- Personal Information Tab -->
                        <div class="tab-content active" id="personal-info">
                            <h2 class="profile-section-title">Personal Information</h2>
                            <form class="profile-form">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" class="form-control" id="firstName" value="John">
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" value="Doe">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email Address</label>
                                    <input type="email" class="form-control" id="email" value="john.doe@example.com">
                                </div>
                                <div class="form-group">
                                    <label for="phone">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" value="+1 (555) 123-4567">
                                </div>
                                <div class="form-group">
                                    <label for="dob">Date of Birth</label>
                                    <input type="date" class="form-control" id="dob" value="1990-01-15">
                                </div>
                                <div class="form-group">
                                    <label for="gender">Gender</label>
                                    <select class="form-control" id="gender">
                                        <option value="male" selected>Male</option>
                                        <option value="female">Female</option>
                                        <option value="other">Other</option>
                                        <option value="prefer-not">Prefer not to say</option>
                                    </select>
                                </div>
                                <div class="form-group form-full-width">
                                    <label for="bio">About Me (Optional)</label>
                                    <textarea class="form-control" id="bio" rows="4">Car enthusiast with a passion for luxury vehicles. I've been a collector for over 10 years.</textarea>
                                </div>
                                <div class="profile-actions form-full-width">
                                    <button type="button" class="btn btn-secondary">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>
                        
                        <!-- Addresses Tab -->
                        <div class="tab-content" id="addresses">
                            <h2 class="profile-section-title">My Addresses</h2>
                            <div class="address-list">
                                <!-- Default Address -->
                                <div class="address-card">
                                    <h4>Home Address <span class="badge primary-badge">Default</span></h4>
                                    <p>John Doe<br>
                                    123 Main Street<br>
                                    Apt 4B<br>
                                    New York, NY 10001<br>
                                    United States<br>
                                    Phone: (555) 123-4567</p>
                                    <div class="address-actions">
                                        <button class="address-btn edit-address">Edit</button>
                                        <button class="address-btn delete-address">Delete</button>
                                    </div>
                                </div>
                                
                                <!-- Secondary Address -->
                                <div class="address-card">
                                    <h4>Office Address</h4>
                                    <p>John Doe<br>
                                    456 Business Ave<br>
                                    Suite 200<br>
                                    New York, NY 10018<br>
                                    United States<br>
                                    Phone: (555) 987-6543</p>
                                    <div class="address-actions">
                                        <button class="address-btn edit-address">Edit</button>
                                        <button class="address-btn delete-address">Delete</button>
                                    </div>
                                </div>
                                
                                <button class="add-address">
                                    <i class="fas fa-plus"></i> Add New Address
                                </button>
                            </div>
                        </div>
                        
                        <!-- Security Tab -->
                        <div class="tab-content" id="security">
                            <h2 class="profile-section-title">Security Settings</h2>
                            <div class="password-form">
                                <div class="form-group">
                                    <label for="currentPassword">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword">
                                </div>
                                <div class="form-group">
                                    <label for="newPassword">New Password</label>
                                    <input type="password" class="form-control" id="newPassword">
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword">
                                </div>
                                <div class="profile-actions">
                                    <button type="button" class="btn btn-secondary">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Update Password</button>
                                </div>
                                
                                <div class="delete-account">
                                    <h3 class="profile-section-title">Delete Account</h3>
                                    <p>Once you delete your account, there is no going back. Please be certain.</p>
                                    <button class="delete-account-btn">Delete My Account</button>
                                </div>
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
                                    John Doe<br>
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
                                    John Doe</p>
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
            document.addEventListener('DOMContentLoaded', function() {
                // Tab functionality
                const tabLinks = document.querySelectorAll('.profile-nav-item[data-tab]');
                const tabContents = document.querySelectorAll('.tab-content');
                
                tabLinks.forEach(link => {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        
                        // Remove active class from all tabs
                        tabLinks.forEach(tab => tab.classList.remove('active'));
                        tabContents.forEach(content => content.classList.remove('active'));
                        
                        // Add active class to current tab
                        this.classList.add('active');
                        
                        // Show corresponding content
                        const tabId = this.getAttribute('data-tab');
                        document.getElementById(tabId).classList.add('active');
                    });
                });
                
                // Address form toggle
                const addAddressBtn = document.querySelector('.add-address');
                if (addAddressBtn) {
                    addAddressBtn.addEventListener('click', function() {
                        // Here you would typically show an address form
                        // For this demo, just show an alert
                        alert('Address form would appear here');
                    });
                }
                
                // Edit address buttons
                const editAddressBtns = document.querySelectorAll('.edit-address');
                editAddressBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // Here you would typically show the edit form for this address
                        // For this demo, just show an alert
                        alert('Edit address form would appear here');
                    });
                });
                
                // Delete address buttons
                const deleteAddressBtns = document.querySelectorAll('.delete-address');
                deleteAddressBtns.forEach(btn => {
                    btn.addEventListener('click', function() {
                        // Here you would typically show a confirmation dialog
                        // For this demo, just show an alert
                        if (confirm('Are you sure you want to delete this address?')) {
                            // Delete action
                            console.log('Address deleted');
                        }
                    });
                });
                
                // Delete account button
                const deleteAccountBtn = document.querySelector('.delete-account-btn');
                if (deleteAccountBtn) {
                    deleteAccountBtn.addEventListener('click', function() {
                        // Show confirmation dialog
                        if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
                            // Delete account action
                            console.log('Account deletion requested');
                        }
                    });
                }
            });
        </script>
    </body>
</html> 