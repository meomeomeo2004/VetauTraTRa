<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

<!doctype html>
<html lang="en">
    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="image/favicon.png" type="image/png">
        <title>TraTra</title>
        <%@include file="components/Style.jsp" %>
        <style>
            /* Modern Search Ticket Form Styles */
            .search-form-container {
                background-color: #0a0f1e;
                border-radius: 8px;
                padding: 30px;
                width: 100%;
            }

            .search-form {
                display: grid;
                grid-template-columns: 1fr;
                gap: 20px;
            }

            @media (min-width: 768px) {
                .search-form {
                    grid-template-columns: 2fr 10fr;
                    align-items: center;
                }
            }

            .search-title {
                color: white;
                font-size: 28px;
                font-weight: bold;
                line-height: 1.2;
            }

            .search-fields {
                display: grid;
                grid-template-columns: 1fr;
                gap: 16px;
            }

            @media (min-width: 768px) {
                .search-fields {
                    grid-template-columns: repeat(12, 1fr);
                }

                .field-departure, .field-arrival {
                    grid-column: span 3;
                }

                .field-departure-date, .field-return-date, .field-type {
                    grid-column: span 2;
                }

                .field-search-button {
                    grid-column: 7 / span 6;
                }
            }

            .form-input {
                height: 56px;
                width: 100%;
                padding: 0 15px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                color: black;
            }

            .form-input::placeholder {
                color: #666;
            }

            .form-select {
                height: 56px;
                width: 100%;
                padding: 0 15px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                color: black;
                appearance: none;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
            }

            .date-input {
                height: 56px;
                width: 100%;
                padding: 0 15px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                background-color: white;
                color: black;
                background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Crect x='3' y='4' width='18' height='18' rx='2' ry='2'%3E%3C/rect%3E%3Cline x1='16' y1='2' x2='16' y2='6'%3E%3C/line%3E%3Cline x1='8' y1='2' x2='8' y2='6'%3E%3C/line%3E%3Cline x1='3' y1='10' x2='21' y2='10'%3E%3C/line%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: right 15px center;
                background-size: 16px;
                cursor: pointer;
            }

            .search-button {
                height: 56px;
                width: 100%;
                background-color: #ffc107;
                color: black;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: bold;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .search-button:hover {
                background-color: #ffb300;
            }

            .error-message {
                color: #ff3333;
                margin-bottom: 10px;
            }

            /* Override hotel_booking_area styles */
            .hotel_booking_area.position {
                margin-top: 0;
                padding: 30px 0;
            }
        </style>
    </head>
    <body>
        <!--================Header Area =================-->
        <%@include file="components/Header.jsp" %>
        <!--================Header Area =================-->

        <!--================Banner Area =================-->
        <section class="banner_area">
            <div class="booking_table d_flex align-items-center">
                <div class="overlay bg-parallax" data-stellar-ratio="0.9" data-stellar-vertical-offset="0" data-background=""></div>
                <div class="container">
                    <div class="banner_content text-center">
                        <h6>Live to experience</h6>
                        <h2>Pack up and go</h2>
                        <p>At least once in your life, you must see the place you want to see and go to the place you want to go<br> 
                            See through the train window and go by train gears.</p>
                        <a href="#" class="btn theme_btn button_hover">Get Started</a>
                    </div>
                </div>
            </div>

            <div class="hotel_booking_area position">
                <div class="container">
                    <div class="search-form-container">
                        <form action="Search" method="post" id="ticketSearchForm" class="search-form">
                            <div class="search-title-container">
                                <h2 class="search-title">SEARCH<br>TICKET</h2>
                            </div>

                            <div class="search-fields">
                                <c:if test="${not empty requestScope.error}">
                                    <div class="error-message" style="grid-column: 1 / -1; margin-bottom: 10px;">
                                        <c:out value="${requestScope.error}"/>
                                    </div>
                                </c:if>

                                <!-- First row: Stations and Type -->
                                <div class="field-departure" style="grid-column: span 4;">
                                    <input type="text" id="departure_station" class="form-input" placeholder="Departure station" required>
                                    <input type="hidden" name="departureStation" id="departureStationHidden">
                                </div>

                                <div class="field-arrival" style="grid-column: span 4;">
                                    <input type="text" id="arrival_station" class="form-input" placeholder="Arrival station" required>
                                    <input type="hidden" name="arrivalStation" id="arrivalStationHidden">
                                </div>

                                <div class="field-type" style="grid-column: span 4;">
                                    <select id="trip_type" class="form-select">
                                        <option value="" disabled selected>Type</option>
                                        <option value="oneWay">One way</option>
                                        <option value="roundTrip">Round trip</option>
                                    </select>
                                    <input type="hidden" name="tripType" id="tripTypeHidden">
                                </div>

                                <!-- Second row: Dates and Search button -->
                                <div class="field-departure-date" style="grid-column: span 4;">
                                    <input type="text" id="departure_date" class="date-input" placeholder="Departure Date">
                                    <input type="hidden" name="departureDate" id="departureDateHidden">
                                </div>

                                <div class="field-return-date" style="grid-column: span 4;">
                                    <input type="text" id="arrival_date" class="date-input" placeholder="Return Date">
                                    <input type="hidden" name="arrivalDate" id="arrivalDateHidden">
                                </div>

                                <div class="field-search-button" style="grid-column: span 4;">
                                    <button type="submit" class="search-button">SEARCH</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </section>
        <!-- Optional JavaScript -->
        <%@include file="components/Script.jsp" %>

        <!-- Flatpickr for date picking -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
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
        </script>
        <script>
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

