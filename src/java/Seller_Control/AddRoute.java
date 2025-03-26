/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package seller;

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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import model.Route;
import model.User;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "AddRoute", urlPatterns = {"/AddRoute"})
public class AddRoute extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddTrip</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddTrip at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Lấy các tham số từ form
        String trainidParam = request.getParameter("trainid");
        String rcode = request.getParameter("routecode");
        String description = request.getParameter("description");
        String depDateTimeParam = request.getParameter("departureDateTime"); // yyyy-MM-ddTHH:mm
        String arrDateTimeParam = request.getParameter("returnDateTime");    // yyyy-MM-ddTHH:mm
        String depStation = request.getParameter("departureStation");
        String arrStation = request.getParameter("arrivalStation");

        // Ép kiểu trainid sang int
        int trainid = Integer.parseInt(trainidParam);
        
        try {
            // Chuẩn bị DAO
            SellerDAO dao = new SellerDAO();
            ManagerDAO mdao = new ManagerDAO();
            // Định dạng phù hợp với input type="datetime-local"
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

            // Parse chuỗi sang LocalDateTime
            LocalDateTime departureDateTime = LocalDateTime.parse(depDateTimeParam, formatter);
            LocalDateTime arrivalDateTime = LocalDateTime.parse(arrDateTimeParam, formatter);

            // Lấy thời gian hiện tại
            LocalDateTime now = LocalDateTime.now();
            // Thời gian hiện tại + 2 giờ
            LocalDateTime nowPlus2h = now.plusHours(7);

            // (1) Kiểm tra Departure >= (hiện tại + 2 tiếng)
            if (departureDateTime.isBefore(nowPlus2h)) {
                // Không thoả mãn -> báo lỗi, forward lại trang add
                request.setAttribute("errorMessage",
                        "Departure time must be at least 2 hours from now!");
                // forward lại trang JSP (ví dụ addRoute.jsp) để user sửa
                response.sendRedirect("liststation");
                return;
            }

            // (2) Kiểm tra Arrival >= Departure + 30 phút
            LocalDateTime departurePlus30m = departureDateTime.plusMinutes(30);
            if (arrivalDateTime.isBefore(departurePlus30m)) {
                request.setAttribute("errorMessage",
                        "Arrival time must be at least 30 minutes after Departure!");
                response.sendRedirect("liststation");
                return;
            }
            Train train = mdao.getTrainById(trainid);
            if(train.getStatus() != 1) {
                 response.sendRedirect("liststation");
            }
            int g = -1;
            User a = (User) session.getAttribute("account");
            int b = a.getId();
            List<Route> list = dao.getListRouteBySeller(b);
            for(Route r : list){
                if(r.getRouteCode().equals(rcode)){
                    g = 1;
                }            
            }
            if(g == 1){
                response.sendRedirect("liststation");
            }
            
            // Nếu mọi kiểm tra đều OK -> thêm vào DB
            dao.addRoute(trainid, rcode, description,
                    depDateTimeParam, arrDateTimeParam,
                    depStation, arrStation);

            // Chuyển hướng về danh sách routes
            response.sendRedirect("viewlistroute");

        } catch (Exception e) {
            // Nếu parse date hoặc lỗi khác
            e.printStackTrace();
            // Gửi thông báo lỗi
            request.setAttribute("errorMessage",
                    "An error occurred while adding the route: " + e.getMessage());
            request.getRequestDispatcher("addRoute.jsp").forward(request, response);
        }
    }

}
