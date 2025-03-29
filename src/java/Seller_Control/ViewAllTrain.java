/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Seller_Control;

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
import model.Station;
import model.Train;
import model.User;


@WebServlet(name="ViewAllTrain", urlPatterns={"/ViewAllTrain"})
public class ViewAllTrain extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewAllTrain</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAllTrain at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        User a = (User) session.getAttribute("account");
        int b = a.getId();
        SellerDAO dao = new SellerDAO();               
        List<Train> listT = dao.getListTrainBySellerId(b);
        String trainstatus = (String) session.getAttribute("trainstatus");
        session.removeAttribute("trainstatus");
        if(trainstatus != null){
            request.setAttribute("trainstatus", trainstatus);
        }
        request.setAttribute("trainList", listT);
        request.getRequestDispatcher("Seller_MyTrain.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }



}
