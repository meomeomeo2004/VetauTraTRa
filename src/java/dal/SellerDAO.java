/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Station;
import model.Train;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import model.Route;
import lombok.CustomLog;

/**
 *
 * @author ASUS
 */
public class SellerDAO extends DBContext {

    public List<Station> getListStation() {
        List<Station> list = new ArrayList<>();
        String sql = "SELECT * FROM vetautratra.station";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Station(rs.getString(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4)));
            }
        } catch (Exception e) {
        }

        return list;
    }

    public List<Train> getListTrainBySellerId(int sellerid) {
        List<Train> list = new ArrayList<>();
        String sql = """
                     select t.* 
                     from train t
                     JOIN Seller s ON t.owner = s.id
                     where s.user_id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, sellerid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Train(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }

        return list;
    }

    public void addRoute(int trainid, String routecode,
            String describe, String departureDateTime, String arrivalDateTime, String departureStation,
            String arrivalStation) {
        String sql = "INSERT INTO Route (train_id, route_code, description, departure_time, arrival_time, departure_station, arrival_station) "
                + "VALUES (?,?,?,?,?,?,?)";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, trainid);
            pre.setString(2, routecode);
            pre.setString(3, describe);
            // Sử dụng định dạng đúng cho input datetime-local: "yyyy-MM-dd'T'HH:mm"
            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

            Timestamp departureTimestamp = new Timestamp(dateTimeFormat.parse(departureDateTime).getTime());
            Timestamp arrivalTimestamp = new Timestamp(dateTimeFormat.parse(arrivalDateTime).getTime());

            pre.setTimestamp(4, departureTimestamp);
            pre.setTimestamp(5, arrivalTimestamp);
            pre.setString(6, departureStation);
            pre.setString(7, arrivalStation);

            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để dễ dàng debug
        }
        
        
    }

    public List<Route> getListRouteBySeller(int user_id) {
        List<Route> list = new ArrayList<>();
        String sql = """
                     SELECT r.*
                     FROM Route r
                     JOIN Train t ON r.train_id = t.id
                     JOIN Seller s ON t.owner = s.id
                     WHERE s.user_id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, user_id);
            ResultSet rs = pre.executeQuery();
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

        } catch (Exception e) {
        }
        return list;
    }

    public List<Route> getListRoute() {
        List<Route> list = new ArrayList<>();
        String sql = "SELECT * FROM Route WHERE status IN (0, 1) ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
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

        } catch (Exception e) {
        }
        return list;
    }

    public List<Route> getListRouteDeleted() {
        List<Route> list = new ArrayList<>();
        String sql = "SELECT * FROM Route WHERE status = 4 ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
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

        } catch (Exception e) {
        }
        return list;
    }

    public void updateRoute(int trainId, String routeCode,
            String describe, String departureDateTime, String arrivalDateTime, String departureStation,
            String arrivalStation, int id) {
        String sql = "UPDATE Route\n"
                + "SET \n"
                + "    train_id = ?,\n"
                + "    route_code = ?,\n"
                + "    `description` = ?,\n"
                + "    departure_time = ?,\n"
                + "    arrival_time = ?,\n"
                + "    departure_station = ?,\n"
                + "    arrival_station = ?\n"
                + "WHERE id = ?;";

        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, trainId);
            pre.setString(2, routeCode);
            pre.setString(3, describe);
            // Chuyển đổi String sang Timestamp (DATETIME)
            SimpleDateFormat dateTimeFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");

            Timestamp departureTimestamp = new Timestamp(dateTimeFormat.parse(departureDateTime).getTime());
            Timestamp arrivalTimestamp = new Timestamp(dateTimeFormat.parse(arrivalDateTime).getTime());
            pre.setTimestamp(4, departureTimestamp);
            pre.setTimestamp(5, arrivalTimestamp);
            pre.setString(6, departureStation);
            pre.setString(7, arrivalStation);
            pre.setInt(8, id);

            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace(); // In lỗi để dễ dàng debug
        }
    }

    public Route getRoutebyCode(int routeid) {
        String sql = "Select * from route where id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, routeid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new Route(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7),
                        rs.getTimestamp(8),
                        rs.getInt(9));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public void updateRouteStatus(int routeid, int newStatus) {
        String sql = "UPDATE Route SET status = ? WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, newStatus);
            pre.setInt(2, routeid);
            pre.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteRouteByCode(int routeid) {
        String sql = "UPDATE Route\n"
                + "SET status = 4\n"
                + "WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, routeid);
            pre.executeUpdate();
        } catch (Exception e) {
        }
    }
    
    public Route getRouteDetails(int routeid){
        String sql = """
                     SELECT * FROM route where id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, routeid);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                return new Route(rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getTimestamp(7),
                        rs.getTimestamp(8),
                        rs.getInt(9));
            }
            
        } catch (Exception e) {
        }
        return null;
    }
    
    
    public List<Train> getWaitingList(int sellerid) {
        List<Train> list = new ArrayList<>();
        String sql = """
                     select t.* 
                     from train t
                     JOIN Seller s ON t.owner = s.id
                     where t.status in (4,5) and s.user_id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, sellerid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Train(rs.getInt(1),
                        rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6)));
            }
        } catch (Exception e) {
        }

        return list;
    }
    
//    SELECT id
//FROM Ticket
//WHERE route_id = <route_id>;

    
    public int checkTicketInRoute(int routeid){
        int ticketid = -1;
        String sql = """
                     SELECT MAX(id) AS max_ticket_id
                     FROM Ticket
                     WHERE route_id = ?
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, routeid);
            ResultSet rs = pre.executeQuery();
            while(rs.next()){
                ticketid = rs.getInt(1);
            }
        } catch (Exception e) {
        }
        return ticketid;
    }
    public static void main(String[] args) {
        SellerDAO dao = new SellerDAO();
        System.out.println(dao.checkTicketInRoute(20));
                    
        }
        

    }


