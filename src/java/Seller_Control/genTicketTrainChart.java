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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import model.User;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "genTicketTrainChart", urlPatterns = {"/genTicketTrainChart"})
public class genTicketTrainChart extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet genTicketTrainChart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet genTicketTrainChart at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        SellerDAO dao = new SellerDAO();
        HttpSession session = request.getSession();
        User acc = new User();
        try {
            acc = (User) session.getAttribute("account");
            if (acc == null) {
                throw new Exception();
            }
        } catch (Exception e) {
            response.sendRedirect("./seller/login");
            return;
        }
        List<String> ticketontrain = dao.getTicketOnTrain(String.valueOf(acc.getId()));
        
        List<String> lable = new ArrayList<>();
        List<Integer> data = new ArrayList<>();
        
        for(String i : ticketontrain){
            if(!lable.contains(i)){
                lable.add(i);
                data.add(0);
            }
        }
        int c = 0;
        for(String l : lable){
            for(String i : ticketontrain){
                if(i.equals(l)){
                    data.set(c, data.get(c)+1);
                }
            }
            c++;
        }

        JSONArray lastDuration = new JSONArray();
        JSONArray visitorCounts = new JSONArray();
        for (int i = 0; i < lable.size(); i++) {
            lastDuration.put(lable.get(i));
            visitorCounts.put(data.get(i));
        }

        JSONObject responseData = new JSONObject();
        responseData.put("labels", lastDuration);
        responseData.put("data", visitorCounts);

        PrintWriter out = response.getWriter();
        out.print(responseData.toString());
        out.flush();
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
