// File: src/tokoatk/DbConnection.java
package tokoatk;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {
    public static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/tokoatk";
        String user = "root";
        String pass = ""; // sesuaikan password MySQL kamu
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }
}
