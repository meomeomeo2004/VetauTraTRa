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
        <title>Refund List</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            function confirmStatusChange(refundId) {
                Swal.fire({
                    title: 'Are you sure?',
                    text: "Do you want to refund this ticket?",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes!'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'changeStatusRefund?id=' + refundId;
                    }
                });
            }
        </script>
    </head>
    <body class="sb-nav-fixed">
        <%@ include file="staffNavBar.jsp" %>

        <div id="layoutSidenav">
            <%@ include file="staffSideBar.jsp" %>
            <div id="layoutSidenav_content">
                <main>
                    <div class="container-fluid px-4">
                        <h1 class="mt-4">List of Refunds</h1>
                        <div class="card mb-4">
                            <div class="card-body">
                                <table id="datatablesSimple" class="table table-striped table-bordered">
                                    <thead class="thead-dark">
                                        <tr>
                                            <th>ID</th>
                                            <th>User ID</th>
                                            <th>Staff ID</th>
                                            <th>Ticket ID</th>
                                            <th>User Bank Name</th>
                                            <th>User Bank Number</th>
                                            <th>User Bank Account Name</th>
                                            <th>Create at</th>
                                            <th>Handle time</th>
                                            <th>Price</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="refund" items="${sessionScope.refund}">
                                            <tr>
                                                <td><c:out value="${refund.id}" /></td>
                                                <td><c:out value="${refund.userId}" /></td>
                                                <td><c:out value="${refund.staffId}" /></td>
                                                <td><c:out value="${refund.ticketId}" /></td>
                                                <td><c:out value="${refund.userBankName}" /></td>
                                                <td><c:out value="${refund.userBankNumber}" /></td>
                                                <td><c:out value="${refund.userBankAccountName}" /></td>
                                                <td><c:out value="${refund.createdAt}" /></td>
                                                <td><c:out value="${refund.handleTime}" /></td>
                                                <td><c:out value="${refund.price}" /></td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${refund.status == 0}">
                                                            <p style="color: orange"><strong>Pending</strong></p>
                                                        </c:when>
                                                        <c:when test="${refund.status == 1}">
                                                            <p style="color: green"><strong>Completed</strong></p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            Unknown
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:if test="${refund.status == 0}">
                                                        <a class="btn btn-warning btn-sm" onclick="confirmStatusChange(${refund.id})" role="button">
                                                            Refund
                                                        </a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
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