package seller;

import dal.SellerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import model.Route;
import model.Station;
import model.Train;
import model.User;

@WebServlet(name = "UpdateRouteServlet", urlPatterns = {"/updateroute"})
public class UpdateRouteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateRouteServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateRouteServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("routeid");
        int rouid = Integer.parseInt(id);
        SellerDAO dao = new SellerDAO();
        HttpSession session = request.getSession();
        User f = (User) session.getAttribute("account");
        int b = f.getId();
        Route a = dao.getRoutebyCode(rouid);
        List<Station> liststation = dao.getListStation();
        List<Train> listtrain = dao.getListTrainBySellerId(b);
        request.setAttribute("r", a);
        request.setAttribute("station", liststation);
        request.setAttribute("train", listtrain);
        request.getRequestDispatcher("updateRoute.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SellerDAO dao = new SellerDAO();

        // Lấy tham số từ form
        String trainIdParam = request.getParameter("trainid");
        String routeCode = request.getParameter("routecode");
        String description = request.getParameter("description");
        String departureDateTime = request.getParameter("departureDateTime");  // dạng "yyyy-MM-ddTHH:mm"
        String arrivalDateTime = request.getParameter("returnDateTime");     // dạng "yyyy-MM-ddTHH:mm"
        String departureStation = request.getParameter("departureStation");
        String arrivalStation = request.getParameter("arrivalStation");
        String routeIdParam = request.getParameter("routeid");

        // Ép kiểu sang int
        int trainId = Integer.parseInt(trainIdParam);
        int routeId = Integer.parseInt(routeIdParam);

        try {
            // Định dạng datetime-local (yyyy-MM-ddTHH:mm) 
            // từ <input type="datetime-local">
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

            // Chuyển các chuỗi sang LocalDateTime
            LocalDateTime departureTime = LocalDateTime.parse(departureDateTime, formatter);
            LocalDateTime arrivalTime = LocalDateTime.parse(arrivalDateTime, formatter);

            // Lấy thời gian hiện tại
            LocalDateTime now = LocalDateTime.now();
            // Tính mốc now + 2 giờ
            LocalDateTime nowPlus2h = now.plusHours(2);

            // (1) Kiểm tra Departure >= (hiện tại + 2 tiếng)
            if (departureTime.isBefore(nowPlus2h)) {
                // Nếu không đạt, ta báo lỗi & quay lại trang update (hoặc tuỳ ý hiển thị thông báo)
                request.setAttribute("errorMessage",
                        "Departure time must be at least 2 hours from now!");
                // forward về trang JSP cũ, 
                // kèm theo dữ liệu form để người dùng sửa (nếu muốn).
                request.getRequestDispatcher("updateRoute.jsp").forward(request, response);
                return;
            }

            // (2) Kiểm tra Arrival >= (Departure + 30 phút)
            LocalDateTime departurePlus30m = departureTime.plusMinutes(30);
            if (arrivalTime.isBefore(departurePlus30m)) {
                request.setAttribute("errorMessage",
                        "Arrival time must be at least 30 minutes after Departure!");
                request.getRequestDispatcher("updateRoute.jsp").forward(request, response);
                return;
            }

            // Nếu qua hết các bước kiểm tra -> lưu xuống DB
            dao.updateRoute(trainId, routeCode, description,
                    departureDateTime, arrivalDateTime,
                    departureStation, arrivalStation,
                    routeId);

            // Chuyển hướng về trang danh sách (thành công)
            response.sendRedirect("viewlistroute");

        } catch (Exception e) {
            // Bắt lỗi parse date time hoặc bất kỳ lỗi nào
            e.printStackTrace();
            // Bạn có thể chuyển hướng sang 1 trang báo lỗi tuỳ ý
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi cập nhật route: " + e.getMessage());
            request.getRequestDispatcher("updateRoute.jsp").forward(request, response);
        }
    }
}

