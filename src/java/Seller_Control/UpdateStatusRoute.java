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
import model.User;

@WebServlet(name = "UpdateStatusRoute", urlPatterns = {"/UpdateStatusRoute"})
public class UpdateStatusRoute extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateStatusRoute</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateStatusRoute at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ManagerDAO Mdao = new ManagerDAO();
        String tid = request.getParameter("id");
        int trainid = Integer.parseInt(tid);
        Train train = Mdao.getTrainById(trainid);
        request.setAttribute("train", train);
        request.getRequestDispatcher("Seller_StatusTrain.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy tham số từ form
            String id = request.getParameter("trainId");
            String status = request.getParameter("status");

            // Kiểm tra nếu trainId hoặc status bị null
            if (id == null || status == null) {
                request.setAttribute("errorMessage", "Train ID or Status is missing.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }

            int train_id = Integer.parseInt(id);
            int newStatus = Integer.parseInt(status);

            // Gọi hàm DAO để cập nhật trạng thái
            ManagerDAO dao = new ManagerDAO();
            dao.updateTrainStatus(train_id, newStatus);

            // Chuyển hướng về trang danh sách tàu
            response.sendRedirect("ViewAllTrain");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid train ID or status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error updating train status.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

}
