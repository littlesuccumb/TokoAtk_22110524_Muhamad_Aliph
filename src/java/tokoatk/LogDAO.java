package tokoatk;

import java.sql.*;
import java.util.*;

public class LogDAO {
    private static Connection getConnection() throws Exception {
        return DbConnection.getConnection();
    }

    public static void tambahLog(String username, String aksi) {
        String sql = "INSERT INTO log_aktivitas (username, aksi) VALUES (?, ?)";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, aksi);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<String> getLogTerbaru(int limit) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT username, aksi, waktu FROM log_aktivitas ORDER BY waktu DESC LIMIT ?";

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String log = rs.getTimestamp("waktu") + " - " + rs.getString("username") + ": " + rs.getString("aksi");
                list.add(log);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
