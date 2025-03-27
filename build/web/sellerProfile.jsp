<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>Royal Hotel</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
        <%@include file="components/StyleButton.jsp" %>
    </head>
    <body>


        <!--================Contact Area =================-->
        <section class="contact_area section_gap">
            <div class="container">
                <div class="row">

                    <div class="row">
                        <!-- Sidebar Navigation -->
                        <div class="col-lg-3 col-md-4">
                            <div class="profile-nav-card">
                                <div class="profile-nav-header">
                                    Account Menu
                                </div>
                                <ul class="profile-nav-list">
                                    <li class="profile-nav-item">
                                        <a href="seller-profile" class="profile-nav-link active">
                                            <i class="fas fa-user"></i> View Profile
                                        </a>
                                    </li>
                                    <li class="profile-nav-item">
                                        <a href="update-seller-profile" class="profile-nav-link">
                                            <i class="fas fa-edit"></i> Update Profile
                                        </a>
                                    </li>
                                    <li class="profile-nav-item">
                                        <a href="change-seller-password" class="profile-nav-link">
                                            <i class="fas fa-lock"></i> Change Password
                                        </a>
                                    </li>

                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-8">
                            <div class="content-card border">
                                <div class="content-card-header">
                                    <h3 class="content-card-title">Your Profile</h3>
                                </div>

                                <div class="profile-info">
                                    <div class="profile-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="profile-details">
                                        <h4>${seller.fullName}</h4>
                                        <a href="update-seller-profile" class="btn-edit">
                                            <i class="fas fa-edit mr-2" style="margin-right: 10px;"></i> Edit Profile
                                        </a>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Full Name</label>
                                    <div class="input-group">
                                        <div class="input-group-text"><i class="bi bi-person-fill"></i></div>
                                        <input type="text" class="form-control " value="${seller.fullName}" disabled>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <div class="input-group">
                                        <div class="input-group-text">
                                            <i class="bi bi-envelope-fill"></i>
                                        </div>
                                        <input type="email" class="form-control" value="${sessionScope.account.email}" disabled>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <div class="input-group">
                                        <div class="input-group-text">
                                            <i class="bi bi-phone-fill"></i>
                                        </div>
                                        <input type="email" class="form-control" value="${seller.phoneNumber}" disabled>
                                    </div></div>

                                <div class="form-group">
                                    <label class="form-label">Address</label><div class="input-group">
                                        <div class="input-group-text">
                                            <i class="bi bi-pin-map-fill"></i>
                                        </div>
                                        <input type="email" class="form-control" value="${seller.address}" disabled>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end mb-4 mt-5">
                    <a href="#" class="btn btn-custom-yellow ms-2"><i class="fas fa-home"></i> Back to Dashboard</a>
                </div>
            </div>
        </section>
        <!--================Contact Area =================-->

        <!--================ start footer Area  =================-->
        <%@include file="components/Footer.jsp" %>

    </body>
</html>