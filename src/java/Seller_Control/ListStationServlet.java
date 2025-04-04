/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

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

/**
 *
 * @author ASUS
 */
@WebServlet(name="ListStationServlet", urlPatterns={"/liststation"})
public class ListStationServlet extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListStationServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListStationServlet at " + request.getContextPath () + "</h1>");
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
        List<Station> listS = dao.getListStation();               
        List<Train> listT = dao.getListTrainBySellerId(b);
        request.setAttribute("liststation", listS);
        request.setAttribute("listtrain", listT);
        String mess = (String) session.getAttribute("error");
        String messa = (String) session.getAttribute("dif");
        String exist = (String) session.getAttribute("exist");
        session.removeAttribute("error");
        session.removeAttribute("dif");
        session.removeAttribute("exist");
        
        if(mess != null){
            request.setAttribute("abc", mess);
        }
        if(messa != null){
            request.setAttribute("differ", messa);
        }
        if(exist != null){
            request.setAttribute("exist", exist);
        }
        request.getRequestDispatcher("addroute.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

}
