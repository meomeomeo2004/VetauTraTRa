/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Seller_Control;

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


@WebServlet(name="VoucherEdit", urlPatterns={"/VoucherEdit"})
public class VoucherEdit extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VoucherEdit</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherEdit at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        VoucherDAO dao = new VoucherDAO();
        String vid = request.getParameter("id");
        int voucherid = Integer.parseInt(vid);
        Voucher voucher = dao.getVoucherById(voucherid);
        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("Seller_EditVoucher.jsp").forward(request, response);
    } 


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
    int voucherId = Integer.parseInt(request.getParameter("id"));
    BigDecimal discount = new BigDecimal(request.getParameter("discountAmount"));
    String validFrom = request.getParameter("validFrom"); // định dạng "yyyy-MM-dd'T'HH:mm"
    String validTo = request.getParameter("validTo");       // định dạng "yyyy-MM-dd'T'HH:mm"
    int quantity = Integer.parseInt(request.getParameter("quantity"));
    int status = Integer.parseInt(request.getParameter("status"));
    VoucherDAO voucherDAO = new VoucherDAO();

    voucherDAO.editVoucher(voucherId, discount, validFrom, validTo, quantity, status);
    response.sendRedirect("ViewListVoucher");//?success=update
}




}
