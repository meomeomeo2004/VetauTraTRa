package Manager_Control;

import dal.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Train;


@WebServlet(name="ListTrain", urlPatterns={"/listtrain"})
public class ListTrain extends HttpServlet {
   

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListTrain</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListTrain at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ManagerDAO dao = new ManagerDAO();
        List<Train> list =  dao.getListTrain();
        Map<Integer, String> sellerMap = new HashMap<>();
        HttpSession session = request.getSession();
        for (Train t : list) {
            // Gọi hàm getSellerNameById(int sellerId) để lấy tên seller theo id
            String sellerName = dao.getSellerNameById(t.getOwner());
            sellerMap.put(t.getOwner(), sellerName);
        }
        String message = (String) session.getAttribute("message");
        session.removeAttribute("message");
        if(message != null){
            request.setAttribute("message", message);
        }
//        trung gian đây
        request.setAttribute("alltrain", list);
        request.setAttribute("sellerMap", sellerMap);
        request.getRequestDispatcher("Manager_manageTrain.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
}