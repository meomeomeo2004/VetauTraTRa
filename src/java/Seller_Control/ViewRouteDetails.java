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
import java.util.List;
import model.Route;
import model.Train;


@WebServlet(name="ViewRouteDetails", urlPatterns={"/ViewRouteDetails"})
public class ViewRouteDetails extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewRouteDetails</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewRouteDetails at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String rouid = request.getParameter("routeid");
        int routeid = Integer.parseInt(rouid);
        SellerDAO dao = new SellerDAO();
        List<Train> list = dao.getListTrainBySellerId(routeid);
        Route rou = dao.getRouteDetails(routeid);   
        String trainModel = "";  
        for (Train b : list) {
            if (b.getId()== rou.getTrainId()) {
                trainModel = b.getTrainid();  
                
                break;
            }
        }
        System.out.println("Selected Train Model: " + trainModel);
        request.setAttribute("trainname", trainModel);          
        request.setAttribute("a", rou);
        request.setAttribute("rid", routeid);
        request.getRequestDispatcher("ViewRouteDetails.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Lấy tham số từ form
            String rid = request.getParameter("routeId");
            String status = request.getParameter("status");

            // Kiểm tra nếu trainId hoặc status bị null
            if (rid == null || status == null) {
                request.setAttribute("errorMessage", "Train ID or Status is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int rouid = Integer.parseInt(rid);
            int newStatus = Integer.parseInt(status);

            // Gọi hàm DAO để cập nhật trạng thái
            SellerDAO dao = new SellerDAO();
            dao.updateRouteStatus(rouid, newStatus);

            // Chuyển hướng về trang danh sách tàu
            response.sendRedirect("viewlistroute");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid train ID or status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating train status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }

    }  
}
