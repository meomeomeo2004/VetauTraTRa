/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.adminController;

import dal.DAOforAdmin;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.TransLog;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "TransactionLog", urlPatterns = {"/admin_page/TransactionLog"})
public class TransactionLog extends HttpServlet {

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
            out.println("<title>Servlet TransactionLog</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TransactionLog at " + request.getContextPath() + "</h1>");
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

        request.getRequestDispatcher("TransactionLog.jsp").forward(request, response);
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
        DAOforAdmin dao = new DAOforAdmin();
        List<TransLog> trans_list = dao.getTransactionLog();

        JSONArray jsonArray = new JSONArray();
        int i = 0;
        for (TransLog trans : trans_list) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("id", i);
            i++;
            jsonObject.put("fromPerson", trans.getFromPerson());
            jsonObject.put("toPerson", trans.getToPerson());
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm");
            String formattedDate = formatter.format(trans.getDate());
            jsonObject.put("date", formattedDate);

            jsonObject.put("amount", trans.getAmount());
            String type = null;
            if (trans.getType() == 1) {
                type = "Booked";
            } else if (trans.getType() == 0) {
                type = "Refunded";
            }
            jsonObject.put("type", type);

            jsonArray.put(jsonObject);
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();

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
