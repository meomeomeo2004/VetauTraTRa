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
        <title>TraTra</title>

        <!-- Include your existing styles -->
        <%@include file="components/Style.jsp" %>

        <!-- Include the new modern styles -->
        <link rel="stylesheet" href="css/modern-style.css">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!-- Flatpickr for date picking -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    </head>
    <body>
        <!--================Header Area =================-->
        <%@include file="components/Header.jsp" %>
        <!--================Header Area =================-->

        <!--================Hero Section =================-->
        <section class="hero-section">
            <div class="hero-background" style="background-image: url('image/banner_bg.jpg');"></div>
            <div class="hero-overlay"></div>
            <div class="container">
                <div class="hero-content">
                    <h6 class="hero-subtitle">LIVE TO EXPERIENCE</h6>
                    <h2 class="hero-title">Pack up and go</h2>
                    <p class="hero-description">
                        At least once in your life, you must see the place you want to see and go to the place you want to go.
                        See through the train window and go by train gears.
                    </p>
                    <a href="#" class="btn-primary">Get Started</a>
                </div>
            </div>
        </section>

        <!--================Search Form Section =================-->
        <section class="search-section">
            <div class="container">
                <div class="search-card">
                    <div class="search-grid">
                        <div class="search-sidebar">
                            <h2 class="search-title">SEARCH TICKET</h2>
                            <p class="search-subtitle">Find your perfect journey</p>
                        </div>

                        <div class="search-form-container">
                            <form action="Search" method="post" id="ticketSearchForm">
                                <c:if test="${not empty requestScope.error}">
                                    <div class="error-message">
                                        <c:out value="${requestScope.error}"/>
                                    </div>
                                </c:if>

                                <div class="form-grid">
                                    <!-- Departure Station -->
                                    <div class="form-group">
                                        <label class="form-label" for="departure_station">Departure Station</label>
                                        <div class="input-with-icon">
                                            <i class="fas fa-map-marker-alt input-icon"></i>
                                            <input type="text" id="departure_station" class="form-control" placeholder="Enter departure station" required>
                                            <input type="hidden" name="departureStation" id="departureStationHidden">
                                        </div>
                                    </div>

                                    <!-- Arrival Station -->
                                    <div class="form-group">
                                        <label class="form-label" for="arrival_station">Arrival Station</label>
                                        <div class="input-with-icon">
                                            <i class="fas fa-map-marker-alt input-icon"></i>
                                            <input type="text" id="arrival_station" class="form-control" placeholder="Enter arrival station" required>
                                            <input type="hidden" name="arrivalStation" id="arrivalStationHidden">
                                        </div>
                                    </div>

                                    <!-- Trip Type -->
                                    <div class="form-group">
                                        <label class="form-label" for="trip_type">Trip Type</label>
                                        <select id="trip_type" class="form-select">
                                            <option value="" disabled selected>Select trip type</option>
                                            <option value="oneWay">One way</option>
                                            <option value="roundTrip">Round trip</option>
                                        </select>
                                        <input type="hidden" name="tripType" id="tripTypeHidden">
                                    </div>

                                    <!-- Departure Date -->
                                    <div class="form-group">
                                        <label class="form-label" for="departure_date">Departure Date</label>
                                        <div class="input-with-icon">
                                            <i class="fas fa-calendar input-icon"></i>
                                            <input type="text" id="departure_date" class="form-control" placeholder="Select departure date">
                                            <input type="hidden" name="departureDate" id="departureDateHidden">
                                        </div>
                                    </div>

                                    <!-- Return Date -->
                                    <div class="form-group">
                                        <label class="form-label" for="arrival_date">Return Date</label>
                                        <div class="input-with-icon">
                                            <i class="fas fa-calendar input-icon"></i>
                                            <input type="text" id="arrival_date" class="form-control" placeholder="Select return date">
                                            <input type="hidden" name="arrivalDate" id="arrivalDateHidden">
                                        </div>
                                    </div>

                                    <!-- Search Button -->
                                    <div class="form-group">
                                        <label class="form-label" style="visibility: hidden;">Search</label>
                                        <button type="submit" class="btn-search">SEARCH</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--================Destinations Section =================-->
        <section class="section">
            <div class="container">
                <div class="section-title-container">
                    <h2 class="section-title">Popular Destinations</h2>
                    <p class="section-description">
                        Discover the most popular train destinations across the country. 
                        Experience breathtaking views and unforgettable journeys.
                    </p>
                </div>

                <div class="destinations-grid">
                    <!-- Destination 1 -->
                    <div class="destination-card">
                        <img src="image/destinations/hanoi.jpg" alt="Hanoi" class="destination-image">
                        <div class="destination-overlay">
                            <h3 class="destination-name">Hanoi</h3>
                            <a href="#" class="btn-outline">Explore</a>
                        </div>
                    </div>

                    <!-- Destination 2 -->
                    <div class="destination-card">
                        <img src="image/destinations/ho-chi-minh.jpg" alt="Ho Chi Minh City" class="destination-image">
                        <div class="destination-overlay">
                            <h3 class="destination-name">Ho Chi Minh City</h3>
                            <a href="#" class="btn-outline">Explore</a>
                        </div>
                    </div>

                    <!-- Destination 3 -->
                    <div class="destination-card">
                        <img src="image/destinations/da-nang.jpg" alt="Da Nang" class="destination-image">
                        <div class="destination-overlay">
                            <h3 class="destination-name">Da Nang</h3>
                            <a href="#" class="btn-outline">Explore</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!--================Features Section =================-->
        <section class="features-section">
            <div class="container">
                <div class="section-title-container">
                    <h2 class="section-title">Why Choose TraTra</h2>
                    <p class="section-description">
                        We provide the best train travel experience with comfortable seats, 
                        scenic routes, and excellent service.
                    </p>
                </div>

                <div class="features-grid">
                    <!-- Feature 1 -->
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-alt fa-3x"></i>
                        </div>
                        <h3 class="feature-title">Easy Booking</h3>
                        <p class="feature-description">Simple and fast online booking process</p>
                    </div>

                    <!-- Feature 2 -->
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-train fa-3x"></i>
                        </div>
                        <h3 class="feature-title">Best Prices</h3>
                        <p class="feature-description">Competitive prices and regular promotions</p>
                    </div>

                    <!-- Feature 3 -->
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-headset fa-3x"></i>
                        </div>
                        <h3 class="feature-title">24/7 Support</h3>
                        <p class="feature-description">Customer support available all day, every day</p>
                    </div>

                    <!-- Feature 4 -->
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-couch fa-3x"></i>
                        </div>
                        <h3 class="feature-title">Comfortable Travel</h3>
                        <p class="feature-description">Modern trains with all necessary amenities</p>
                    </div>
                </div>
            </div>
        </section>

        <!--================Footer =================-->
        <footer class="footer">
            <div class="container">
                <div class="footer-grid">
                    <div>
                        <h3 class="footer-brand">TraTra</h3>
                        <p class="footer-description">
                            Your reliable partner for train travel. Explore the country with comfort and style.
                        </p>
                    </div>

                    <div>
                        <h4 class="footer-heading">Quick Links</h4>
                        <ul class="footer-links">
                            <li><a href="#">Home</a></li>
                            <li><a href="#">About Us</a></li>
                            <li><a href="#">Services</a></li>
                            <li><a href="#">Contact</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="footer-heading">Popular Routes</h4>
                        <ul class="footer-links">
                            <li><a href="#">Hanoi - Ho Chi Minh</a></li>
                            <li><a href="#">Hanoi - Da Nang</a></li>
                            <li><a href="#">Ho Chi Minh - Nha Trang</a></li>
                            <li><a href="#">Da Nang - Hue</a></li>
                        </ul>
                    </div>

                    <div>
                        <h4 class="footer-heading">Contact Us</h4>
                        <address class="footer-address">
                            <p>123 Train Street</p>
                            <p>Hanoi, Vietnam</p>
                            <p>Email: info@tratra.com</p>
                            <p>Phone: +84 123 456 789</p>
                        </address>
                    </div>
                </div>

                <div class="footer-bottom">
                    <p>&copy; <%= new java.util.Date().getYear() + 1900 %> TraTra. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Include your existing scripts -->
        <%@include file="components/Script.jsp" %>

        <!-- Flatpickr for date picking -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

        <!-- Your custom JavaScript -->
        <script>
            // Biến lưu trữ các ga hợp lệ
            let validDepartureStations = [];
            let validArrivalStations = [];

            // Hàm kiểm tra ga hợp lệ
            function validateStation(stationName, validStationList) {
                return validStationList.includes(stationName);
            }

            // Hàm kiểm tra ga đi và ga đến
            function validateStations() {
                const departureStation = $("#departure_station").val().trim();
                const arrivalStation = $("#arrival_station").val().trim();

                // Kiểm tra ga đi
                if (!validateStation(departureStation, validDepartureStations)) {
                    alert("Please enter a valid departure station");
                    $("#departure_station").focus();
                    return false;
                }

                // Kiểm tra ga đến
                if (!validateStation(arrivalStation, validArrivalStations)) {
                    alert("Please enter a valid arrival station");
                    $("#arrival_station").focus();
                    return false;
                }

                return true;
            }

            // Autocomplete cho Departure Station
            $("#departure_station").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "/tratra/Search",
                        method: "GET",
                        data: {
                            query: request.term
                        },
                        dataType: "json",
                        success: function (data) {
                            console.log("Departure Station Data:", data);
                            if (data && data.length > 0) {
                                validDepartureStations = data.map(function (station) {
                                    return station.name;
                                });
                                response(validDepartureStations);
                            } else {
                                response([]);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("AJAX error for Departure Station: " + status + " - " + error);
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    console.log("Selected Departure Station: " + ui.item.value);
                    $(this).val(ui.item.value);
                    return true;
                }
            }).on('input', function () {
                const stationName = $(this).val();
                if (!validateStation(stationName, validDepartureStations)) {
                    console.log("Invalid Departure Station:", stationName);
                }
            });

            // Autocomplete cho Arrival Station
            $("#arrival_station").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "/tratra/Search",
                        method: "GET",
                        data: {
                            query: request.term
                        },
                        dataType: "json",
                        success: function (data) {
                            console.log("Arrival Station Data:", data);
                            if (data && data.length > 0) {
                                validArrivalStations = data.map(function (station) {
                                    return station.name;
                                });
                                response(validArrivalStations);
                            } else {
                                response([]);
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log("AJAX error for Arrival Station: " + status + " - " + error);
                        }
                    });
                },
                minLength: 1,
                select: function (event, ui) {
                    console.log("Selected Arrival Station: " + ui.item.value);
                    $(this).val(ui.item.value);
                    return true;
                }
            }).on('input', function () {
                const stationName = $(this).val();
                if (!validateStation(stationName, validArrivalStations)) {
                    console.log("Invalid Arrival Station:", stationName);
                }
            });

            // Hàm cập nhật các input ẩn
            function updateHiddenInputs() {
                const departureStation = document.getElementById('departure_station').value.trim();
                const arrivalStation = document.getElementById('arrival_station').value.trim();
                const departureDate = document.getElementById('departure_date').value;
                const arrivalDate = document.getElementById('arrival_date').value;
                const tripType = document.getElementById('trip_type').value;

                if (departureStation === arrivalStation) {
                    alert('Departure and arrival stations cannot be the same');
                    return false;
                }

                if (!tripType) {
                    alert('Please select type');
                    document.getElementById('trip_type').focus();
                    return false;
                }

                if (!departureDate) {
                    alert('Please select departure date');
                    document.getElementById('departure_date').focus();
                    return false;
                }

                if (tripType === 'roundTrip' && !arrivalDate) {
                    alert('Please select return date');
                    document.getElementById('arrival_date').focus();
                    return false;
                }

                document.getElementById('departureStationHidden').value = departureStation;
                document.getElementById('arrivalStationHidden').value = arrivalStation;
                document.getElementById('departureDateHidden').value = departureDate;
                document.getElementById('arrivalDateHidden').value = arrivalDate || '';
                document.getElementById('tripTypeHidden').value = tripType;

                return true;
            }

            // Sự kiện submit duy nhất
            document.getElementById('ticketSearchForm').addEventListener('submit', function (event) {
                if (!validateStations() || !updateHiddenInputs()) {
                    event.preventDefault(); // Ngăn form submit nếu validation thất bại
                }
            });

            // Initialize Flatpickr date pickers
            const departurePicker = flatpickr("#departure_date", {
                dateFormat: "Y-m-d",
                minDate: "today",
                onChange: function (selectedDates, dateStr) {
                    // Update minDate of Arrival Date when Departure Date is selected
                    arrivalPicker.set('minDate', dateStr);

                    // If trip type is round trip, adjust arrival date if needed
                    const tripType = document.getElementById('trip_type').value;
                    if (tripType === 'roundTrip') {
                        const arrivalDate = arrivalPicker.input.value;
                        if (arrivalDate && new Date(arrivalDate) < new Date(dateStr)) {
                            arrivalPicker.setDate(new Date(dateStr.replace(/-/g, '/')).setDate(new Date(dateStr).getDate() + 1), true);
                        }
                    }
                }
            });

            const arrivalPicker = flatpickr("#arrival_date", {
                dateFormat: "Y-m-d",
                minDate: "today",
                onChange: function (selectedDates, dateStr) {
                    const tripType = document.getElementById('trip_type').value;

                    // Only validate for round trip
                    if (tripType === 'roundTrip') {
                        const departureDate = departurePicker.input.value;
                        if (departureDate && new Date(dateStr) < new Date(departureDate)) {
                            // Set arrival date to the same day as departure if earlier
                            arrivalPicker.setDate(new Date(departureDate), true);
                        }
                    }
                }
            });

            document.getElementById('trip_type').addEventListener('change', function () {
                const tripType = this.value;
                const arrivalDateInput = document.getElementById('arrival_date');

                if (tripType === 'oneWay') {
                    // Disable and clear arrival date for one-way trip
                    arrivalDateInput.disabled = true;
                    arrivalDateInput.value = '';
                    arrivalPicker.clear();
                } else {
                    // Enable arrival date for round trip
                    arrivalDateInput.disabled = false;
                }
            });
        </script>
    </body>
</html>