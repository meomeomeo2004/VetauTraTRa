<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Change Password</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
    </head>
    <body>
        <%@include file="components/Header.jsp" %>
        <!--================Breadcrumb Area =================-->
        <section class="breadcrumb_area">
            <div class="overlay bg-parallax" data-stellar-ratio="0.8" data-stellar-vertical-offset="0" data-background=""></div>
            <div class="container">
                <div class="page-cover text-center">
                    <h2 class="page-cover-tittle">Profile</h2>
                    <ol class="breadcrumb">
                        <li><a href="/tratra">Home</a></li>
                        <li class="active">Change Password</li>
                    </ol>
                </div>
            </div>
        </section>
        <!--================Breadcrumb Area =================-->

        <section class="contact_area section_gap">
            <div class="container">
                <div class="row">
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
                                    <a href="change-password" class="profile-nav-link active">
                                        <i class="fas fa-lock"></i> Change Password
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="transaction" class="profile-nav-link">
                                        <i class="fas fa-history"></i> Transaction History
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
            </div>
        </section>
        <%@include file="components/Footer.jsp" %>
        <%@include file="components/Message.jsp" %>
        <%@include file="components/Script.jsp" %>
    </body>
</html>