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
    <jsp:include page="../components/adminSidebar.jsp" />

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
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card info">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Parts</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-cogs"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalParts}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card success">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Services</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-tools"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalServices}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card warning">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Users</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-users"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalUsers}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card dark">
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
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card info">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Car Appointments</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalCarAppointments}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card success">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Service Appointments</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalServiceAppointments}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card primary">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Blogs</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-blog"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalBlogs}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card warning">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Car Brands</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-flag-checkered"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalCarBrands}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card info">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Car Models</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-car-side"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalCarModels}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card success">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Part Brands</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-industry"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalPartBrands}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="stats-card dark">
                        <div class="stats-card-content">
                            <div class="stats-info">
                                <div class="stats-header">
                                    <h5>Total Service Types</h5>
                                    <div class="stats-icon">
                                        <i class="fas fa-list"></i>
                                    </div>
                                </div>
                                <div class="stats-data">
                                    <h3>${totalServiceTypes}</h3>
                                </div>
                            </div>
                        </div>
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