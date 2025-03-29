<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Train Management System</title>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/managehomepagecss.css">
</head>
<body>
    <aside class="sidebar">
            <div class="sidebar-header">
                <h5 class="sidebar-title"><i class="fas fa-train"></i> Manager Panel</h5>
            </div>
            <div class="sidebar-divider"></div>
            <ul class="nav-list">
                <li class="nav-item">
                    <a href="ManagerHomePage.jsp" class="nav-link">
                        <i class="fas fa-chart-line"></i>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-users"></i>
                        <span>Manage Seller</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="listtrain" class="nav-link active">
                        <i class="fas fa-subway"></i>
                        <span>Manage Trains</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="fas fa-route"></i>
                        <span>Manage Station</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="manager-profile" class="nav-link">
                        <i class="fas fa-user-circle"></i>
                        <span>Account</span>
                    </a>
                </li>
                <li class="nav-item">
                        <a href="./logout" class="nav-link text-danger">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                </li>
            </ul>
        </aside>
    <div class="content">
        <h1 class="page-title">
            <i class="fas fa-chart-pie"></i>
            Dashboard
        </h1>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Total Trains</div>
                    <div class="stat-icon"><i class="fas fa-train"></i></div>
                </div>
                <div class="stat-value">24</div>
                <div class="stat-description">Active trains in system</div>
                <div class="stat-footer trend-up">+2 from last period</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Active Routes</div>
                    <div class="stat-icon"><i class="fas fa-route"></i></div>
                </div>
                <div class="stat-value">42</div>
                <div class="stat-description">Routes currently in service</div>
                <div class="stat-footer trend-up">+5 from last period</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Total Users</div>
                    <div class="stat-icon"><i class="fas fa-users"></i></div>
                </div>
                <div class="stat-value">2,845</div>
                <div class="stat-description">Registered passengers</div>
                <div class="stat-footer trend-up">+124 from last period</div>
            </div>

            <div class="stat-card">
                <div class="stat-header">
                    <div class="stat-title">Bookings</div>
                    <div class="stat-icon"><i class="fas fa-ticket-alt"></i></div>
                </div>
                <div class="stat-value">1,254</div>
                <div class="stat-description">This month</div>
                <div class="stat-footer trend-up">+18% from last period</div>
            </div>
        </div>

        <div class="charts-grid">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Revenue Overview</h5>
                    <i class="fas fa-chart-line"></i>
                </div>
                <div class="card-body">
                    <div class="chart-placeholder">
                        Revenue chart visualization
                    </div>
                    <div style="margin-top: 1rem; font-size: 0.875rem; color: var(--gray-600);">
                        +20.1% from last month
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Popular Routes</h5>
                    <i class="fas fa-map-marked-alt"></i>
                </div>
                <div class="card-body">
                    <div class="route-item">
                        <div>
                            <div class="route-name">Hanoi - Ho Chi Minh City</div>
                            <div class="route-bookings">428 bookings</div>
                        </div>
                        <div class="route-trend trend-up">
                            <i class="fas fa-arrow-up" style="margin-right: 0.25rem;"></i> 12%
                        </div>
                    </div>
                    <div class="route-item">
                        <div>
                            <div class="route-name">Da Nang - Hue</div>
                            <div class="route-bookings">327 bookings</div>
                        </div>
                        <div class="route-trend trend-up">
                            <i class="fas fa-arrow-up" style="margin-right: 0.25rem;"></i> 8%
                        </div>
                    </div>
                    <div class="route-item">
                        <div>
                            <div class="route-name">Ho Chi Minh City - Nha Trang</div>
                            <div class="route-bookings">256 bookings</div>
                        </div>
                        <div class="route-trend trend-up">
                            <i class="fas fa-arrow-up" style="margin-right: 0.25rem;"></i> 5%
                        </div>
                    </div>
                    <div class="route-item">
                        <div>
                            <div class="route-name">Hanoi - Hai Phong</div>
                            <div class="route-bookings">198 bookings</div>
                        </div>
                        <div class="route-trend trend-up">
                            <i class="fas fa-arrow-up" style="margin-right: 0.25rem;"></i> 3%
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="cards-grid">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Recent Maintenance</h5>
                </div>
                <div class="card-body">
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE1</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">2023-03-25</div>
                        </div>
                        <div style="color: var(--success); font-size: 0.875rem;">Completed</div>
                    </div>
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE3</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">2023-03-24</div>
                        </div>
                        <div style="color: var(--warning); font-size: 0.875rem;">Pending</div>
                    </div>
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE7</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">2023-03-22</div>
                        </div>
                        <div style="color: var(--success); font-size: 0.875rem;">Completed</div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">Upcoming Departures</h5>
                </div>
                <div class="card-body">
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE2</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">Hanoi - Ho Chi Minh City</div>
                        </div>
                        <div style="font-size: 0.875rem; font-weight: 500;">08:00</div>
                    </div>
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE4</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">Da Nang - Hue</div>
                        </div>
                        <div style="font-size: 0.875rem; font-weight: 500;">09:15</div>
                    </div>
                    <div class="list-item">
                        <div>
                            <div style="font-weight: 500;">Train SE8</div>
                            <div style="font-size: 0.875rem; color: var(--gray-600);">Ho Chi Minh City - Nha Trang</div>
                        </div>
                        <div style="font-size: 0.875rem; font-weight: 500;">10:30</div>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">System Status</h5>
                </div>
                <div class="card-body">
                    <div class="list-item">
                        <div style="display: flex; align-items: center;">
                            <span class="status-indicator status-operational"></span>
                            <span style="font-weight: 500;">Booking System</span>
                        </div>
                        <div style="font-size: 0.875rem;">Operational</div>
                    </div>
                    <div class="list-item">
                        <div style="display: flex; align-items: center;">
                            <span class="status-indicator status-operational"></span>
                            <span style="font-weight: 500;">Train Tracking</span>
                        </div>
                        <div style="font-size: 0.875rem;">Operational</div>
                    </div>
                    <div class="list-item">
                        <div style="display: flex; align-items: center;">
                            <span class="status-indicator status-operational"></span>
                            <span style="font-weight: 500;">User Authentication</span>
                        </div>
                        <div style="font-size: 0.875rem;">Operational</div>
                    </div>
                    <div class="list-item">
                        <div style="display: flex; align-items: center;">
                            <span class="status-indicator status-degraded"></span>
                            <span style="font-weight: 500;">Payment Processing</span>
                        </div>
                        <div style="font-size: 0.875rem;">Degraded</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for navigation highlighting -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Get all navigation links
            const navLinks = document.querySelectorAll('.nav-link');
            
            // Add click event listener to each navigation link
            navLinks.forEach(link => {
                link.addEventListener('click', function(e) {
                    // If the link doesn't have an actual destination (href="#"), prevent default
                    if (this.getAttribute('href') === '#') {
                        e.preventDefault();
                    }
                    
                    // Remove active class from all links
                    navLinks.forEach(navLink => {
                        navLink.classList.remove('active');
                    });
                    
                    // Add active class to the clicked link
                    this.classList.add('active');
                });
            });
            
            // Check if there's a current page in the URL and highlight the corresponding nav item
            const currentPage = window.location.pathname.split('/').pop();
            
            if (currentPage) {
                navLinks.forEach(link => {
                    const href = link.getAttribute('href');
                    if (href && href.includes(currentPage)) {
                        // Remove active class from all links
                        navLinks.forEach(navLink => {
                            navLink.classList.remove('active');
                        });
                        
                        // Add active class to the matching link
                        link.classList.add('active');
                    }
                });
            }
        });
    </script>
</body>
</html>

