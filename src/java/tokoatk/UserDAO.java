package tokoatk;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {

    private static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/tokoatk";
        String user = "root";
        String pass = ""; // sesuaikan jika password MySQL kamu berbeda
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    // Login
    public static boolean login(String username, String password) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "SELECT * FROM users WHERE username=? AND password=MD5(?)")) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Ambil fullname
    public static String getFullnameByUsername(String username) {
        String fullname = "";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT fullname FROM users WHERE username=?")) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                fullname = rs.getString("fullname");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullname;
    }

    // Hitung total user
    public static int count() {
        int total = 0;
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM users")) {
            if (rs.next()) total = rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    // Ambil semua user
    public static List<User> getAll() {
        List<User> list = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT * FROM users")) {
            while (rs.next()) {
                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setFullname(rs.getString("fullname"));
                u.setPassword(rs.getString("password"));
                list.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Insert user
    public static boolean insert(User u) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "INSERT INTO users (username, fullname, password) VALUES (?, ?, MD5(?))")) {
            ps.setString(1, u.getUsername());
            ps.setString(2, u.getFullname());
            ps.setString(3, u.getPassword());
            ps.executeUpdate();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update user (fullname + password)
    public static void update(User u) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE users SET fullname=?, password=MD5(?) WHERE username=?")) {
            ps.setString(1, u.getFullname());
            ps.setString(2, u.getPassword());
            ps.setString(3, u.getUsername());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Update password saja
    public static void updatePassword(String username, String newPassword) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE users SET password=MD5(?) WHERE username=?")) {
            ps.setString(1, newPassword);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Delete user
    public static void delete(String username) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE username=?")) {
            ps.setString(1, username);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Get user by username
    public static User getByUsername(String username) {
        User user = null;
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username=?")) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setFullname(rs.getString("fullname"));
                user.setPassword(rs.getString("password")); // jangan lupa ini penting untuk edit
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    
    public static List<String> getRecentLoginLog(int limit) {
    List<String> list = new ArrayList<>();
    String sql = "SELECT username, NOW() AS waktu_login ORDER BY waktu_login DESC LIMIT ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String log = "User " + rs.getString("username") + " login pada " + rs.getTimestamp("waktu_login");
            list.add(log);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

}
