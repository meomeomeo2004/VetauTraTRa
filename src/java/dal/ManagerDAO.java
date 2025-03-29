/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Train;
import lombok.CustomLog;
import model.Cabin;
import model.Seller;
import java.sql.Statement;
import model.Seat;

/**
 *
 * @author ASUS
 */
public class ManagerDAO extends DBContext {

    public List<Train> getListTrain() {
        List<Train> list = new ArrayList<>();
        String sql = "SELECT * FROM Train";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                // Ánh xạ dữ liệu của Train
                Train train = new Train(
                        rs.getInt("id"),
                        rs.getString("train_model"),
                        rs.getInt("total_seats"),
                        rs.getInt("numcabin"),
                        rs.getInt("status"),
                        rs.getInt("owner")
                );
                // Gọi truy vấn phụ để lấy tên seller dựa vào id owner
                String sellerName = getSellerNameById(train.getOwner());
                // Ví dụ: In ra thông tin, hoặc lưu kết quả kết hợp Train và sellerName
                System.out.println("Train: " + train.getTrainid() + " | Seller: " + sellerName);
                list.add(train);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getSellerNameById(int sellerId) {
        String sellerName = "";
        String sql = "SELECT full_name FROM Seller WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, sellerId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                sellerName = rs.getString("full_name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return sellerName;
    }

    public Train getTrainById(int trainid) {
        String sql = """
                    SELECT t.*, c.*
                    FROM Train t
                    JOIN Cabin c ON t.id = c.train_id
                    WHERE t.id = ?
                    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, trainid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return new Train(rs.getInt(1), rs.getString(2),
                        rs.getInt(3),
                        rs.getInt(4),
                        rs.getInt(5),
                        rs.getInt(6));
            }
        } catch (Exception e) {
        }
        return null;
    }

    public List<Cabin> getCabinByTrainId(int trainid) {
        List<Cabin> list = new ArrayList<>();
        String sql = """
                    SELECT t.*, c.*
                    FROM Train t
                    JOIN Cabin c ON t.id = c.train_id
                    WHERE t.id = ?
                    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, trainid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Cabin(rs.getInt(7), rs.getString(8),
                        rs.getString(9),
                        rs.getInt(10),
                        rs.getString(11),
                        rs.getInt(12)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public List<Seat> getSeatByTrainId(int trainid) {
        List<Seat> list = new ArrayList<>();
        String sql = """
                    SELECT DISTINCT s.price, s.cabin_id
                    FROM Seat s
                    JOIN Cabin c ON s.cabin_id = c.id
                    JOIN Train t ON c.train_id = t.id
                    WHERE t.id = ?
                    """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, trainid);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Seat().builder()
                        .price(rs.getLong(1))
                        .cabinid(rs.getInt(2))
                        .build());

            }
        } catch (Exception e) {
        }
        return list;
    }

    public int AddTrain(String model, int totalseat, int numcabin, int owner,int user_id) {
        String sql = """
                 INSERT INTO Train (train_model, total_seats,numcabin,status, owner)
                 VALUES (?,?,?,4,?)
                 """;
        try {

            PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            pre.setString(1, model);
            pre.setInt(2, totalseat);
            pre.setInt(3, numcabin);
            pre.setInt(4, owner);
            int affectedRows = pre.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            ResultSet rs = pre.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        DAOforAdmin dao = new DAOforAdmin();
        dao.recordChange("Add Train", user_id, "Manager");
        
        return -1; // 
    }

    public int AddCabin(String cabinname, String cabinclass, int numseat, String imgURL, int trainid) {
        String sql = "INSERT INTO Cabin (name, class, numseat, img_url, train_id) VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pre.setString(1, cabinname);
            pre.setString(2, cabinclass);
            pre.setInt(3, numseat);
            pre.setString(4, imgURL);
            pre.setInt(5, trainid);

            int affectedRows = pre.executeUpdate();
            if (affectedRows == 0) {
                return -1;
            }
            ResultSet rs = pre.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public void addSeats(int cabinId, double price, int numSeats, String cabinname) {
        String sql = "INSERT INTO Seat (name, price, cabin_id) VALUES (?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            for (int i = 1; i <= numSeats; i++) {
                String seatName = i + cabinname;  // Ví dụ: "1A", "2A", ...
                pre.setString(1, seatName);
                pre.setDouble(2, price);
                pre.setInt(3, cabinId);
                pre.addBatch();
            }
            pre.executeBatch(); // Thực hiện toàn bộ batch một lần
        } catch (Exception e) {
            e.printStackTrace();
        }        
    }

    // Cập nhật thông tin Train
    public boolean updateTrain(int trainId, String model, int totalSeats, int numCabin, int owner,int user_id) {
        String sql = "UPDATE Train SET train_model = ?, total_seats = ?, numcabin = ?, owner = ?, status = 5 WHERE id = ? ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, model);
            ps.setInt(2, totalSeats);
            ps.setInt(3, numCabin);
            ps.setInt(4, owner);
            ps.setInt(5, trainId);
            int affected = ps.executeUpdate();
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        DAOforAdmin dao = new DAOforAdmin();
        dao.recordChange("Edit Train", user_id, "Manager");
        return false;
    }

    // Cập nhật lại các Cabin: thực hiện xóa hết các cabin cũ của train và chèn lại từ dữ liệu mới
    public boolean updateCabins(int trainId, List<Cabin> cabins) {
        String sqlDelete = "DELETE FROM Cabin WHERE train_id = ?";
        try {
            PreparedStatement psDel = connection.prepareStatement(sqlDelete);
            psDel.setInt(1, trainId);
            psDel.executeUpdate();

            String sqlInsert = "INSERT INTO Cabin (name, class, numseat, img_url, train_id) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psIns = connection.prepareStatement(sqlInsert);
            for (Cabin cabin : cabins) {
                psIns.setString(1, cabin.getCabinName());
                psIns.setString(2, cabin.getType());
                psIns.setInt(3, cabin.getNumSeat());
                psIns.setString(4, cabin.getImgUrl());
                psIns.setInt(5, trainId);
                psIns.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateTrainStatus(int trainId, int newStatus) {
        String sql = "UPDATE Train SET status = ? WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, newStatus);
            pre.setInt(2, trainId);
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Train> getFilteredTrains(String trainModelFilter, String ownerFilter) {
        List<Train> list = new ArrayList<>();
        // Lấy các tàu active (status = 1)
        String sql = "SELECT t.id, t.train_model, t.total_seats, t.numcabin, t.status, t.owner "
                + "FROM Train t JOIN Seller s ON t.owner = s.id "
                + "WHERE t.status = 1";

        boolean hasTrainModel = trainModelFilter != null && !trainModelFilter.trim().isEmpty();
        boolean hasOwner = ownerFilter != null && !ownerFilter.trim().isEmpty();

        if (hasTrainModel) {
            sql += " AND t.train_model LIKE ?";
        }
        if (hasOwner) {
            sql += " AND t.owner = ?";
        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int paramIndex = 1;
            if (hasTrainModel) {
                ps.setString(paramIndex++, "%" + trainModelFilter + "%");
            }
            if (hasOwner) {
                // Chuyển ownerFilter thành int vì option value là seller id
                int ownerId = Integer.parseInt(ownerFilter);
                ps.setInt(paramIndex++, ownerId);
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Train t = new Train(
                        rs.getInt("id"),
                        rs.getString("train_model"),
                        rs.getInt("total_seats"),
                        rs.getInt("numcabin"),
                        rs.getInt("status"),
                        rs.getInt("owner")
                );
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean deleteCabinsByTrainId(int trainId) {
        String sql = "DELETE FROM Cabin WHERE train_id = ?";
        try {
            PreparedStatement psDel = connection.prepareStatement(sql);
            psDel.setInt(1, trainId);
            psDel.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Seller> getAllSeller() {
        List<Seller> list = new ArrayList<>();
        String sql = """
                     SELECT * FROM seller 
                     """;
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Seller(rs.getInt(1), rs.getInt(2),
                        rs.getString(3), rs.getString(4),
                        rs.getString(5), rs.getInt(6)));
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static void main(String[] args) {
        ManagerDAO dao = new ManagerDAO();
        List<Seat> list = dao.getSeatByTrainId(5);
        for (Seat a : list) {
            System.out.println(a.getPrice());
        }
    }

}
