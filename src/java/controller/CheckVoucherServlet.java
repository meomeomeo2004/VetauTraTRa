package controller;

import com.google.gson.Gson;
import dal.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import model.Voucher;

@WebServlet(name = "CheckVoucherServlet", urlPatterns = {"/CheckVoucherServlet"})
public class CheckVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        VoucherDAO voucherDAO = new VoucherDAO();
        Voucher voucher = voucherDAO.getVoucherByCode(code);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        out.print(gson.toJson(voucher));
    }
}
