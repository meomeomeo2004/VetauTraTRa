<%-- 
    Document   : RoC
    Created on : Mar 26, 2025, 6:32:26 AM
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
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: Arial, sans-serif;
            }

            body {
                background-color: #f5f5f5;
                color: #333;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            header {
                background-color: #22577a;
                color: white;
                padding: 20px;
                border-radius: 5px 5px 0 0;
                margin-bottom: 20px;
            }

            .controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                flex-wrap: wrap;
                gap: 10px;
            }

            .search-filter {
                display: flex;
                gap: 10px;
                flex-wrap: wrap;
            }

            input,
            select,
            button {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }

            button {
                background-color: #22577a;
                color: white;
                cursor: pointer;
                border: none;
                transition: background-color 0.3s;
            }

            button:hover {
                background-color: #1a4057;
            }

            button:disabled {
                background-color: #cccccc;
                cursor: not-allowed;
            }

            .table-container {
                background-color: white;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                overflow-x: auto;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th,
            td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #22577a;
                color: white;
                position: relative;
                cursor: pointer;
            }

            th:hover {
                background-color: #1a4057;
            }

            .sort-icon {
                margin-left: 5px;
                font-size: 12px;
            }

            tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            tr:hover {
                background-color: #f1f1f1;
            }

            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
                gap: 10px;
            }

            #pageNumbers {
                display: flex;
                gap: 5px;
            }

            .page-number {
                padding: 5px 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                cursor: pointer;
            }

            .page-number.active {
                background-color: #22577a;
                color: white;
                border-color: #22577a;
            }

            #pageInfo {
                margin-left: 10px;
                color: #666;
            }

            @media (max-width: 768px) {
                .controls {
                    flex-direction: column;
                    align-items: flex-start;
                }

                .search-filter,
                .pagination-controls {
                    width: 100%;
                }

                th,
                td {
                    padding: 8px 10px;
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
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Record Of Changes</h1>
                    <div class="container">
                        <div class="controls">
                            <div class="search-filter">
                                <input type="text" id="searchInput" placeholder="Search...">
                                <select id="typeFilter">
                                    <option value="">All Roles</option>
                                    <option value="manager">Manager</option>
                                    <option value="seller">Seller</option>
                                    <option value="staff">Staff</option>
                                    <option value="admin">Admin</option>
                                </select>
                                <button id="filterButton">Filter</button>
                            </div>

                            <div class="pagination-controls">
                                <select id="recordsPerPage">
                                    <option value="5">5 per page</option>
                                    <option value="10">10 per page</option>
                                    <option value="20">20 per page</option>
                                    <option value="50">50 per page</option>
                                </select>
                            </div>
                        </div>

                        <div class="table-container">
                            <table id="rocTable">
                                <thead>
                                    <tr>
                                        <th data-sort="name">Name <span class="sort-icon">↕</span></th>
                                        <th data-sort="role">Role <span class="sort-icon">↕</span></th>
                                        <th data-sort="date">Date <span class="sort-icon">↕</span></th>
                                        <th data-sort="change">Content <span class="sort-icon">↕</span></th>
                                    </tr>
                                </thead>
                                <tbody id="rocBody">
                                    <!-- Transaction rows will be inserted here by JavaScript -->
                                </tbody>
                            </table>
                        </div>

                        <div class="pagination">
                            <button id="prevPage" disabled>Previous</button>
                            <div id="pageNumbers"></div>
                            <button id="nextPage">Next</button>
                            <span id="pageInfo">Page 1 of 1</span>
                        </div>
                    </div>
                </div>

            </main>
        </div>
        <script src="js/roc.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://unpkg.com/htmx.org@2.0.4"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>
