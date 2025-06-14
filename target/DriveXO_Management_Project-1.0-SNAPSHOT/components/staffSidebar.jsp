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
                <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="Staff Avatar">
            </div>
            <div class="user-info">
                <h6>Welcome back,</h6>
                <p>Staff User</p>
            </div>
        </div>

        <ul class="sidebar-nav">
            <li class="nav-section">
                <span class="nav-section-text">MANAGEMENT</span>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/car.jsp" class="nav-link">
                    <i class="fas fa-car"></i>
                    <span>Cars</span>
                    <span class="badge badge-warning">8</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/part" class="nav-link">
                    <i class="fas fa-cogs"></i>
                    <span>Parts</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/user.jsp" class="nav-link">
                    <i class="fas fa-users"></i>
                    <span>Users</span>
                    <span class="badge badge-info">24</span>
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/staff/order.jsp" class="nav-link">
                    <i class="fas fa-shopping-cart"></i>
                    <span>Orders</span>
                    <span class="badge badge-danger">3</span>
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
