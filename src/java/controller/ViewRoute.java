
package controller;

import dal.RouteDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Route;

/**
 *
 * @author hoatu
 */
public class ViewRoute extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        RouteDAO routeDAO = new RouteDAO();
        Route route = routeDAO.getRouteById(id);
        
        if (route != null) {
            HttpSession session = request.getSession();
            session.setAttribute("route", route);
        } else {
            System.out.println("Can't find Route with ID: " + id);
        }
    } catch (NumberFormatException e) {
        System.out.println("Bad id: " + e.getMessage());
    }
    
    response.sendRedirect("routeInfo.jsp");
}

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
