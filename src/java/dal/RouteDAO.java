package dal;

import model.Route;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class RouteDAO extends DBContext {

    public List<Route> getAllRoute() {
        List<Route> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Route";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Route(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7),
                        rs.getTimestamp(8),
                        rs.getInt(9)));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public List<Route> searchRoute(String departureStation, String arrivalStation, String departureDate, String arrivalDate) {
        List<Route> list = new ArrayList<>();
        try {
            // Xây dựng câu SQL động
            StringBuilder sql = new StringBuilder("SELECT * FROM Route WHERE 1=1"); // 1=1 để dễ dàng thêm các điều kiện sau

            // Dùng PreparedStatement để tránh SQL Injection
            if (departureStation != null && !departureStation.trim().isEmpty()) {
                sql.append(" AND departure_station LIKE ?");
            }
            if (arrivalStation != null && !arrivalStation.trim().isEmpty()) {
                sql.append(" AND arrival_station LIKE ?");
            }
            if (departureDate != null && !departureDate.trim().isEmpty()) {
                sql.append(" AND departure_time LIKE ?");
            }
            if (arrivalDate != null && !arrivalDate.trim().isEmpty()) {
                sql.append(" AND arrival_time LIKE ?");
            }

            // Sử dụng PreparedStatement với câu SQL động
            PreparedStatement stm = connection.prepareStatement(sql.toString());

            // Gán các giá trị cho PreparedStatement
            int parameterIndex = 1;
            if (departureStation != null && !departureStation.trim().isEmpty()) {
                stm.setString(parameterIndex++, "%" + departureStation + "%");
            }
            if (arrivalStation != null && !arrivalStation.trim().isEmpty()) {
                stm.setString(parameterIndex++, "%" + arrivalStation + "%");
            }
            if (departureDate != null && !departureDate.trim().isEmpty()) {
                stm.setString(parameterIndex++, "%" + departureDate + "%");
            }
            if (arrivalDate != null && !arrivalDate.trim().isEmpty()) {
                stm.setString(parameterIndex++, "%" + arrivalDate + "%");
            }

            // Thực thi câu truy vấn
            ResultSet rs = stm.executeQuery();

            // Duyệt qua kết quả trả về và tạo đối tượng Route
            while (rs.next()) {
                list.add(new Route(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7),
                        rs.getTimestamp(8),
                        rs.getInt(9)));
            }

            // Đảm bảo đóng ResultSet và PreparedStatement
            rs.close();
            stm.close();

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }

    public Route getRouteById(int id) {
        String sql = " SELECT * FROM Route WHERE id = ?; ";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Route route = new Route(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7),
                        rs.getTimestamp(8),
                        rs.getInt(9));
                return route;
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return null;
    }

}
