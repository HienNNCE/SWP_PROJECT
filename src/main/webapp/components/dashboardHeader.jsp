<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header class="header">
    <nav class="navbar">

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
                <a class="nav-link user-profile dropdown-toggle" data-toggle="dropdown" href="#">
                    <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="Admin Avatar" class="user-image">
                    <div class="user-info">
                        <span class="user-name">Admin User</span>
                        <span class="user-role">Administrator</span>
                    </div>
                </a>
                <div class="dropdown-menu">
                    <!--                    <div class="dropdown-header-img">
                                            <img src="${pageContext.request.contextPath}/asset/img/avt/adminavt.png" alt="Admin Avatar">
                                            <p>Admin User</p>
                                            <small>Member since Nov. 2025</small>
                                        </div>
                                        <div class="dropdown-divider"></div>
                                        <a href="#" class="dropdown-item">
                                            <i class="fas fa-user"></i> My Profile
                                        </a>
                                        <a href="#" class="dropdown-item">
                                            <i class="fas fa-cog"></i> Settings
                                        </a>-->
                    <div class="dropdown-divider"></div>
                    <a href="${pageContext.request.contextPath}/auth/LoginServlet?action=logout" class="dropdown-item text-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </li>
        </ul>
    </nav>
</header>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js"></script>