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
        <title>Seller Profile</title>
        <%@include file="components/Style.jsp" %>
        <%@include file="components/StyleProfile.jsp" %>
        <%@include file="components/StyleButton.jsp" %>
    </head>

    <body>

        <a href="../src/java/model/User.java"></a>
        <!--================Header Area =================-->
        <section class="contact_area section_gap">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-4">
                        <div class="profile-nav-card">
                            <div class="profile-nav-header">
                                Seller Menu
                            </div>
                            <ul class="profile-nav-list">
                                <li class="profile-nav-item">
                                    <a href="seller-profile" class="profile-nav-link">
                                        <i class="fas fa-user"></i> View Profile
                                    </a>
                                </li>
                                <li class="profile-nav-item">
                                    <a href="update-seller-profile" class="profile-nav-link active">
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
                        <div class="content-card">
                            <div class="content-card-header">
                                <h3 class="content-card-title">Update Profile</h3>
                            </div>

                            <form action="update-seller-profile" method="post">
                                <input type="hidden" name="id" value="${sessionScope.account.id}">

                                <div class="form-group">

                                    <label class="form-label">Full Name</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-user form-icon"></i>
                                        <input type="text" name="fullName" class="form-control-custom" value="${seller.fullName}" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-envelope form-icon"></i>
                                        <input type="email" name="email" class="form-control-custom" value="${sessionScope.account.email}" disabled="">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Phone Number</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-phone form-icon"></i>
                                        <input type="tel" name="phoneNumber" class="form-control-custom" value="${seller.phoneNumber}" required>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Address</label>
                                    <div class="input-wrapper">
                                        <i class="fas fa-map-marker-alt form-icon"></i>
                                        <input type="text" name="address" class="form-control-custom" value="${seller.address}" required>
                                    </div>
                                </div>
                                <button type="submit" name="submit" value="update" class="btn-submit">
                                    <i class="fas fa-check-circle"></i> Update Profile
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="d-flex justify-content-end mb-4 mt-5">
                    <a href="#" class="btn btn-custom-yellow ms-2"><i class="fas fa-home"></i> Back to Dashboard</a>
                </div>
            </div>
        </section>

        <!--================ start footer Area  =================-->
        <%@include file="components/Footer.jsp" %>
        <!--================ End footer Area  =================-->

        <%@include file="components/Message.jsp" %>
    </body>
</html>
