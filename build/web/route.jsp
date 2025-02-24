<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:forEach var="route" items="${sessionScope.routes}">
            <p>Name: <a href="ViewRoute?id=${route.id}">${route.routeCode}</a></p>
            <p>Departure Station: ${route.departureStation}</p>
            <p>Arrival Station:${route.arrivalStation}</p>
            <p>Departure Time: ${route.departureTime}</p>
            <p>Arrival Time: ${route.arrivalTime}</p>
            ---------------------------
        </c:forEach>
    </body>
</html>
