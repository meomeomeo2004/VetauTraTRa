<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<!DOCTYPE html>
<html>
    <head>
        <title>Route Details</title>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Roboto', sans-serif;
            }
            
            body {
                background-color: #f5f5f5;
                color: #333;
                padding: 20px;
            }
            
            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                padding: 30px;
            }
            
            h2 {
                color: #22577a;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
                font-weight: 500;
                position: relative;
                padding-bottom: 15px;
            }
            
            h2:after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 3px;
                background-color: #22577a;
            }
            
            table {
                width: 100%;
                margin: 20px auto;
                border-collapse: collapse;
                border-radius: 6px;
                overflow: hidden;
                box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
            }
            
            th, td {
                padding: 15px;
                text-align: center;
                border: none;
            }
            
            th {
                background-color: #22577a;
                color: white;
                font-weight: 500;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 0.5px;
            }
            
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            
            tr:hover {
                background-color: #f0f7fa;
            }
            
            td {
                border-bottom: 1px solid #eee;
            }
            
            .switch {
                position: relative;
                display: inline-block;
                width: 50px;
                height: 24px;
            }
            
            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }
            
            .slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #ccc;
                transition: .4s;
                border-radius: 24px;
            }
            
            .slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 3px;
                bottom: 3px;
                background-color: white;
                transition: .4s;
                border-radius: 50%;
            }
            
            input:checked + .slider {
                background-color: #22577a;
            }
            
            input:focus + .slider {
                box-shadow: 0 0 1px #22577a;
            }
            
            input:checked + .slider:before {
                transform: translateX(26px);
            }
            
            .footer {
                text-align: center;
                margin-top: 30px;
                color: #777;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Route Details</h2>
            <table>
                <thead>
                    <tr>
                        <th>Route ID</th>
                        <th>Train Model</th>
                        <th>Departure Station</th>
                        <th>Arrival Station</th>
                        <th>Departure Date</th>
                        <th>Departure Hour</th>
                        <th>Arrival Date</th>
                        <th>Arrival Hour</th>
                        <c:if test="${a.status == 0}">
                        <th>Action</th>
                        </c:if>
                        
                    </tr>
                </thead>
                <tbody>
                    
                        <tr>
                            <td>${a.routeCode}</td>                           
                            <td>${a.trainId}</td>
                            <td>${a.departureStation}</td>
                            <td>${a.arrivalStation}</td>
                            <td>${a.departureDate}</td>
                            <td>${a.departureHour}</td>
                            <td>${a.arrivalDate}</td>
                            <td>${a.arrivalHour}</td>
                            <c:if test="${a.status == 0}">
                            <td>
                                
                                    <form action="UpdateStatusRoute" method="POST">
                                        <label class="switch">
                                            <input type="checkbox" name="status" value="1" onchange="this.form.submit()">
                                            <span class="slider"></span>
                                        </label>
                                        <input type="hidden" name="routeId" value="${a.id}"/>
                                    </form>
                               
                            </td>
                            </c:if>
                        </tr>
                    
                </tbody>
            </table>
            <div class="footer">
                &copy; 2023 Train Route Management System
            </div>
        </div>
    </body>
</html>