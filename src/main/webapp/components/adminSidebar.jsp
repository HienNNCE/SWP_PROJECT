<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="sidebar">
    <div class="sidebar-header">
        <a href="${pageContext.request.contextPath}/home" class="logo-link">
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
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="nav-link">
                    <i class="fas fa-tachometer-alt"></i>
                    <span>Dashboard</span>
                </a>
            </li>

            <li class="nav-section">
                <span class="nav-section-text">MANAGEMENT</span>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/car.jsp" class="nav-link">
                    <i class="fas fa-car"></i>
                    <span>Cars</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/part" class="nav-link">
                    <i class="fas fa-cogs"></i>
                    <span>Parts</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/user.jsp" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/order.jsp" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Orders</span>
                </a>
            </li>

            <li class="nav-section">
                <span class="nav-section-text">EXTRAS</span>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/reports.jsp" class="nav-link">
                    <i class="fas fa-chart-bar"></i>
                    <span>Feedback</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/admin/settings.jsp" class="nav-link">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
                </a>
            </li>
        </ul>

        <div class="sidebar-footer">
            <div class="version">
                <i class="fas fa-code-branch"></i>
                <span>Version 1.0.0</span>
            </div>
        </div>
    </div>
</div>
