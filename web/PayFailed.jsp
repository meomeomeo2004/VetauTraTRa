<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết giao dịch</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-color: #4361ee;
                --secondary-color: #f8f9fa;
                --success-color: #38b000;
                --error-color: #dc3545; /* Added error color */
                --text-color: #333;
                --light-gray: #e9ecef;
                --medium-gray: #dee2e6;
                --dark-gray: #6c757d;
                --border-radius: 12px;
                --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f5f7fa;
                color: var(--text-color);
                line-height: 1.6;
                padding: 0;
                margin: 0;
            }

            .header {
                background-color: var(--primary-color);
                color: white;
                padding: 30px 0;
                text-align: center;
                margin-bottom: 40px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                position: relative;
                overflow: hidden;
            }

            .header::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(135deg, rgba(255,255,255,0.1) 0%, rgba(255,255,255,0) 100%);
                z-index: 1;
            }

            .header h1 {
                font-weight: 700;
                font-size: 2rem;
                position: relative;
                z-index: 2;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto 60px;
                padding: 0 20px;
            }

            .card {
                background-color: white;
                border-radius: var(--border-radius);
                box-shadow: var(--box-shadow);
                overflow: hidden;
                margin-bottom: 30px;
            }

            .card-header {
                background-color: var(--secondary-color);
                padding: 20px 25px;
                border-bottom: 1px solid var(--medium-gray);
            }

            .card-header h2 {
                color: var(--primary-color);
                font-size: 1.5rem;
                font-weight: 600;
                margin: 0;
            }

            .card-body {
                padding: 25px;
            }

            /* Modified notification to use error color */
            .notification {
                background-color: var(--error-color);
                color: white;
                padding: 18px;
                margin: 0 0 30px;
                border-radius: var(--border-radius);
                text-align: center;
                font-weight: 500;
                font-size: 1.1rem;
                box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
                animation: fadeIn 0.5s ease;
                position: relative;
            }

            /* Changed icon from checkmark to X */
            .notification::before {
                content: '✕';
                display: inline-block;
                margin-right: 10px;
                font-weight: bold;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .transaction-details {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;
            }

            .detail-item {
                margin-bottom: 5px;
            }

            .detail-label {
                font-weight: 500;
                color: var(--dark-gray);
                margin-bottom: 5px;
                font-size: 0.9rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .detail-value {
                font-weight: 600;
                font-size: 1.1rem;
                color: var(--text-color);
            }

            .highlight {
                color: var(--primary-color);
            }

            .table-responsive {
                overflow-x: auto;
                margin-top: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            thead {
                background-color: var(--primary-color);
                color: white;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border: none;
            }

            th {
                font-weight: 500;
                text-transform: uppercase;
                font-size: 0.85rem;
                letter-spacing: 0.5px;
            }

            tbody tr {
                border-bottom: 1px solid var(--light-gray);
            }

            tbody tr:last-child {
                border-bottom: none;
            }

            tbody tr:nth-child(even) {
                background-color: var(--secondary-color);
            }

            tbody tr:hover {
                background-color: rgba(67, 97, 238, 0.05);
            }

            .status {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: 500;
                text-align: center;
            }

            .status-active {
                background-color: rgba(56, 176, 0, 0.15);
                color: var(--success-color);
            }

            .status-inactive {
                background-color: rgba(220, 53, 69, 0.15);
                color: #dc3545;
            }

            .status-unknown {
                background-color: rgba(108, 117, 125, 0.15);
                color: var(--dark-gray);
            }

            .empty-state {
                text-align: center;
                padding: 40px 20px;
                color: var(--dark-gray);
            }

            .empty-state p {
                font-size: 1.1rem;
                margin-bottom: 0;
            }

            .btn {
                display: inline-block;
                font-weight: 500;
                text-align: center;
                white-space: nowrap;
                vertical-align: middle;
                user-select: none;
                border: 1px solid transparent;
                padding: 0.75rem 1.5rem;
                font-size: 1rem;
                line-height: 1.5;
                border-radius: 8px;
                transition: all 0.15s ease-in-out;
                cursor: pointer;
                text-decoration: none;
            }

            .btn-primary {
                color: #fff;
                background-color: var(--primary-color);
                border-color: var(--primary-color);
            }

            .btn-primary:hover {
                background-color: #3a56d4;
                border-color: #3a56d4;
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
            }

            .btn-primary:active {
                transform: translateY(0);
                box-shadow: none;
            }

            .btn-home {
                display: flex;
                align-items: center;
                justify-content: center;
                margin: 40px auto 0;
                width: fit-content;
            }

            .btn-home svg {
                margin-right: 8px;
            }

            @media (max-width: 768px) {
                .transaction-details {
                    grid-template-columns: 1fr;
                }

                .header h1 {
                    font-size: 1.5rem;
                }

                th, td {
                    padding: 10px;
                }

                .card-body {
                    padding: 15px;
                }
            }
        </style>
    </head>
    <body>
        <div class="header">
            <h1>Transaction details</h1>
        </div>

        <div class="container">
            <c:if test="${not empty fail}">
                <div class="notification">
                    ${fail}
                </div>
            </c:if>
            <a href="/tratra" class="btn btn-primary btn-home">
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                <polyline points="9 22 9 12 15 12 15 22"></polyline>
                </svg>
                Return to Home
            </a>
        </div>
    </body>
</html>