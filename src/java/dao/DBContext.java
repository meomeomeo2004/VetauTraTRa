/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import utils.Environment;

/**
 *
 * @author dtam6
 */
public class DBContext {

    private Connection connection;
    private Environment environment = Environment.getInstance();

    public DBContext() {
        try {
            String url = environment.get("DB_URL");
            String user = environment.get("DB_USER");
            String password = environment.get("DB_PASS");
            Class.forName(environment.get("DB_CLASS"));
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
}
