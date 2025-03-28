/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Seller_Control;

import dal.ManagerDAO;
import dal.SellerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Train;
import model.User;

@WebServlet(name = "WaitingTrainList", urlPatterns = {"/waiting"})
public class WaitingTrainList extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet WaitingTrainList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WaitingTrainList at " + request.getContextPath() + "</h1>");
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
        if (a.getRole().equals("Seller")) {
            int b = a.getId();
            List<Train> listT = dao.getWaitingList(b);
            request.setAttribute("trainl", listT);
            request.getRequestDispatcher("WaitingTrainList.jsp").forward(request, response);
            return;
        }
        if (a.getRole().equals("Manager")) {
            ManagerDAO mdao = new ManagerDAO();
            List<Train> lista = mdao.getListTrain();
            request.setAttribute("trainl", lista);
            request.getRequestDispatcher("Manager_WaitingList.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
