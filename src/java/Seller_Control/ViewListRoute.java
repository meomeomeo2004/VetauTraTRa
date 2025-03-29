
package seller;

import dal.SellerDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Route;
import model.User;


@WebServlet(name="ViewListRoute", urlPatterns={"/viewlistroute"})

public class ViewListRoute extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewListRoute</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewListRoute at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        HttpSession session = request.getSession();
        SellerDAO dao = new SellerDAO();
        User a = (User) session.getAttribute("account");
        int b = a.getId();
        List<Route> list = dao.getListRouteBySeller(b);
        request.setAttribute("listroute", list);
        
        String editerror = (String) session.getAttribute("erro");
        String delete = (String) session.getAttribute("deletesucess");
        String update = (String) session.getAttribute("update");
        String updatestatus = (String) session.getAttribute("updatestatus");
        String addsuces = (String) session.getAttribute("addsuces");
        session.removeAttribute("erro");
        session.removeAttribute("deletesucess");
        session.removeAttribute("update");
        session.removeAttribute("updatestatus");
        session.removeAttribute("addsuces");
        if (editerror != null) {
        request.setAttribute("editerror", editerror);
        }
        if (delete != null) {
        request.setAttribute("deletesuc", delete);
        }
        if (update != null) {
        request.setAttribute("update", update);
        }
        if (updatestatus != null) {
        request.setAttribute("updatestatus", updatestatus);
        }
        if (addsuces != null) {
        request.setAttribute("addsuces", addsuces);
        }
        request.getRequestDispatcher("manageroute.jsp").forward(request, response);
}



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


}
