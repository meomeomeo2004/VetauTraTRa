/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Seller_Control;

import dal.SellerDAO;
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
import model.User;

/**
 *
 * @author ASUS
 */
@WebServlet(name="VoucherAdd", urlPatterns={"/VoucherAdd"})
public class VoucherAdd extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VoucherAdd</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherAdd at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("Seller_AddVoucher.jsp");
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập charset cho request
        request.setCharacterEncoding("UTF-8");
        
        // Lấy các tham số từ form
        String code = request.getParameter("code");
        String discountStr = request.getParameter("discountAmount");
        String validFrom = request.getParameter("validFrom"); // định dạng "yyyy-MM-ddTHH:mm"
        String validTo = request.getParameter("validTo");       // định dạng "yyyy-MM-ddTHH:mm"
        String quantityStr = request.getParameter("quantity");
        
        // Chuyển đổi các giá trị cần thiết
        BigDecimal discount = new BigDecimal(discountStr);
        int quantity = Integer.parseInt(quantityStr);
        
        // Lấy thông tin sellerid và user_id từ session (giả sử đã được lưu từ lúc đăng nhập)
        HttpSession session = request.getSession();
        User c = (User) session.getAttribute("account");
        int user_id = c.getId();
        VoucherDAO dao = new VoucherDAO();
        dao.sellerAddVoucher(code, discount, validFrom, validTo, quantity, user_id);
        
        // (Tùy chọn) Lưu thông báo thành công vào session
        session.setAttribute("message", "Voucher created successfully!");       
        // Chuyển hướng về trang quản lý voucher
        response.sendRedirect("ViewListVoucher");
    }


}
