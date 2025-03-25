package Manager_Control;

import dal.ManagerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.Cabin;
import model.Seller;
import model.Train;
import model.Seat;

@WebServlet("/editTrain")
public class EditTrain extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ManagerDAO dao;
    
    @Override
    public void init() throws ServletException {
        dao = new ManagerDAO();
    }
    
    // Hiển thị form chỉnh sửa với dữ liệu hiện có
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int trainId = Integer.parseInt(request.getParameter("id"));
        Train train = dao.getTrainById(trainId);
        List<Seat> inforseat = dao.getSeatByTrainId(trainId);
        List<Cabin> cabins = dao.getCabinByTrainId(trainId);
        List<Seller> sellers = dao.getAllSeller();
        request.setAttribute("seat", inforseat);
        request.setAttribute("train", train);
        request.setAttribute("cabins", cabins);
        request.setAttribute("listseller", sellers);
        request.getRequestDispatcher("Manager_EditTrain.jsp").forward(request, response);
    }
    
    // Xử lý cập nhật dữ liệu chỉnh sửa
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        int trainId = Integer.parseInt(request.getParameter("trainId")); // hidden field từ form
        String trainModel = request.getParameter("train_model");
        int totalSeats = Integer.parseInt(request.getParameter("total_seats"));
        int numCabin = Integer.parseInt(request.getParameter("numcabin"));
        int owner = Integer.parseInt(request.getParameter("owner"));
        
        // Lấy dữ liệu của các cabin từ form edit
        String[] cabinNames = request.getParameterValues("cabinName");
        String[] cabinClasses = request.getParameterValues("cabinClass");
        String[] cabinPriceStr = request.getParameterValues("cabinPrice");
        String[] cabinNumseatStr = request.getParameterValues("cabinNumseat");
        String[] cabinImgUrls = request.getParameterValues("cabinImgUrl");
        
        // Kiểm tra tổng số ghế của các cabin có khớp với totalSeats không
        int sum = 0;
        for (int i = 0; i < cabinNumseatStr.length; i++) {
            try {
                sum += Integer.parseInt(cabinNumseatStr[i].trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Số ghế của toa " + (i + 1) + " không hợp lệ.");
                reloadEditPage(request, response, trainId);
                return;
            }
        }
        if (sum != totalSeats) {
            request.setAttribute("errorMessage", "Tổng số ghế của các toa (" + sum + ") không bằng với Total Seats (" + totalSeats + ").");
            reloadEditPage(request, response, trainId);
            return;
        }
        
        // Cập nhật thông tin train
        boolean trainUpdated = dao.updateTrain(trainId, trainModel, totalSeats, numCabin, owner);
        
        if (!trainUpdated) {
            request.setAttribute("errorMessage", "Cập nhật thông tin train thất bại.");
            reloadEditPage(request, response, trainId);
            return;
        }
        
        // Vì update cabin theo kiểu xóa toàn bộ rồi thêm lại đã được áp dụng trong AddTrain,
        // ta sẽ xóa các cabin cũ của train và tạo lại từ dữ liệu form.
        // (Do ràng buộc ON DELETE CASCADE, các Seat cũ cũng bị xóa theo)
        boolean cabinsDeleted = dao.deleteCabinsByTrainId(trainId);
        if (!cabinsDeleted) {
            request.setAttribute("errorMessage", "Xóa dữ liệu cabin cũ thất bại.");
            reloadEditPage(request, response, trainId);
            return;
        }
        
        // Thêm lại từng cabin và các Seat tương ứng
        boolean allInserted = true;
        for (int i = 0; i < cabinNames.length; i++) {
            int cabinNumseat = 0;
            double cabinPrice = 0;
            try {
                cabinNumseat = Integer.parseInt(cabinNumseatStr[i].trim());
                cabinPrice = Double.parseDouble(cabinPriceStr[i].trim());
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Dữ liệu nhập của cabin " + (i + 1) + " không hợp lệ.");
                reloadEditPage(request, response, trainId);
                return;
            }
            
            // Thêm cabin và lấy cabinId vừa được tạo
            int cabinId = dao.AddCabin(cabinNames[i], cabinClasses[i], cabinNumseat, cabinImgUrls[i], trainId);
            if (cabinId > 0) {
                // Thêm các seat cho cabin với giá được nhập từ form
                dao.addSeats(cabinId, cabinPrice, cabinNumseat, cabinNames[i]);
            } else {
                allInserted = false;
                break;
            }
        }
        
        if (allInserted) {
            response.sendRedirect("listtrain");
        } else {
            request.setAttribute("errorMessage", "Cập nhật cabin/seat thất bại, vui lòng thử lại.");
            reloadEditPage(request, response, trainId);
        }
    }
    
    // Hàm hỗ trợ nạp lại dữ liệu edit nếu có lỗi
    private void reloadEditPage(HttpServletRequest request, HttpServletResponse response, int trainId)
            throws ServletException, IOException {
        Train train = dao.getTrainById(trainId);
        List<Cabin> cabins = dao.getCabinByTrainId(trainId);
        List<Seller> sellers = dao.getAllSeller();
        List<Seat> inforseat = dao.getSeatByTrainId(trainId);
        request.setAttribute("train", train);
        request.setAttribute("cabins", cabins);
        request.setAttribute("listseller", sellers);
        request.setAttribute("seat", inforseat);
        RequestDispatcher dispatcher = request.getRequestDispatcher("Manager_EditTrain.jsp");
        dispatcher.forward(request, response);
    }
}
