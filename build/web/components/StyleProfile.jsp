<%--
    Document   : StyleProfile
    Created on : Mar 20, 2025, 5:25:24 PM
    Author     : dtam6
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    :root {
        --primary-color: #22577a;
        --primary-light: #38788e;
        --secondary-color: #5c6784;
        --accent-color: #f0f5f9;
        --dark-color: #1a3c55;
        --light-color: #ffffff;
        --danger-color: #d62828;
        --success-color: #38a3a5;
    }

    body {
        background-color: #f8f9fe;
        font-family: 'Poppins', sans-serif;
    }

    .page-wrapper {
        padding: 40px 0;
    }

    .profile-header {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        padding: 60px 0 100px;
        color: white;
        margin-bottom: -60px;
    }

    .profile-header h1 {
        font-weight: 700;
        font-size: 32px;
        margin-bottom: 10px;
    }

    .breadcrumb-custom {
        background: transparent;
        padding: 0;
    }

    .breadcrumb-custom .breadcrumb-item {
        color: rgba(255, 255, 255, 0.8);
    }

    .breadcrumb-custom .breadcrumb-item a {
        color: rgba(255, 255, 255, 0.8);
        text-decoration: none;
    }

    .breadcrumb-custom .breadcrumb-item.active {
        color: white;
    }

    .breadcrumb-custom .breadcrumb-item + .breadcrumb-item::before {
        color: rgba(255, 255, 255, 0.6);
    }

    .profile-nav-card {
        background-color: var(--light-color);
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        transition: all 0.3s ease;
    }

    .profile-nav-card:hover {
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .profile-nav-header {
        background-color: var(--primary-color);
        color: white;
        padding: 20px;
        text-align: center;
        font-weight: 600;
        font-size: 18px;
    }

    .profile-nav-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .profile-nav-item {
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }

    .profile-nav-item:last-child {
        border-bottom: none;
    }

    .profile-nav-link {
        display: flex;
        align-items: center;
        padding: 15px 20px;
        color: var(--secondary-color);
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .profile-nav-link:hover {
        background-color: var(--accent-color);
        color: var(--primary-color);
    }

    .profile-nav-link.active {
        background-color: var(--accent-color);
        color: var(--primary-color);
        font-weight: 600;
        border-left: 4px solid var(--primary-color);
    }

    .profile-nav-link i {
        margin-right: 10px;
        width: 20px;
        text-align: center;
    }

    .content-card {
        background-color: var(--light-color);
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        padding: 30px;
        height: 100%;
        transition: all 0.3s ease;
    }

    .content-card:hover {
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .content-card-header {
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        padding-bottom: 20px;
        margin-bottom: 30px;
    }

    .content-card-title {
        font-size: 22px;
        font-weight: 700;
        color: var(--dark-color);
        margin-bottom: 0;
    }

    .form-group {
        margin-bottom: 25px;
        position: relative;
    }

    .form-label {
        font-weight: 600;
        color: var(--dark-color);
        margin-bottom: 10px;
        display: block;
    }

    .form-control-custom {
        height: 55px;
        border-radius: 10px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        padding: 10px 15px 10px 45px;
        font-size: 15px;
        transition: all 0.3s ease;
        width: 100%;
        background-color: var(--accent-color);
        color: var(--dark-color);
        cursor: default;
    }

    .form-icon {
        position: absolute;
        left: 15px;
        top: 43px;
        color: var(--secondary-color);
    }

    .btn-submit {
        background: linear-gradient(135deg, var(--primary-color), #8e9efc);
        color: white;
        border: none;
        height: 55px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 16px;
        letter-spacing: 0.5px;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        margin-top: 10px;
        box-shadow: 0 5px 15px rgba(74, 108, 247, 0.2);
    }

    .btn-submit:hover {
        background: linear-gradient(135deg, #3a5cf5, #7989fa);
        box-shadow: 0 8px 20px rgba(74, 108, 247, 0.3);
        transform: translateY(-2px);
    }


    .profile-info {
        display: flex;
        align-items: center;
        margin-bottom: 30px;
    }

    .profile-avatar {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background-color: var(--accent-color);
        display: flex;
        align-items: center;
        justify-content: center;
        margin-right: 20px;
        font-size: 40px;
        color: var(--primary-color);
        border: 3px solid var(--primary-color);
    }

    .profile-details h4 {
        margin: 0;
        color: var(--dark-color);
        font-weight: 600;
        font-size: 24px;
    }

    .profile-details p {
        margin: 5px 0 0;
        color: var(--secondary-color);
        font-size: 16px;
    }
    .password-requirements {
        background-color: var(--accent-color);
        border-radius: 10px;
        padding: 20px;
        margin-top: 30px;
    }

    .password-requirements h5 {
        color: var(--dark-color);
        font-weight: 600;
        margin-bottom: 15px;
        font-size: 16px;
    }

    .requirement-list {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .requirement-item {
        display: flex;
        align-items: center;
        margin-bottom: 10px;
        color: var(--secondary-color);
        font-size: 14px;
    }

    .requirement-item i {
        margin-right: 10px;
        color: var(--success-color);
    }
    .transaction-table {
        width: 100%;
        border-collapse: separate;
        border-spacing: 0;
        margin-bottom: 30px;
        border-radius: 10px;
        overflow: hidden;
    }

    .transaction-table th {
        background-color: var(--primary-color);
        color: white;
        font-weight: 600;
        padding: 15px;
        text-align: left;
        font-size: 14px;
        border: none;
    }

    .transaction-table td {
        padding: 15px;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        color: var(--secondary-color);
        font-size: 14px;
        vertical-align: middle;
    }

    .transaction-table tr:last-child td {
        border-bottom: none;
    }

    .transaction-table tr:hover td {
        background-color: var(--accent-color);
    }

    .status-paid {
        background-color: rgba(56, 163, 165, 0.1);
        color: var(--success-color);
        font-weight: 600;
        padding: 5px 10px;
        border-radius: 20px;
        display: inline-block;
    }

    .status-unpaid {
        background-color: rgba(214, 40, 40, 0.1);
        color: var(--danger-color);
        font-weight: 600;
        padding: 5px 10px;
        border-radius: 20px;
        display: inline-block;
    }

    .btn-view {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: white;
        border: none;
        padding: 8px 15px;
        border-radius: 8px;
        font-weight: 500;
        font-size: 13px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
    }

    .btn-view:hover {
        background: linear-gradient(135deg, #1b4660, var(--primary-color));
        transform: translateY(-2px);
        box-shadow: 0 4px 10px rgba(34, 87, 122, 0.2);
        color: white;
    }

    .transaction-summary {
        background-color: var(--accent-color);
        border-radius: 10px;
        padding: 15px 20px;
        margin-bottom: 30px;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .transaction-summary p {
        margin: 0;
        color: var(--dark-color);
        font-weight: 500;
    }

    .transaction-summary .count {
        font-weight: 700;
        color: var(--primary-color);
    }

    .empty-state {
        text-align: center;
        padding: 40px 20px;
        color: var(--secondary-color);
    }

    .empty-state i {
        font-size: 50px;
        color: var(--primary-color);
        opacity: 0.5;
        margin-bottom: 20px;
    }

    .empty-state p {
        font-size: 18px;
        margin-bottom: 20px;
    }

    .responsive-table {
        overflow-x: auto;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    }
    .form-group {
        /* Bỏ position: relative nếu không cần nữa */
        margin-bottom: 25px;
    }

    .input-wrapper {
        position: relative; /* Giúp icon canh chính xác trong vùng input */
    }

    /* Xóa hoặc sửa lại bất kỳ .form-icon { top: 43px; } cũ */
    .form-icon {
        position: absolute;
        left: 15px;
        top: 50%;
        transform: translateY(-50%);
        color: var(--secondary-color);
        font-size: 16px; /* tuỳ chỉnh kích cỡ icon */
    }

    /* Tăng padding-left để text không đè lên icon */
    .form-control-custom {
        height: 55px;
        border-radius: 10px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        padding: 10px 15px 10px 45px; /* Phải >= khoảng cách icon */
        font-size: 15px;
        transition: all 0.3s ease;
        width: 100%;
        background-color: var(--accent-color);
        color: var(--dark-color);
        cursor: default;
    }
    .ticket-card {
        background-color: var(--light-color);
        border-radius: 15px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
        overflow: hidden;
        margin-bottom: 30px;
        transition: all 0.3s ease;
    }

    .ticket-card:hover {
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .ticket-header {
        background-color: var(--primary-color);
        color: white;
        padding: 15px 20px;
        font-weight: 600;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .ticket-header h3 {
        margin: 0;
        font-size: 18px;
    }

    .ticket-body {
        padding: 0;
    }

    .ticket-table {
        width: 100%;
        border-collapse: collapse;
        margin: 0;
    }

    .ticket-table tr:nth-child(odd) {
        background-color: var(--accent-color);
    }

    .ticket-table td {
        padding: 15px 20px;
        border: none;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    }

    .ticket-table tr:last-child td {
        border-bottom: none;
    }

    .ticket-table td:first-child {
        font-weight: 600;
        color: var(--dark-color);
        width: 40%;
    }

    .ticket-table td:last-child {
        color: var(--secondary-color);
    }

    .ticket-footer {
        padding: 15px 20px;
        border-top: 1px solid rgba(0, 0, 0, 0.05);
    }

    .btn-cancel {
        background: linear-gradient(135deg, var(--danger-color), #e74c3c);
        color: white;
        border: none;
        height: 50px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .btn-cancel:hover {
        background: linear-gradient(135deg, #c0392b, var(--danger-color));
        box-shadow: 0 8px 20px rgba(214, 40, 40, 0.3);
        transform: translateY(-2px);
    }

    .btn-cancel i {
        margin-right: 10px;
    }

    .btn-back {
        background: linear-gradient(135deg, var(--primary-color), var(--primary-light));
        color: white;
        border: none;
        height: 50px;
        border-radius: 10px;
        font-weight: 600;
        font-size: 16px;
        cursor: pointer;
        transition: all 0.3s ease;
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: center;
        text-decoration: none;
        margin-top: 20px;
    }

    .btn-back:hover {
        background: linear-gradient(135deg, #1b4660, var(--primary-color));
        box-shadow: 0 8px 20px rgba(34, 87, 122, 0.3);
        transform: translateY(-2px);
        color: white;
    }

    .btn-back i {
        margin-right: 10px;
    }

    /* Modal Styles */
    .modal-content {
        border-radius: 15px;
        overflow: hidden;
        border: none;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .modal-header {
        background-color: var(--primary-color);
        color: white;
        border-bottom: none;
        padding: 20px;
    }

    .modal-title {
        font-weight: 600;
        font-size: 18px;
    }

    .modal-body {
        padding: 30px;
    }

    .modal-footer {
        border-top: none;
        padding: 20px;
    }

    .form-select {
        height: 50px;
        border-radius: 10px;
        border: 1px solid rgba(0, 0, 0, 0.1);
        padding: 10px 15px;
        font-size: 15px;
        transition: all 0.3s ease;
        width: 100%;
    }

    .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(34, 87, 122, 0.1);
        outline: none;
    }

    .btn-modal-close {
        background-color: #f1f3f5;
        color: var(--secondary-color);
        border: none;
        border-radius: 10px;
        padding: 12px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-modal-close:hover {
        background-color: #e9ecef;
    }

    .btn-modal-confirm {
        background: linear-gradient(135deg, var(--danger-color), #e74c3c);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 12px 20px;
        font-weight: 600;
        transition: all 0.3s ease;
    }

    .btn-modal-confirm:hover {
        background: linear-gradient(135deg, #c0392b, var(--danger-color));
        box-shadow: 0 5px 15px rgba(214, 40, 40, 0.2);
    }

    .close {
        color: white;
        opacity: 0.8;
        transition: all 0.3s ease;
    }

    .close:hover {
        opacity: 1;
        color: white;
    }

    .empty-state {
        text-align: center;
        padding: 40px 20px;
        color: var(--secondary-color);
    }

    .empty-state i {
        font-size: 50px;
        color: var(--primary-color);
        opacity: 0.5;
        margin-bottom: 20px;
    }

    .empty-state p {
        font-size: 18px;
        margin-bottom: 20px;
    }

    .modal-body {
        max-height: 70vh;
        overflow-y: auto;
    }



    @media (max-width: 768px) {
        .profile-header {
            padding: 40px 0 80px;
            margin-bottom: -40px;
        }

        .profile-nav-card {
            margin-bottom: 30px;
        }

        .profile-nav-card {
            margin-bottom: 30px;
        }

        .profile-info {
            flex-direction: column;
            text-align: center;
        }

        .profile-avatar {
            margin-right: 0;
            margin-bottom: 15px;
        }
        .ticket-table td {
            padding: 12px 15px;
        }

        .ticket-header h3 {
            font-size: 16px;
        }

    }
</style>