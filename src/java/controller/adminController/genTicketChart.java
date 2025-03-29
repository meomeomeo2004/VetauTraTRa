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
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import model.SellerRevenue;
import model.SellerTicketSale;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "genTicketChart", urlPatterns = {"/admin_page/genTicketChart"})
public class genTicketChart extends HttpServlet {

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
            out.println("<title>Servlet genTicketChart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet genTicketChart at " + request.getContextPath() + "</h1>");
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

        String duration = request.getParameter("duration");
        DAOforAdmin dao = new DAOforAdmin();
        List<SellerTicketSale> sts_list = dao.getSellerTicketSale(duration);

        LocalDateTime today = LocalDateTime.now();
        LocalDateTime oneDurationAgo = null;

        Date date = new Date();
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        List<String> sellers = new ArrayList<>();

        for (SellerTicketSale sr : sts_list) {
            if (!sellers.contains(sr.getFull_name())) {
                sellers.add(sr.getFull_name());
            }
        }

        List<List<Integer>> sl_sale_list = new ArrayList<>();
        for (int i = 0; i < sellers.size(); i++) {
            if (duration.equalsIgnoreCase("year")) {
                oneDurationAgo = today.minusMonths(11).withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
                List<Integer> durationSales = new ArrayList<>(Collections.nCopies(12, 0));
                sl_sale_list.add(durationSales);
            } else if (duration.equalsIgnoreCase("month")) {
                oneDurationAgo = today.minusDays(29).withHour(0).withMinute(0).withSecond(0).withNano(0);
                List<Integer> durationSales = new ArrayList<>(Collections.nCopies(30, 0));
                sl_sale_list.add(durationSales);
            } else {
                oneDurationAgo = today.minusDays(6).withHour(0).withMinute(0).withSecond(0).withNano(0);
                List<Integer> durationSales = new ArrayList<>(Collections.nCopies(7, 0));
                sl_sale_list.add(durationSales);
            }
        }
        
        
        int cou = 0;
        for (String s : sellers) {
            for (SellerTicketSale sr : sts_list) {
                if (sr.getFull_name().equalsIgnoreCase(s)) {
                    LocalDateTime srldt = sr.getDate().toLocalDate().atStartOfDay();
                    if (srldt.isAfter(oneDurationAgo.minusNanos(1))) {
                        long m = 0;
                        if (duration.equalsIgnoreCase("year")) {
                            m = srldt.getMonthValue() - 1;
                        } else if (duration.equalsIgnoreCase("month")) {
                            srldt.getDayOfMonth();
                            LocalDateTime now = LocalDateTime.now();
                            m = Math.abs(ChronoUnit.DAYS.between(srldt.toLocalDate(), now.toLocalDate()) - 30) - 1;
                        } else {
                            m = srldt.getDayOfWeek().getValue() - 1;
                        }
                        sl_sale_list.get(cou).set((int) m, sl_sale_list.get(cou).get((int) m) + 1);

                    }
                }
            }
            cou++;
        }

        String[] durationLabels = null;
        int durationValues = 0;
        int maxDurationValue = 0;

        if (duration.equalsIgnoreCase("year")) {
            durationLabels = new String[]{"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
            durationValues = localDate.getMonthValue();
            maxDurationValue = 11;
        } else if (duration.equalsIgnoreCase("month")) {
            durationLabels = new String[30];
            for (int i = 0; i < 30; i++) {
                LocalDateTime day = today.minusDays(29 - i);
                int dayOfMonth = day.getDayOfMonth();
                String suffix;
                if (dayOfMonth % 10 == 1 && dayOfMonth != 11) {
                    suffix = "st";
                } else if (dayOfMonth % 10 == 2 && dayOfMonth != 12) {
                    suffix = "nd";
                } else if (dayOfMonth % 10 == 3 && dayOfMonth != 13) {
                    suffix = "rd";
                } else {
                    suffix = "th";
                }
                durationLabels[i] = dayOfMonth + suffix;
            }
        } else if (duration.equalsIgnoreCase("week")) {
            durationLabels = new String[]{"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
            durationValues = localDate.getDayOfWeek().getValue();
            maxDurationValue = 6;
        }

        List<String> lable = new ArrayList<>();
        List<List<Integer>> data = new ArrayList<>();
        for (int j = 0; j < sellers.size(); j++) {
            data.add(new ArrayList<>()); // Initialize each seller's list
        }
        
        if (duration.equalsIgnoreCase("month")) {
            for (int i = 0; i < 30; i++) {
                lable.add(durationLabels[i]);
                for (int j = 0; j < sellers.size(); j++) {
                    data.get(j).add(sl_sale_list.get(j).get(i));
                }
            }
        } else {
            for (int i = 0; i < durationLabels.length; i++) {
                if (durationValues > maxDurationValue) {
                    durationValues = 0;
                }
                for (int j = 0; j < sellers.size(); j++) {
                    data.get(j).add(sl_sale_list.get(j).get(durationValues));
                }
                lable.add(durationLabels[durationValues]);
                durationValues++;
            }
        }

        JSONArray lastduration = new JSONArray();
        JSONArray sellerArray = new JSONArray();

        for (int i = 0; i < durationLabels.length; i++) {
            lastduration.put(lable.get(i));
        }

        for (int i = 0; i < sellers.size(); i++) {
            JSONObject sellerObj = new JSONObject();
            sellerObj.put("name", sellers.get(i));
            sellerObj.put("sales", data.get(i));
            sellerArray.put(sellerObj);
        }

        JSONObject responseData = new JSONObject();
        responseData.put("labels", lastduration);
        responseData.put("data", sellerArray);

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
