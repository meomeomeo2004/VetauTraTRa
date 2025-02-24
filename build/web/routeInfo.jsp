<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <c:if test="${not empty sessionScope.route}">
        <p><strong>Name:</strong> ${sessionScope.route.routeCode}</p>
        <p><strong>Train:</strong> ${route.trainId}</p>
        <p><strong>Description:</strong> ${route.description}</p>
        <p><strong>Departure Station:</strong> ${sessionScope.route.departureStation}</p>
        <p><strong>Arrival Station:</strong> ${sessionScope.route.arrivalStation}</p>
        <p><strong>Departure Time:</strong> ${sessionScope.route.departureTime}</p>
        <p><strong>Arrival Time:</strong> ${sessionScope.route.arrivalTime}</p>
        <p><strong>Status:</strong> ${sessionScope.route.status}</p>
    </p>
</c:if>
</body>
</html>
