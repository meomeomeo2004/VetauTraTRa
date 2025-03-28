<%-- 
    Document   : EditAccount
    Created on : Feb 12, 2025, 1:00:07 AM
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
        <title>Edit Account</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <style>
            .content {
                background-color: #f5f5f5;
                min-height: calc(100vh - 100px);
            }

            .form-control:focus, .form-select:focus {
                border-color: #22577a;
                box-shadow: 0 0 0 0.25rem rgba(34, 87, 122, 0.25);
            }

            .btn:hover {
                background-color: #1a4057 !important;
            }

            .card-header h3 {
                font-weight: 200;
                letter-spacing: 0.2px;
            }

            .form-label {
                color: #333;
                margin-bottom: 0.5rem;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .card-body {
                    padding: 1.5rem;
                }
            }
            .form-control-lg {
                font-size: 1rem;
            }
            .form-select-lg {
                font-size: 1rem;
            }
            .mb-4 {
                margin-bottom: 1.2rem !important;
            }
        </style>
    </head>
    <body>
    <body class="sb-nav-fixed">
        <%@ include file="adminNavBar.jsp" %>
        <div class="main-content">
            <%@ include file="adminSideBar.jsp" %>
            <main class="content" style="padding: 0">
                <div class="container-fluid p-4">
                    <div class="card" style="border-radius: 10px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                        <div class="card-header" style="background-color: #22577a; color: white; border-radius: 10px 10px 0 0;">
                            <h3 class="text-center mb-0 py-3">EDIT AN ACCOUNT</h3>
                        </div>
                        <div class="card-body p-4">
                            <form method="POST" action="EditAccount" class="mx-auto" style="max-width: 500px;">
                                <div class="mb-4">
                                    <label class="form-label fw-bold" for="email">Email of User Editing</label>
                                    <input value="${sessionScope.email}" type="email" name="email" id="email" 
                                           class="form-control form-control-lg bg-light" readonly/>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold" for="phonenumber">Phone Number</label>
                                    <input value="${requestScope.phonenumber}" type="number" name="phonenumber" id="phonenumber" 
                                           class="form-control form-control-lg bg-light" required/>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold" for="fullname">Full Name</label>
                                    <input value="${requestScope.fullname}" type="text" name="fullname" id="fullname" 
                                           class="form-control form-control-lg bg-light" required/>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold" for="address">Address</label>
                                    <input value="${requestScope.address}" type="text" name="address" id="password" 
                                           class="form-control form-control-lg bg-light" required/>
                                </div>

                                <div class="text-center mt-5">
                                    <button class="btn btn-lg px-5 py-2" type="submit" 
                                            style="background-color: #22577a; color: white; min-width: 150px;">
                                        Submit Edit
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="js/scripts.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
    <script src="js/datatables-simple-demo.js"></script>
</body>
</html>
