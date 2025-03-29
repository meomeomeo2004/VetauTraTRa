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
import java.util.List;
import model.User;
import model.Voucher;

/**
 *
 * @author ASUS
 */
@WebServlet(name="ViewListVoucher", urlPatterns={"/ViewListVoucher"})
public class ViewListVoucher extends HttpServlet {
   


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ViewListVoucher</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewListVoucher at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        VoucherDAO dao = new VoucherDAO();
        HttpSession session = request.getSession();
//        SellerDAO sdao = new SellerDAO();
        User a = (User) session.getAttribute("account");
        int b = a.getId();
        List<Voucher> listv = dao.getVoucherBySellerId(b);
        String message = (String) session.getAttribute("message");
        String editc = (String) session.getAttribute("edit");
        String del = (String) session.getAttribute("deletesuces");
        // Xóa message sau khi lấy để tránh hiển thị lại khi refresh trang
        session.removeAttribute("message");
        session.removeAttribute("edit");
        session.removeAttribute("deletesuces");
        if(message != null){
            request.setAttribute("addsucess", message);
        }
        if(editc != null){
            request.setAttribute("editsucess", editc);
        }
        if(del != null){
            request.setAttribute("delsucess", del);
        }
        request.setAttribute("listvoucher", listv);
        request.getRequestDispatcher("Seller_ManageVoucher.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }


}
