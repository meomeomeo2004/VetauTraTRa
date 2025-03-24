<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    /* Custom colors */
    :root {
        --navy: #22577a;
        --yellow: #ffbe0b;
        --navy-light: #2c6a92;
        --navy-dark: #1a4258;
        --yellow-light: #ffd04c;
    }

    /* Notification dropdown styling */
    #notifyDropdown {
        position: relative;
    }

    .notification-badge {
        position: absolute;
        top: 0;
        right: -5px;
        background-color: var(--yellow) !important;
        color: var(--navy) !important;
        font-weight: bold;
        border: 2px solid white;
    }

    .notification-header {
        background-color: var(--navy) !important;
        color: white !important;
        border-bottom: none !important;
    }

    .notification-header h6 {
        font-weight: 600;
    }

    .notification-header a {
        color: var(--yellow) !important;
        font-weight: 500;
    }

    .notification-header a:hover {
        text-decoration: underline !important;
    }

    .notification-icon {
        background-color: var(--navy) !important;
        border: 2px solid var(--yellow);
    }

    .notification-item:hover {
        background-color: rgba(34, 87, 122, 0.05) !important;
        border-left: 3px solid var(--yellow) !important;
    }

    .notification-item {
        border-left: 3px solid transparent;
    }

    .notification-title {
        color: var(--navy);
        font-weight: 600;
    }

    .notification-empty {
        color: var(--navy-dark) !important;
    }

    .notification-empty-icon {
        color: var(--navy) !important;
        opacity: 0.5;
    }

    .notification-footer {
        background-color: var(--navy) !important;
        color: white !important;
        border-top: none !important;
    }

    .notification-footer a {
        color: var(--yellow) !important;
        font-weight: 500;
        width: 100%;
    }

    .notification-footer a:hover {
        text-decoration: underline !important;
    }
</style>

<header class="header_area">
    <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light">
            <a class="navbar-brand logo_h" href="/tratra">Tratra</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
                <ul class="nav navbar-nav menu_nav ml-auto">
                    <li class="nav-item active"><a class="nav-link" href="index.html">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="about.html">About us</a></li>
                    <li class="nav-item"><a class="nav-link" href="RouteServlet">Route</a></li>
                    <li class="nav-item"><a class="nav-link" href="VoucherServlet">Voucher</a></li>
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                            <li class="nav-item dropdown">
                                <button class="nav-link dropdown-toggle position-relative" id="notifyDropdown" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa fa-bell"></i> NOTIFY
                                    <c:if test="${not empty newsList && newsList.size() > 0}">
                                        <span class="position-absolute top-0 start-100 mt-4 translate-middle badge rounded-pill bg-danger">
                                            ${newsList.size()}
                                            <span class="visually-hidden">unread notifications</span>
                                        </span>
                                    </c:if>
                                </button>
                                <div class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="notifyDropdown" style="width: 25rem; padding: 0; border-radius: 0.5rem; overflow: hidden; border: none;">
                                    <div class="d-flex justify-content-between align-items-center p-3 notification-header">
                                        <h6 class="m-0">Notifications</h6>
                                        <a href="#" class="text-decoration-none small">Mark all as read</a>
                                    </div>
                                    <div style="max-height: 25rem; overflow-y: auto; overflow-x: hidden">
                                        <c:forEach var="news" items="${newsList}">
                                            <a class="dropdown-item p-3 d-flex align-items-center border-bottom notification-item"
                                               href="news?id=${news.id}" style="transition: all 0.2s ease;">
                                                <div class="me-3 flex-shrink-0">
                                                    <div class="notification-icon text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                        <i class="fa fa-info"></i>
                                                    </div>
                                                </div>
                                                <div class="flex-grow-1 min-width-0">
                                                    <h6 class="mb-1 text-truncate notification-title">${news.title}</h6>
                                                    <p class="text-muted small mb-0">
                                                        <c:if test="${not empty news.createdAt}">
                                                        <fmt:formatDate value="${news.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </c:if>
                                                    <c:if test="${empty news.createdAt}">
                                                        Unknown
                                                    </c:if>
                                                    </p>
                                                </div>
                                            </a>
                                        </c:forEach>

                                        <c:if test="${empty newsList}">
                                            <div class="p-4 text-center notification-empty">
                                                <div class="rounded-circle bg-light d-inline-flex align-items-center justify-content-center mb-3" style="width: 60px; height: 60px;">
                                                    <i class="fa fa-bell-slash notification-empty-icon" style="font-size: 1.5rem;"></i>
                                                </div>
                                                <p class="mb-0">No notifications available</p>
                                            </div>
                                        </c:if>
                                    </div>
                                    <c:if test="${not empty newsList}">
                                        <div class="notification-footer">
                                            <a class="dropdown-item text-center p-3 fw-medium" href="list-news">
                                                View all notifications
                                            </a>
                                        </div>
                                    </c:if>
                                </div>
                            </li>
                            <li class="nav-item dropdown">
                                <button class="nav-link dropdown-toggle d-flex align-items-center h-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                    ACCOUNT
                                </button>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="profile">Profile</a></li>
                                    <li><a class="dropdown-item" href="logout">Logout</a></li>
                                </ul>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="customer/login">Login</a></li>
                            <li class="nav-item"><a class="nav-link" href="register.jsp">SignUp</a></li>
                            </c:otherwise>
                        </c:choose>
                </ul>
            </div>
        </nav>
    </div>
</header>