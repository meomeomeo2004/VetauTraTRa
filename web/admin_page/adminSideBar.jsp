<style>
    .sidebar {
        width: 280px;
        background-color: white;
        padding: 2rem 1.5rem;
        border-right: 1px solid var(--gray-200);
        box-shadow: var(--box-shadow);
        transition: var(--transition);
        height: calc(100vh - 64px);
        position: sticky;
        top: 64px;
        overflow-y: auto;
    }

    .sidebar-header {
        margin-bottom: 2rem;
        text-align: center;
    }

    .sidebar-title {
        font-size: 1.25rem;
        color: var(--primary);
        font-weight: 700;
        margin-bottom: 0.5rem;
    }

    .sidebar-divider {
        height: 1px;
        background-color: var(--gray-200);
        margin: 1rem 0;
    }

    .nav-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .nav-item {
        margin-bottom: 0.5rem;
    }

    .nav-link {
        display: flex;
        align-items: center;
        text-decoration: none;
        color: var(--gray-700);
        font-weight: 500;
        padding: 0.75rem 1rem;
        border-radius: var(--border-radius);
        transition: var(--transition);
    }

    .nav-link:hover, .nav-link.active {
        background-color: var(--primary);
        color: white;
    }

    .nli {
        margin-right: 0.75rem;
        font-size: 1.1rem;
        width: 1.5rem;
        text-align: center;
    }

</style>

<aside class="sidebar">
    <div class="sidebar-header">
        <h5 class="sidebar-title">Administrator Management Page</h5>
    </div>
    <div class="sidebar-divider"></div>
    <ul class="nav-list">
        <li class="nav-item">
            <a href="AdminDashboard" class="nav-link ">
                <i class="fas fa-chart-line nli"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="AccountList" class="nav-link">
                <i class="fas fa-users nli"></i>
                <span>Account List</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="NewsList" class="nav-link ">
                <i class="fas fa-paper-plane nli"></i>
                <span>News Management</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="TransactionLog" class="nav-link">
                <i class="fas fa-bank nli"></i>
                <span>Transactions Log</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="RecordOfChange" class="nav-link">
                <i class="fas fa-wrench nli"></i>
                <span>Record of Change</span>
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="AdminViewProfile">                
                <i class="fas fa-user-circle nli"></i>
                <span>Profile</span>
            </a>
        </li>
        <li class="nav-item">
            <a href="../logout" class="nav-link">
                <i class="fas fa-door-open nli"></i>
                <span>Logout</span>
            </a>
        </li>
    </ul>
</aside>
<script>
    // Get the current URL path
    const currentUrl = window.location.pathname;

    // Select all nav-link elements
    const navLinks = document.querySelectorAll('.nav-link');

    // Loop through each link and check if it matches the current URL
    navLinks.forEach(link => {
        // Get the href attribute of the link
        const linkUrl = link.getAttribute('href');

        // Compare the link URL with the current URL
        if (currentUrl.includes(linkUrl)) {
            link.classList.add('active');
        }
    });
</script>
