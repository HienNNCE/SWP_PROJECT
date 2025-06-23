<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DriverXO Admin</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="../asset/css/style.css">
    <link rel="stylesheet" href="../asset/css/adminstyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/apexcharts@3.45.1/dist/apexcharts.min.css" rel="stylesheet">
</head>
<body class="admin-panel">
    <!-- Sidebar -->
    <jsp:include page="../components/staffSidebar.jsp" />

    <!-- Main Content -->
    <div class="main-content">
        <!-- Header -->
        <jsp:include page="../components/dashboardHeader.jsp" />

        <!-- Content -->
        <div class="content">
            <!-- Content Header -->
            <div class="content-header">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col">
                            <h1 class="page-title">Dashboard Overview</h1>
                            
                        </div>
                        <div class="col-auto">
                            <div class="date-range-picker">
                                <i class="fas fa-calendar"></i>
                                <span>Last 30 days</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="container-fluid">
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stats-card primary">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Cars</h5>
                                <div class="stats-icon">
                                    <i class="fas fa-car"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalCars}</h3>
                                    <div class="stats-trend positive">
                                        <i class="fas fa-arrow-up"></i>
                                        <span>3.48%</span>
                                        <span class="trend-label">vs last month</span>
                                    </div>
                                </div>
                            </div>
                            <div class="stats-chart" id="carsChart"></div>
                        </div>
                    </div>

                    <div class="stats-card info">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Active Users</h5>
                                    <div class="stats-icon">
                                    <i class="fas fa-users"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${activeUsers} / ${totalUsers}</h3>
                                    <div class="stats-trend positive">
                                        <i class="fas fa-arrow-up"></i>
                                        <span>5.27%</span>
                                        <span class="trend-label">vs last month</span>
                                    </div>
                                </div>
                            </div>
                            <div class="stats-chart" id="usersChart"></div>
                        </div>
                    </div>

                    <div class="stats-card success">
                        <div class="stats-card-content">
                                <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Orders</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-shopping-cart"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalOrders}</h3>
                                    <div class="stats-trend negative">
                                        <i class="fas fa-arrow-down"></i>
                                        <span>1.08%</span>
                                        <span class="trend-label">vs last month</span>
                                    </div>
                                </div>
                            </div>
                            <div class="stats-chart" id="ordersChart"></div>
                        </div>
                    </div>

                    <div class="stats-card warning">
                        <div class="stats-card-content">
                                <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Revenue</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-dollar-sign"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>$<c:out value="${totalRevenue}" /></h3>
                                    <div class="stats-trend positive">
                                        <i class="fas fa-arrow-up"></i>
                                        <span>8.32%</span>
                                        <span class="trend-label">vs last month</span>
                                    </div>
                                </div>
                            </div>
                            <div class="stats-chart" id="revenueChart"></div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="dashboard-grid">
                    <!-- Sales Overview -->
                    <div class="dashboard-item sales-overview">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-header-left">
                                <h5 class="card-title">Sales Overview</h5>
                                    <span class="card-subtitle">Monthly revenue statistics</span>
                                </div>
                                
                            </div>
                            <div class="card-body">
                                <div id="salesOverviewChart"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Top Selling Cars -->
                    <div class="dashboard-item top-selling">
                        <div class="card">
                            <div class="card-header">
                                <div class="card-header-left">
                                <h5 class="card-title">Top Selling Cars</h5>
                                    <span class="card-subtitle">Best performing vehicles</span>
                                </div>
                                <div class="card-header-right">
                                    <button class="btn btn-light btn-sm">
                                        View All <i class="fas fa-arrow-right"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="top-selling-list">
                                    <div class="top-selling-item">
                                        <div class="item-info">
                                            <img src="../asset/img/cars/camry-explorer.png" alt="Car">
                                            <div class="item-details">
                                            <h6>Chevrolet CamFó Explorer</h6>
                                                <span class="text-muted">Luxury Sedan</span>
                                            </div>
                                        </div>
                                        <div class="item-stats">
                                            <div class="stats-progress">
                                                <div class="progress">
                                                    <div class="progress-bar" style="width: 75%"></div>
                                                </div>
                                                <span>75%</span>
                                            </div>
                                            <div class="stats-numbers">
                                                <span class="sales">32 Sales</span>
                                                <span class="price">$120,000</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="top-selling-item">
                                        <div class="item-info">
                                            <img src="../asset/img/cars/alfa-romeo.png" alt="Car">
                                            <div class="item-details">
                                            <h6>Nissan Alfa Romeo</h6>
                                                <span class="text-muted">Sports Car</span>
                                            </div>
                                        </div>
                                        <div class="item-stats">
                                            <div class="stats-progress">
                                                <div class="progress">
                                                    <div class="progress-bar" style="width: 65%"></div>
                                                </div>
                                                <span>65%</span>
                                            </div>
                                            <div class="stats-numbers">
                                                <span class="sales">28 Sales</span>
                                                <span class="price">$180,000</span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="top-selling-item">
                                        <div class="item-info">
                                            <img src="../asset/img/cars/atra-benz-yellow.png" alt="Car">
                                            <div class="item-details">
                                            <h6>Chevrolet Altra Benz</h6>
                                                <span class="text-muted">Premium SUV</span>
                                            </div>
                                        </div>
                                        <div class="item-stats">
                                            <div class="stats-progress">
                                                <div class="progress">
                                                    <div class="progress-bar" style="width: 45%"></div>
                                                </div>
                                                <span>45%</span>
                                            </div>
                                            <div class="stats-numbers">
                                                <span class="sales">24 Sales</span>
                                                <span class="price">$500,000</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Orders -->
                <div class="card recent-orders">
                            <div class="card-header">
                        <div class="card-header-left">
                                <h5 class="card-title">Recent Orders</h5>
                            <span class="card-subtitle">Latest transactions</span>
                        </div>
                        <div class="card-header-right">
                            <div class="card-actions">
                                <div class="search-box">
                                    <i class="fas fa-search"></i>
                                    <input type="text" placeholder="Search orders...">
                                </div>
                            </div>
                        </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                            <table class="table">
                                        <thead>
                                            <tr>
                                        <th>
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input">
                                            </div>
                                        </th>
                                                <th>Order ID</th>
                                                <th>Customer</th>
                                                <th>Car</th>
                                                <th>Date</th>
                                                <th>Amount</th>
                                                <th>Status</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="order" items="${latestOrders}">
                                            <tr>
                                        <td>
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input">
                                            </div>
                                        </td>
                                        <td>
                                                        <span class="order-id">#ORD-${order.orderId}</span>
                                        </td>
                                        <td>
                                            <div class="customer-info">
                                                <img src="../asset/img/avt/adminavt.png" alt="Customer">
                                                            <span>User ID: ${order.userId}</span>
                                                    </div>
                                                </td>
                                                    <td>Car ID: ${order.carId}</td>
                                        <td>
                                            <div class="order-date">
                                                            <span class="date"><c:out value="${order.orderDate}" /></span>
                                                            <span class="time">N/A</span>
                                                    </div>
                                                </td>
                                        <td>
                                                        <span class="order-amount">$<c:out value="${order.orderPrice}" /></span>
                                        </td>
                                        <td>
                                                        <span class="badge badge-<c:choose><c:when test="${order.orderStatus == 'Completed'}">success</c:when><c:when test="${order.orderStatus == 'Pending'}">warning</c:when><c:when test="${order.orderStatus == 'Processing'}">info</c:when><c:else>secondary</c:else></c:choose>">${order.orderStatus}</span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn btn-icon btn-light" title="View">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn btn-icon btn-light" title="Edit">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <button class="btn btn-icon btn-light" title="Delete">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                                    </div>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                    <div class="card-footer">
                        <div class="pagination-info">
                            Showing 1 to 10 of 50 entries
                        </div>
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#"><i class="fas fa-chevron-left"></i></a>
                            </li>
                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#"><i class="fas fa-chevron-right"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="../components/dashboardFooter.jsp" />
    </div>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts@3.45.1/dist/apexcharts.min.js"></script>
    <script>
        $(document).ready(function() {
            // Toggle Sidebar
            $('.sidebar-toggle').on('click', function() {
                $('.admin-panel').toggleClass('sidebar-mini');
            });

            // Dropdown Toggle
            $('.dropdown-toggle').on('click', function(e) {
                e.preventDefault();
                $(this).next('.dropdown-menu').toggleClass('show');
            });

            // Close dropdowns when clicking outside
            $(document).on('click', function(e) {
                if (!$(e.target).closest('.dropdown').length) {
                    $('.dropdown-menu').removeClass('show');
                }
            });

            // Initialize Charts
            // Stats Mini Charts
            const miniChartOptions = {
                chart: {
                    type: 'area',
                    height: 60,
                    sparkline: {
                        enabled: true
                    },
                    toolbar: {
                        show: false
                    }
                },
                stroke: {
                    curve: 'smooth',
                    width: 2
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shadeIntensity: 1,
                        opacityFrom: 0.7,
                        opacityTo: 0.3
                    }
                },
                series: [{
                    name: 'Value',
                    data: [25, 66, 41, 89, 63, 25, 44, 12, 36, 9, 54]
                }],
                tooltip: {
                    fixed: {
                        enabled: false
                    },
                    x: {
                        show: false
                    },
                    y: {
                        title: {
                            formatter: function(seriesName) {
                                return '';
                            }
                        }
                    },
                    marker: {
                        show: false
                    }
                }
            };

            // Initialize mini charts
            new ApexCharts(document.querySelector("#carsChart"), {
                ...miniChartOptions,
                colors: ['#072eb0']
            }).render();

            new ApexCharts(document.querySelector("#usersChart"), {
                ...miniChartOptions,
                colors: ['#17a2b8']
            }).render();

            new ApexCharts(document.querySelector("#ordersChart"), {
                ...miniChartOptions,
                colors: ['#28a745']
            }).render();

            new ApexCharts(document.querySelector("#revenueChart"), {
                ...miniChartOptions,
                colors: ['#ffc107']
            }).render();

            // Sales Overview Chart
            new ApexCharts(document.querySelector("#salesOverviewChart"), {
                chart: {
                    type: 'area',
                    height: 350,
                    toolbar: {
                        show: false
                    }
                },
                series: [{
                    name: 'Sales',
                    data: [31, 40, 28, 51, 42, 109, 100]
                }, {
                    name: 'Revenue',
                    data: [11, 32, 45, 32, 34, 52, 41]
                }],
                xaxis: {
                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul']
                },
                colors: ['#072eb0', '#28a745'],
                stroke: {
                    curve: 'smooth',
                    width: 2
                },
                fill: {
                    type: 'gradient',
                    gradient: {
                        shadeIntensity: 1,
                        opacityFrom: 0.7,
                        opacityTo: 0.3
                    }
                },
                dataLabels: {
                    enabled: false
                },
                grid: {
                    borderColor: '#f1f1f1',
                    padding: {
                        left: 10,
                        right: 10
                    }
                },
                legend: {
                    position: 'top',
                    horizontalAlign: 'right'
                }
            }).render();
        });
    </script>
</body>
</html> 