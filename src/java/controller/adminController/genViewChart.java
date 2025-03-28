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
import java.util.Date;
import java.util.List;
import model.View;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author Aus TUF GAMAING
 */
@WebServlet(name = "genViewChart", urlPatterns = {"/admin_page/genViewChart"})
public class genViewChart extends HttpServlet {

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
            out.println("<title>Servlet genViewChart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet genViewChart at " + request.getContextPath() + "</h1>");
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
        List<View> v = dao.getView(duration);

        LocalDateTime today = LocalDateTime.now();
        LocalDateTime oneDurationAgo = null;

        Date date = new Date();
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
        List<Integer> viewCount;

        if (duration.equalsIgnoreCase("year")) {
            oneDurationAgo = today.minusMonths(11).withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0).withNano(0);
            viewCount = new ArrayList<>();
            for (int i = 0; i < 12; i++) {
                viewCount.add(0);
            }
        } else if (duration.equalsIgnoreCase("month")) {
            oneDurationAgo = today.minusDays(29).withHour(0).withMinute(0).withSecond(0).withNano(0);
            viewCount = new ArrayList<>();
            for (int i = 0; i < 30; i++) {
                viewCount.add(0);
            }
        } else {
            oneDurationAgo = today.minusDays(6).withHour(0).withMinute(0).withSecond(0).withNano(0);
            viewCount = new ArrayList<>();
            for (int i = 0; i < 7; i++) {
                viewCount.add(0);
            }
        }

        for (View view : v) {
            LocalDateTime viewldt = view.getDate().toLocalDate().atStartOfDay();
            if (viewldt.isAfter(oneDurationAgo.minusNanos(1))) {
                long m = 0;
                if (duration.equalsIgnoreCase("year")) {
                    m = viewldt.getMonthValue() - 1;
                } else if (duration.equalsIgnoreCase("month")) {
                    viewldt.getDayOfMonth();
                    LocalDateTime now = LocalDateTime.now();
                    m = Math.abs(ChronoUnit.DAYS.between(viewldt.toLocalDate(), now.toLocalDate()) - 30) - 1;
                } else {
                    m = viewldt.getDayOfWeek().getValue() - 1;
                }
                viewCount.set((int) m, viewCount.get((int) m) + 1);
            }
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
        List<Integer> data = new ArrayList<>();
        if (duration.equalsIgnoreCase("month")) {
            for (int i = 0; i < 30; i++) {
                lable.add(durationLabels[i]);
                data.add(viewCount.get(i));
            }
        } else {
            for (int i = 0; i < durationLabels.length; i++) {
                if (durationValues > maxDurationValue) {
                    durationValues = 0;
                }
                lable.add(durationLabels[durationValues]);
                data.add(viewCount.get(durationValues));
                durationValues++;
            }
        }

        JSONArray lastDuration = new JSONArray();
        JSONArray visitorCounts = new JSONArray();
        for (int i = 0; i < durationLabels.length; i++) {
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
