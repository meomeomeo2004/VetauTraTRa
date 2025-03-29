package controller;

import dal.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.User;
import model.Voucher;

@WebServlet(name = "ConfirmBookingServlet", urlPatterns = {"/ConfirmBookingServlet"})
public class ConfirmBookingServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ConfirmBookingServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmBookingServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false); // Lấy session hiện tại, không tạo mới
        User user = (session != null) ? (User) session.getAttribute("account") : null;
        int userId = user.getId();
        String[] seatNames = request.getParameterValues("seatName");
        String[] seatPrices = request.getParameterValues("seatPrice");
        String[] luggageOptions = request.getParameterValues("luggageOption");
        String amount = request.getParameter("totalAmount");
        String numSeats = request.getParameter("numSeats");
        String voucherCode = request.getParameter("voucherCode");
        VoucherDAO vdao = new VoucherDAO();
        Voucher voucher = vdao.getVoucherByCode(voucherCode);
        List<Map<String, Object>> transactions = new ArrayList<>();
        if (seatNames != null) {
            for (int i = 0; i < seatNames.length; i++) {
                String seatName = seatNames[i];
                String seatPrice = seatPrices[i];
                String luggageOption = luggageOptions[i];
                Map<String, Object> transaction = new HashMap<>();
                transaction.put("seatName", seatName);
                transaction.put("seatPrice", seatPrice);
                transaction.put("luggageId", luggageOption);

                // Thêm vào danh sách
                transactions.add(transaction);
            }
        }
        BigDecimal amountBD = new BigDecimal(amount);
        amountBD = amountBD.subtract(voucher.getDiscountAmount());
        BigDecimal roundedAmount = amountBD.setScale(0, RoundingMode.DOWN);
        String amountStr = roundedAmount.toString();
        request.getSession().setAttribute("transactions", transactions);
        request.setAttribute("amount", amountStr);
        request.setAttribute("numSeats", numSeats);
        request.setAttribute("userId", userId);
        session.setAttribute("voucherCode", voucherCode);
        request.getRequestDispatcher("/ConfirmBooking.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
