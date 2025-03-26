package controller;

import com.google.gson.Gson;
import dal.RouteDAO;
import dal.SeatDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Seat;

@WebServlet(name = "SeatServlet", urlPatterns = {"/SeatServlet"})
public class SeatServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        try {
            int routeId = Integer.parseInt(request.getParameter("routeId"));
            int cabinId = Integer.parseInt(request.getParameter("cabinId"));

            SeatDAO seatDAO = new SeatDAO();
            List<Seat> reservedSeats = seatDAO.getReservedSeats(routeId, cabinId);

            // Tạo danh sách chỉ chứa số từ tên ghế
            List<Integer> seatNumbers = reservedSeats.stream()
                    .map(seat -> {
                        // Loại bỏ ký tự không phải số và chuyển đổi sang số nguyên
                        String name = seat.getName();
                        try {
                            return name != null ? Integer.parseInt(name.replaceAll("\\D", "")) : 0;
                        } catch (NumberFormatException e) {
                            return 0; // Xử lý lỗi nếu không chuyển đổi được
                        }
                    })
                    .filter(number -> number > 0) // Loại bỏ số 0 hoặc giá trị không hợp lệ
                    .toList();

            // Chuyển đổi danh sách số ghế thành JSON
            Gson gson = new Gson();
            String json = gson.toJson(seatNumbers);

            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // Báo lỗi 400
            response.getWriter().write("[]");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Báo lỗi 500 nếu có vấn đề khác
            response.getWriter().write("[]");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
