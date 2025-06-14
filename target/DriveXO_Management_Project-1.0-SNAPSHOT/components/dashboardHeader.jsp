<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header">
    <nav class="navbar">
        <!-- Toggle Sidebar Button -->
        <button class="sidebar-toggle">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Right navbar links -->
        <ul class="navbar-nav">
            <!-- Notifications -->
            <li class="nav-item dropdown">
                <a class="nav-link" data-toggle="dropdown" href="#">
                    <i class="fas fa-bell"></i>
                    <span class="badge badge-danger">3</span>
                </a>
                <div class="dropdown-menu dropdown-menu-lg">
                    <span class="dropdown-header">3 NEW NOTIFICATIONS</span>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-envelope text-primary"></i> 4 new messages
                        <span class="float-right text-muted text-sm">3 mins</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-users text-warning"></i> 8 friend requests
                        <span class="float-right text-muted text-sm">12 hours</span>
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-file text-danger"></i> 3 new reports
                        <span class="float-right text-muted text-sm">2 days</span>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-footer">See All Notifications</a>
                </div>
            </li>

            <!-- User Account -->
            <li class="nav-item dropdown user-menu">
                <a class="nav-link user-profile" data-toggle="dropdown" href="#">
                    <img src="../asset/img/avt/adminavt.png" alt="Admin Avatar" class="user-image">
                    <div class="user-info">
                        <span class="user-name">Admin User</span>
                        <span class="user-role">Administrator</span>
                    </div>
                </a>
                <div class="dropdown-menu">
                    <div class="dropdown-header-img">
                        <img src="../asset/img/avt/adminavt.png" alt="Admin Avatar">
                        <p>Admin User</p>
                        <small>Member since Nov. 2025</small>
                    </div>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-user"></i> My Profile
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="fas fa-cog"></i> Settings
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="../auth/login.jsp" class="dropdown-item text-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </li>
        </ul>
    </nav>
</header> 