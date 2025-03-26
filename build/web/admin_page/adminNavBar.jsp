<!--<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark justify-content-between">
     Navbar Brand
    <div style="display: flex; align-items: center">
        <a class="navbar-brand ps-3" href="AdminDashboard">Welcome, Admin</a>
         Sidebar Toggle
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
    </div>
     Navbar
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="#!">Settings</a></li>
                <li><a class="dropdown-item" href="#!">Activity Log</a></li>
                <li><hr class="dropdown-divider" /></li>
                <li><a class="dropdown-item" href="../logout">Logout</a></li>
            </ul>
        </li>
    </ul>
</nav>-->

<style>
    :root {
        --primary: #22577a;
        --primary-dark: #3a56d4;
        --secondary: #2ec4b6;
        --danger: #e63946;
        --warning: #ff9f1c;
        --success: #2a9d8f;
        --info: #4cc9f0;
        --light: #f8f9fa;
        --dark: #212529;
        --gray-100: #f8f9fa;
        --gray-200: #e9ecef;
        --gray-300: #dee2e6;
        --gray-400: #ced4da;
        --gray-500: #adb5bd;
        --gray-600: #6c757d;
        --gray-700: #495057;
        --gray-800: #343a40;
        --gray-900: #212529;
        --border-radius: 0.5rem;
        --box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.08);
        --transition: all 0.3s ease;

        /* Chart colors */
        --chart-1: #4361ee;
        --chart-2: #3a0ca3;
        --chart-3: #7209b7;
        --chart-4: #f72585;
        --chart-5: #4cc9f0;
        --chart-6: #4895ef;
        --chart-7: #560bad;
        --chart-8: #b5179e;
    }
    * {
        padding: 0;
        box-sizing: border-box;
    }

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
        font-family: 'Roboto', sans-serif;
        background-color: var(--gray-100);
        color: var(--gray-800);
    }

    .header {
        width: 100%;
        background-color: var(--primary);
        color: white;
        padding: 1rem 2rem;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: var(--box-shadow);
        position: sticky;
        top: 0;
        z-index: 1000;
    }

    .header-title {
        font-size: 1.5rem;
        font-weight: 700;
        margin: 0;
        letter-spacing: 0.5px;
    }

    .main-content {
        display: flex;
        flex: 1;
    }

    .content {
        flex: 1;
        padding: 2rem;
        max-width: 100%;
    }
    @media (max-width: 992px) {
        .sidebar {
            width: 240px;
        }
    }

    @media (max-width: 768px) {
        .main-content {
            flex-direction: column;
        }

        .sidebar {
            width: 100%;
            height: auto;
            position: relative;
            top: 0;
        }

        .content {
            padding: 1.5rem;
        }

        .card-header {
            flex-direction: column;
            gap: 1rem;
            align-items: flex-start;
        }
    }

    @media (max-width: 576px) {
        .header {
            padding: 1rem;
        }

        .content {
            padding: 1rem;
        }

        .stats-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<header class="header">
    <h1 class="header-title"><i class="fas fa-train" style="margin-right: 0.5rem;"></i> TraTra Train Tickets</h1>
</header>