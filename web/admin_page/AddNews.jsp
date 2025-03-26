<%-- 
    Document   : AddNews
    Created on : Mar 26, 2025, 11:21:13 AM
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
        <title>Add a News - Admin</title>
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
                max-width: 800px;
                margin: 0 auto;
                background-color: white;
                padding: 25px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .taito {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 1px solid #eee;
            }

            taito {
                color: #1a5276;
                font-size: 28px;
            }

            .back-btn {
                display: flex;
                align-items: center;
                gap: 5px;
                color: #1a5276;
                text-decoration: none;
                font-size: 14px;
            }

            .back-btn:hover {
                text-decoration: underline;
            }

            .form-container {
                padding: 10px;
            }

            .form-group {
                margin-bottom: 20px;
            }

            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
                color: #333;
            }

            .required {
                color: #e74c3c;
            }

            input[type="text"],
            textarea {
                width: 100%;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            textarea:focus {
                border-color: #1a5276;
                outline: none;
                box-shadow: 0 0 0 2px rgba(26, 82, 118, 0.1);
            }

            textarea {
                resize: vertical;
                min-height: 150px;
            }

            .error-message {
                color: #e74c3c;
                font-size: 14px;
                margin-top: 5px;
                min-height: 20px;
            }

            .status-group {
                margin-bottom: 30px;
            }

            .radio-group {
                display: flex;
                gap: 20px;
            }

            .radio-label {
                display: flex;
                align-items: center;
                cursor: pointer;
                font-weight: normal;
            }

            .radio-label input {
                margin-right: 8px;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 15px;
                margin-top: 30px;
            }

            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                transition: background-color 0.2s;
            }

            .btn-submit {
                background-color: #1a5276;
                color: white;
            }

            .btn-submit:hover {
                background-color: #154360;
            }

            .btn-cancel {
                background-color: #f1f1f1;
                color: #333;
            }

            .btn-cancel:hover {
                background-color: #e1e1e1;
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
                padding: 30px;
                border: 1px solid #888;
                width: 80%;
                max-width: 500px;
                border-radius: 5px;
                position: relative;
                text-align: center;
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

            .success-icon {
                font-size: 60px;
                color: #27ae60;
                margin-bottom: 15px;
            }

            .modal-content h2 {
                color: #1a5276;
                margin-bottom: 15px;
            }

            .modal-content p {
                margin-bottom: 25px;
                color: #666;
            }

            .modal-content .btn {
                margin: 0 auto;
                min-width: 100px;
            }

            /* Responsive styles */
            @media (max-width: 768px) {
                .header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                }

                .back-btn {
                    align-self: flex-start;
                }

                .form-actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                }

                .btn-cancel {
                    order: 2;
                }

                .btn-submit {
                    order: 1;
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
                    <div class="taito">
                        <h1>Add New News</h1>
                        <a href="NewsList" class="back-btn"><i class="fas fa-arrow-left"></i> Back to News List</a>
                    </div>

                    <div class="form-container">
                        <form id="AddNews" method="POST">
                            <div class="form-group">
                                <label for="newsTitle">Title <span class="required">*</span></label>
                                <input type="text" id="newsTitle" name="newsTitle" placeholder="Enter the title here..." required>
                                <div class="error-message" id="titleError"></div>
                            </div>

                            <div class="form-group">
                                <label for="newsContent">Content <span class="required">*</span></label>
                                <textarea id="newsContent" name="newsContent" rows="10" placeholder="Enter news's content here..." required></textarea>
                                <div class="error-message" id="contentError"></div>
                            </div>

                            <div class="form-group status-group">
                                <label>Status</label>
                                <div class="radio-group">
                                    <label class="radio-label">
                                        <input type="radio" name="status" value="published" checked>
                                        <span class="radio-text">Published</span>
                                    </label>
                                    <label class="radio-label">
                                        <input type="radio" name="status" value="hidden">
                                        <span class="radio-text">Hidden</span>
                                    </label>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="submit" id="submitBtn" class="btn btn-submit">Add News</button>
                            </div>
                        </form>
                    </div>
                </div>

            </main>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://unpkg.com/htmx.org@2.0.4"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    </body>
</html>