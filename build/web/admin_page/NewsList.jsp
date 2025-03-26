<%-- 
    Document   : NewsList
    Created on : Mar 26, 2025, 9:10:30 AM
    Author     : Aus TUF GAMAING
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Record Of Changes - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #f5f5f5;
                color: #333;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .taito {
                color: #1a5276;
                margin-bottom: 20px;
                font-size: 28px;
            }

            .controls {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 10px;
            }

            .search-container {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
                align-items: flex-end;
            }

            .search-container input {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            .date-range {
                display: flex;
                gap: 10px;
            }

            .date-input {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            .date-input label {
                font-size: 12px;
                color: #666;
            }

            .search-container button,
            .news-item .btn {
                padding: 8px 15px;
                background-color: #1a5276;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .search-container button:hover,
            .news-item .btn:hover {
                background-color: #154360;
            }

            #resetBtn {
                background-color: #7f8c8d;
            }

            #resetBtn:hover {
                background-color: #6c7a7a;
            }
            
            #AddBtn {
                background-color: #27ae60;
            }

            #AddBtn:hover {
                background-color: #2e7d32;
            }

            .filter-container select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                background-color: white;
                font-size: 14px;
            }

            .news-list {
                margin-bottom: 20px;
            }

            .news-item {
                padding: 20px;
                margin-bottom: 15px;
                border-radius: 5px;
                background-color: white;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
                border-left: 4px solid #1a5276;
                position: relative;
            }

            .news-item h2 {
                color: #1a5276;
                margin-bottom: 10px;
                font-size: 22px;
            }

            .news-item .date {
                color: #7f8c8d;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .news-item .content-preview {
                color: #666;
                margin-bottom: 15px;
                line-height: 1.5;
            }

            .news-item .actions {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            .news-item .btn {
                font-size: 13px;
            }

            .news-item .btn-view {
                background-color: #1a5276;
            }

            .news-item .btn-edit {
                background-color: #f39c12;
            }

            .news-item .btn-edit:hover {
                background-color: #e67e22;
            }

            .news-item .btn-publish {
                background-color: #27ae60;
            }

            .news-item .btn-publish:hover {
                background-color: #2ecc71;
            }

            .news-item .btn-hide {
                background-color: #e74c3c;
            }

            .news-item .btn-hide:hover {
                background-color: #c0392b;
            }

            .news-item .status {
                position: absolute;
                top: 20px;
                right: 20px;
                padding: 5px 10px;
                border-radius: 15px;
                font-size: 12px;
                font-weight: bold;
            }

            .news-item .status-Published {
                background-color: #e8f5e9;
                color: #2e7d32;
            }

            .news-item .status-Hidden {
                background-color: #ffebee;
                color: #c62828;
            }

            .pagination {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                margin-top: 20px;
                flex-wrap: wrap;
            }

            .page-btn {
                padding: 8px 15px;
                background-color: #1a5276;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .page-btn:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            .page-numbers {
                display: flex;
                gap: 5px;
                flex-wrap: wrap;
            }

            .page-number {
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid #ddd;
                cursor: pointer;
                border-radius: 4px;
            }

            .page-number.active {
                background-color: #1a5276;
                color: white;
                border-color: #1a5276;
            }

            .page-info {
                margin-left: 10px;
                color: #666;
            }

            /* Modal styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0, 0, 0, 0.4);
            }

            .modal-content {
                background-color: #fefefe;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
                max-width: 700px;
                border-radius: 5px;
                position: relative;
            }

            .close {
                color: #aaa;
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
            }

            #modalTitle {
                color: #1a5276;
                margin-bottom: 10px;
            }

            #modalDate {
                color: #7f8c8d;
            }

            #modalStatus {
                display: inline-block;
                padding: 3px 8px;
                border-radius: 10px;
                font-size: 12px;
            }

            .status-published {
                background-color: #e8f5e9;
                color: #2e7d32;
            }

            .status-hidden {
                background-color: #ffebee;
                color: #c62828;
            }

            #modalContent {
                margin-top: 15px;
                line-height: 1.6;
            }

            .no-results {
                padding: 20px;
                text-align: center;
                color: #666;
                font-style: italic;
            }

            /* Responsive styles */
            @media (max-width: 768px) {
                .controls {
                    flex-direction: column;
                }

                .search-container, .filter-container {
                    width: 100%;
                }

                .date-range {
                    width: 100%;
                    justify-content: space-between;
                }

                .date-input {
                    width: 48%;
                }

                .news-item .actions {
                    flex-direction: column;
                }

                .news-item .btn {
                    width: 100%;
                    justify-content: center;
                }
            }
            a {
                text-decoration: none; /* Removes underline */
            }
        </style>
    </head>
    <body>
        <%@ include file="adminNavBar.jsp" %>
        <div class="main-content">
            <%@ include file="adminSideBar.jsp" %>
            <main class="content">
                <div class="container">
                    <h1 class="mt-4">News Management</h1>

                    <div class="controls">
                        <div class="search-container">
                            <input type="text" id="searchTitle" placeholder="Search by title...">
                            <div class="date-range">
                                <div class="date-input">
                                    <label for="startDate">From:</label>
                                    <input type="date" id="startDate">
                                </div>
                                <div class="date-input">
                                    <label for="endDate">To:</label>
                                    <input type="date" id="endDate">
                                </div>
                            </div>
                            <button id="searchBtn"><i class="fas fa-search"></i> Search</button>
                            <button id="resetBtn"><i class="fas fa-undo"></i> Reset</button>
                            <a href="AddNews"><button id="AddBtn" hr><i class="fas fa-plus"></i> Add News</button></a>
                        </div>

                        <div class="filter-container">
                            <select id="statusFilter">
                                <option value="all">All Status</option>
                                <option value="Published">Published</option>
                                <option value="Hidden">Hidden</option>
                            </select>
                        </div>
                    </div>

                    <div id="newsList" class="news-list">
                        <!-- News items will be populated by JavaScript -->
                    </div>

                    <div class="pagination">
                        <button id="prevPage" class="page-btn"><i class="fas fa-chevron-left"></i> Previous</button>
                        <div id="pageNumbers" class="page-numbers">
                            <!-- Page numbers will be populated by JavaScript -->
                        </div>
                        <button id="nextPage" class="page-btn">Next <i class="fas fa-chevron-right"></i></button>
                        <div class="page-info">
                            Page <span id="currentPage">1</span> of <span id="totalPages">1</span>
                        </div>
                    </div>
                </div>

                <!-- News Detail Modal -->
                <div id="newsDetailModal" class="modal">
                    <div class="modal-content">
                        <span class="close">&times;</span>
                        <h2 id="modalTitle"></h2>
                        <p><i class="far fa-calendar-alt"></i> <span id="modalDate"></span></p>
                        <p><strong>Status:</strong> <span id="modalStatus"></span></p>
                        <div id="modalContent"></div>
                    </div>
                </div>
            </main>
        </div>
        <script src="js/news.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://unpkg.com/htmx.org@2.0.4"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>
