<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="sidebar-header">
        <a href="#" class="logo-link">
            <img src="${pageContext.request.contextPath}/asset/img/driverxo-logo-white.png" alt="DriverXO" class="logo-icon">
            <span>DriverXO</span>
        </a>
    </div>

    <div class="sidebar-body">
        <div class="user-panel">
            <div class="user-image">
                <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="Admin Avatar">
            </div>
            <div class="user-info">
                <h6>Welcome back,</h6>
                <p>Admin User</p>
            </div>
        </div>

        <ul class="sidebar-nav">
            <li class="nav-section">
                <span class="nav-section-text">MAIN NAVIGATION</span>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link active">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                    <span class="badge badge-primary">New</span>
                </a>
            </li>

            <li class="nav-section">
                <span class="nav-section-text">MANAGEMENT</span>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/car" class="nav-link">
                    <i class="fas fa-car"></i>
                    <span>Cars</span>
                    <span class="badge badge-info">${sessionScope.countUsers}</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/users" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                    <span class="badge badge-info">24</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/part" class="nav-link">
                    <i class="fas fa-cogs"></i>
                    <span>Parts</span>
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/comments" class="nav-link">
                    <i class="fas fa-cogs"></i>
                    <span>Comments</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/service" class="nav-link">
                    <i class="fas fa-wrench"></i>
                    <span>Services</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/serviceAppointment" class="nav-link">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Service Appt</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/carAppointment" class="nav-link">
                    <i class="fas fa-calendar-alt"></i>
                    <span>Car Apppt</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-credit-card"></i>
                    <span>Payments</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/blog" class="nav-link">
                    <i class="fas fa-newspaper"></i>
                    <span>Blog/Posts</span>
                </a>
            </li>


            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-exchange-alt"></i>
                    <span>Transactions</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/OrderManagementServlet" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Orders</span>
                    <span class="badge badge-danger">${sessionScope.totalOrders}</span>
                </a>
            </li>

            <li class="nav-section">
                <span class="nav-section-text">EXTRAS</span>
            </li>

            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    <span>Feedback</span>
                </a>
            </li>


            <li class="nav-item">
                <a href="#" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
        </ul>


    </div>
</div> 