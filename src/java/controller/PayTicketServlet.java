package controller;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dal.LuggageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.Luggage;
import model.User;

public class PayTicketServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
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
        if (user == null || (!"customer".equalsIgnoreCase(user.getRole()))) {
            response.sendRedirect("customer/login");
            return;
        }
        String seatListJson = request.getParameter("seatList");
        Gson gson = new Gson();

        List<Map<String, Object>> seatList = gson.fromJson(seatListJson, new TypeToken<List<Map<String, Object>>>() {
        }.getType());
        String amount = request.getParameter("amount");
        String numSeats = request.getParameter("numSeats");
        String selectedSeats = request.getParameter("selectedSeats");
        String routeId = request.getParameter("routeId");
        String routeCode = request.getParameter("routeCode");
        for (Map<String, Object> seat : seatList) {
            String seatName = (String) seat.get("seatName");
            int price = ((Double) seat.get("price")).intValue();
            Integer staffId = null;
            if ("staff".equalsIgnoreCase(user.getRole())) {
                staffId = user.getId(); // Gán staffId nếu vai trò là "staff"
                seat.put("staffId", staffId); // Thêm staffId vào đối tượng ghế
            }
        }
        LuggageDAO dao = new LuggageDAO();
        List<Luggage> lu = dao.getAllLuggage();
        // Lưu dữ liệu vào request để hiển thị trên `pay.jsp`
        request.setAttribute("amount", amount);
        request.setAttribute("numSeats", numSeats);
        request.setAttribute("selectedSeats", seatList);
        request.getSession().setAttribute("routeId", routeId);
        request.setAttribute("routeCode", routeCode);
        request.setAttribute("lu", lu);

        request.getRequestDispatcher("/pay.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
