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
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.sql.Date;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Route;
import model.SellerRevenue;
import model.User;
import model.sellerCustomer;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "SellerDashboard", urlPatterns = {"/SellerDashboard"})
public class SellerDashboard extends HttpServlet {

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
            out.println("<title>Servlet SellerDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SellerDashboard at " + request.getContextPath() + "</h1>");
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
        List<Date> sts = dao.getSellerTicketSale("2month", acc.getId());

        LocalDateTime today = LocalDateTime.now();
        LocalDateTime oneMonthAgo = today.minusMonths(1);
        LocalDateTime twoMonthAgo = today.minusMonths(2);
        List<Date> recentTicketSale = new ArrayList<>();
        List<Date> olderTicketSale = new ArrayList<>();

        for (Date d : sts) {
            LocalDateTime setildt = d.toLocalDate().atStartOfDay();

            if (setildt.isAfter(oneMonthAgo)) {
                recentTicketSale.add(d); // Within 1 month
            } else if (setildt.isAfter(twoMonthAgo)) {
                olderTicketSale.add(d); // Between 1-2 month
            }
        }
        double rate;
        if (olderTicketSale.isEmpty()) {
            rate = 100;
        } else {
            rate = ((double) recentTicketSale.size() / olderTicketSale.size() - 1) * 100;
        }
        NumberFormat formatter = new DecimalFormat("#0.0");
        request.setAttribute("ticket", recentTicketSale.size());
        request.setAttribute("ticketPercent", formatter.format(Math.abs(rate)));
        request.setAttribute("ticketSign", (rate > 0) ? 1 : 0);

        List<sellerCustomer> sc = dao.getSellerCustomer("2month", acc.getId());
        List<sellerCustomer> recentCustomer = new ArrayList<>();
        List<sellerCustomer> olderCustomer = new ArrayList<>();
        for (sellerCustomer d : sc) {
            LocalDateTime setildt = d.getDate().toLocalDate().atStartOfDay();

            if (setildt.isAfter(oneMonthAgo)) {
                recentCustomer.add(d); // Within 1 month
            } else if (setildt.isAfter(twoMonthAgo)) {
                olderCustomer.add(d); // Between 1-2 month
            }
        }

        List<sellerCustomer> recentCustomerNoDup = new ArrayList<>();
        List<sellerCustomer> olderCustomerNoDup = new ArrayList<>();
        for (sellerCustomer d : recentCustomer) {
            boolean isDup = false;
            for (sellerCustomer f : recentCustomerNoDup) {
                if (d.getCustomerId() == f.getCustomerId()) {
                    isDup = true;
                    break;
                }
            }
            if (!isDup) {
                recentCustomerNoDup.add(d);
            }
        }
        for (sellerCustomer d : olderCustomer) {
            boolean isDup = false;
            for (sellerCustomer f : olderCustomerNoDup) {
                if (d.getCustomerId() == f.getCustomerId()) {
                    isDup = true;
                    break;
                }
            }
            if (!isDup) {
                olderCustomerNoDup.add(d);
            }
        }
        if (olderCustomerNoDup.isEmpty()) {
            rate = 100;
        } else {
            rate = ((double) recentCustomerNoDup.size() / olderCustomerNoDup.size() - 1) * 100;
        }
        request.setAttribute("customerThisMonth", recentCustomerNoDup.size());
        request.setAttribute("customerThisMonthPercent", formatter.format(Math.abs(rate)));
        request.setAttribute("customerThisMonthSign", (rate > 0) ? 1 : 0);

        List<Route> route_list = dao.getListActiveRoute(String.valueOf(acc.getId()));
        List<Route> recentRoute = new ArrayList<>();
        List<Route> olderRoute = new ArrayList<>();
        for (Route r : route_list) {
            String departureDateStr = r.getDepartureDate() + " 00:00:00";
            DateTimeFormatter dateformatter = DateTimeFormatter.ofPattern("MM/dd/yyyy HH:mm:ss");
            LocalDateTime route_ldt = LocalDateTime.parse(departureDateStr, dateformatter);
            if (route_ldt.isAfter(oneMonthAgo)) {
                recentRoute.add(r); // Within 1 month
            } else if (route_ldt.isAfter(twoMonthAgo)) {
                olderRoute.add(r); // Between 1-2 month
            }
        }
        if (olderRoute.isEmpty()) {
            rate = 100;
        } else {
            rate = ((double) recentRoute.size() / olderRoute.size() - 1) * 100;
        }
        request.setAttribute("routeThisMonth", recentRoute.size());
        request.setAttribute("routeThisMonthPercent", formatter.format(Math.abs(rate)));
        request.setAttribute("routeThisMonthSign", (rate > 0) ? 1 : 0);

        List<SellerRevenue> sr_list = dao.getSellerRevenue("2month", acc.getId());
        double recentRe = 0;
        double olderRe = 0;
        for (SellerRevenue d : sr_list) {
            LocalDateTime setildt = d.getDate().toLocalDate().atStartOfDay();
            if (setildt.isAfter(oneMonthAgo)) {
                recentRe += d.getAmount_paid();
            } else if (setildt.isAfter(twoMonthAgo)) {
                olderRe += d.getAmount_paid();
            }
        }
        if (olderRe==0) {
            rate = 100;
        } else {
            rate = ((double) recentRe / olderRe - 1) * 100;
        }
        request.setAttribute("reThisMonth", recentRe/1000);
        request.setAttribute("reThisMonthPercent", formatter.format(Math.abs(rate)));
        request.setAttribute("reThisMonthSign", (rate > 0) ? 1 : 0);

        request.getRequestDispatcher("homeSellerPage.jsp").forward(request, response);
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
