/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import io.github.cdimascio.dotenv.Dotenv;

/**
 *
 * @author dtam6
 */
public class Environment {

    private static final Environment INSTANCE = new Environment();
    private final Dotenv dotenv;

    private Environment() {
        this.dotenv = Dotenv.load();
    }

    public static Environment getInstance() {
        return INSTANCE;
    }

    public String get(String key) {
        return dotenv.get(key);
    }

    public String get(String key, String defaultValue) {
        return dotenv.get(key, defaultValue);
    }

    public static void main(String[] args) {
        Environment env = Environment.getInstance();

        System.out.println(env.get("DB_URL"));
    }
}
