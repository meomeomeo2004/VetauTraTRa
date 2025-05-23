/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Luggage;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Ticket;
import model.TicketDetail;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author dtam6
 */
public class LuggageDAO extends DBContext {

    public List<Luggage> getAllLuggage() {
        List<Luggage> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Luggage";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                list.add(new Luggage(rs.getInt("id"),
                        rs.getInt(2),
                        rs.getBigDecimal(3)));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return list;
    }
    
    public Luggage getLuggageById(int id) {
        Luggage luggage = null;
        String sql = """
                    select * from luggage where id = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                luggage = Luggage.builder()
                    .id(id)
                    .weight(rs.getInt("weight"))
                    .price(rs.getBigDecimal("price"))
                    .build();
            }

        } catch (SQLException ex) {
            Logger.getLogger(LuggageDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return luggage;
    }

}
