<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>Key Word</h2>

<p><strong>Departure Station:</strong> ${sessionScope.departureStation}</p>
<p><strong>Arrival Station:</strong> ${sessionScope.arrivalStation}</p>
<p><strong>Departure Date:</strong> ${sessionScope.departureDate}</p>
<p><strong>Arrival Date:</strong> ${sessionScope.arrivalDate}</p>

<h2>Result:</h2>
<c:forEach var="route" items="${sessionScope.routes}">
    <p>name: <a href="ViewRouteInfo?id=${route.id}">${route.name}</a></p>
    <p>Departure Station: ${route.departureStation}</p>
    <p>Arrival Station:${route.arrivalStation}</p>
    <p>Departure Time: ${route.departureTime}</p>
    <p>Arrival Time: ${route.arrivalTime}</p>
    ---------------------------
</c:forEach>
