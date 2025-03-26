<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    java.util.Date currentTime = new java.util.Date();
    request.setAttribute("currentTime", currentTime);
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>Ticket Details</title>
        <%@ include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
    </head>
    <body>
        <!-- Breadcrumb Area -->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0"></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">Profile</h2>
                    <ol class="breadcrumb">
                        <li><a href="/tratra">Home</a></li>
                        <li class="active">Ticket Details</li>
                    </ol>
                </div>
            </div>
        </section>
        <%@ include file="components/Header.jsp" %>

        <!-- Profile Content -->
        <div class="page-wrapper">
            <div class="container">
                <div class="row">
                    <!-- Sidebar Navigation -->
                    <div class="col-lg-3 col-md-4">
                        <div class="profile-nav-card">
                            <div class="profile-nav-header">
                                Account Menu
                            </div>
                            <ul class="profile-nav-list">
                                <li class="profile-nav-item">
                                    <a href="profile" class="profile-nav-link">
                                        <i class="fas fa-user"></i> View Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="update-profile" class="profile-nav-link">
                                        <i class="fas fa-edit"></i> Update Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="change-password" class="profile-nav-link">
                                        <i class="fas fa-lock"></i> Change Password
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="transaction" class="profile-nav-link active">
                                        <i class="fas fa-history"></i> Transaction History
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!-- Main Content -->
                    <div class="col-lg-9 col-md-8">
                        <div class="content-card">
                            <div class="content-card-header">
                                <h3 class="content-card-title">Ticket Details</h3>
                            </div>

                            <c:if test="${not empty tickets}">
                                <c:set var="firstTicketId" value="0" />
                                <c:forEach var="ticket" items="${tickets}" varStatus="loopStatus">
                                    <c:if test="${loopStatus.first}">
                                        <c:set var="firstTicketId" value="${ticket.id}" />
                                    </c:if>

                                    <div class="ticket-card">
                                        <div class="ticket-header">
                                            <h3><i class="fas fa-ticket-alt"></i> Ticket ${loopStatus.index + 1}</h3>
                                            <span class="badge bg-light text-dark">${ticket.status}</span>
                                        </div>
                                        <div class="ticket-body">
                                            <table class="ticket-table">
                                                <tr>
                                                    <td>ID</td>
                                                    <td>${ticket.id}</td>
                                                </tr>
                                                <tr>
                                                    <td>Status</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${ticket.status == 0}">
                                                                <span style="color: red;">Canceled</span>
                                                            </c:when>
                                                            <c:when test="${ticket.status == 1}">
                                                                <span style="color: green;">On</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span style="color: gray;">Unknown</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>Luggage Type</td>
                                                    <td>${ticket.weight.weight} kg</td>
                                                </tr>
                                                <tr>
                                                    <td>Booking Date</td>
                                                    <td>${ticket.bookingDate}</td>
                                                </tr>
                                                <tr>
                                                    <td>Route</td>
                                                    <td>${ticket.route.departureStation} - ${ticket.route.arrivalStation}</td>
                                                </tr>
                                                <tr>
                                                    <td>Departure Time</td>
                                                    <td>${ticket.route.departureTime}</td>
                                                </tr>
                                                <tr>
                                                    <td>Arrival Time</td>
                                                    <td>${ticket.route.arrivalTime}</td>
                                                </tr>
                                                <tr>
                                                    <td>Train</td>
                                                    <td>${ticket.train.trainid} </td>
                                                </tr>
                                                <tr>
                                                    <td>Cabin</td>
                                                    <td>${ticket.cabin.cabinName} - ${ticket.cabin.type}</td>
                                                </tr>
                                                <tr>
                                                    <td>Seat</td>
                                                    <td>${ticket.seat.name}</td>
                                                </tr>
                                            </table>
                                        </div>
                                        <c:if test="${ticket.canCanceled && ticket.status != 0}">
                                            <div class="ticket-footer">
                                                <button class="btn-cancel" data-toggle="modal" data-target="#cancelModal">
                                                    <i class="fas fa-times-circle"></i> Cancel Ticket
                                                </button>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>

                                <a href="transaction" class="btn-back">
                                    <i class="fas fa-arrow-left"></i> Back to Transactions
                                </a>
                            </c:if>

                            <c:if test="${empty tickets}">
                                <div class="empty-state">
                                    <i class="fas fa-ticket-alt"></i>
                                    <p>No ticket details found!</p>
                                    <a href="transaction" class="btn-back">
                                        <i class="fas fa-arrow-left"></i> Back to Transactions
                                    </a>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="cancelModal" tabindex="-1" role="dialog" aria-labelledby="cancelModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="cancel-ticket" method="post">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="cancelModalLabel">Reason for Ticket Cancellation</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" name="ticketId" id="modalTicketId" value="${firstTicketId}" />
                            <div class="form-group">
                                <select class="form-select" id="cancelReason" name="cancelReason" required>
                                    <option value="">-- Select Reason --</option>
                                    <option value="I want to change the train">I want to change the train</option>
                                    <option value="I no longer need to travel">I no longer need to travel</option>
                                    <option value="I want to change seat or cabin">I want to change seat or cabin</option>
                                    <option value="I want to update address/phone number">I want to update address/phone number</option>
                                    <option value="I want to add/change discount code">I want to add/change discount code</option>
                                    <option value="I cannot find a suitable cancellation reason">I cannot find a suitable cancellation reason</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to cancel the ticket?');">Confirm</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%@ include file="components/Footer.jsp" %>
        <%@ include file="components/Script.jsp" %>
    </body>
</html>