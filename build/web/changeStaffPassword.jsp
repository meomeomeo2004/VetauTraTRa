<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Change Password - Staff</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
        <%@include file="components/StyleButton.jsp" %>
    </head>
    <body>
        <!--================Breadcrumb Area =================-->

        <section class="contact_area section_gap">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-4">
                        <div class="profile-nav-card">
                            <div class="profile-nav-header">
                                Staff Menu
                            </div>
                            <ul class="profile-nav-list">
                                <li class="profile-nav-item">
                                    <a href="staff-profile" class="profile-nav-link">
                                        <i class="fas fa-user"></i> View Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="update-staff-profile" class="profile-nav-link">
                                        <i class="fas fa-edit"></i> Update Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="change-staff-password" class="profile-nav-link active">
                                        <i class="fas fa-lock"></i> Change Password
                                    </a>
                                </li>

                            </ul>
                        </div>
                    </div>

                    <div class="col-lg-9 col-md-8">
                        <div class="content-card">
                            <div class="content-card-header">
                                <h3 class="content-card-title">Change Password</h3>
                            </div>

                            <form action="change-password" method="post">
                                <input type="hidden" name="id" value="${sessionScope.account.id}">

                                <div class="form-group">
                                    <label class="form-label">Current Password</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-key form-icon"></i>
                                        <input type="password" name="oldPassword" class="form-control-custom" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">New Password</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock form-icon"></i>
                                        <input type="password" name="newPassword" class="form-control-custom" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Confirm New Password</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-lock-open form-icon"></i>
                                        <input type="password" name="renewPassword" class="form-control-custom" required>
                                    </div>
                                </div>

                                <button type="submit" class="btn-submit">
                                    <i class="fas fa-check-circle"></i> Update Password
                                </button>

                                <div class="password-requirements">
                                    <h5><i class="fas fa-shield-alt"></i> Password Requirements</h5>
                                    <ul class="requirement-list">
                                        <li class="requirement-item">
                                            <i class="fas fa-check-circle"></i> At least 8 characters
                                        </li>
                                        <li class="requirement-item">
                                            <i class="fas fa-check-circle"></i> Include uppercase and lowercase letters
                                        </li>
                                        <li class="requirement-item">
                                            <i class="fas fa-check-circle"></i> Include at least one number
                                        </li>
                                        <li class="requirement-item">
                                            <i class="fas fa-check-circle"></i> Include at least one special character
                                        </li>
                                    </ul>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end mb-4 mt-5">
                    <a href="staff_page/ticketList" class="btn btn-custom-navy"><i class="fas fa-arrow-left"></i> Back to Ticket List</a>
                    <a href="staff_page/staffDashboard" class="btn btn-custom-yellow ms-2"><i class="fas fa-home"></i> Back to Dashboard</a>
                </div>
            </div>
        </section>
        <%@include file="components/Footer.jsp" %>
        <%@include file="components/Message.jsp" %>
    </body>
</html>
