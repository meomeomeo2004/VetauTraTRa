/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author dtam6
 */
public class DBContext {

    private Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:mysql://localhost:3306/vetau?zeroDateTimeBehavior=CONVERT_TO_NULL";
            String user = "root";
            String password = "123456";
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    public Connection connection() {
        return connection;
    }

    public static void main(String[] args) {
        System.out.println(new DBContext().connection());
    }
}
