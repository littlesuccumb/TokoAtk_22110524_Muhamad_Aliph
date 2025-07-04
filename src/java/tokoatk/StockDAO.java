package tokoatk;

import java.sql.*;
import java.util.*;
import model.Stock;
import model.StockDetail;

public class StockDAO {
    private static Connection getConnection() throws Exception {
        return DbConnection.getConnection();
    }

    public static void insert(Stock stock) {
        try (Connection c = getConnection()) {
            c.setAutoCommit(false);

            String sqlMaster = "INSERT INTO stockm (id, waktu, username) VALUES (?, ?, ?)";
            try (PreparedStatement ps = c.prepareStatement(sqlMaster)) {
                ps.setString(1, stock.getId());
                ps.setTimestamp(2, new Timestamp(stock.getWaktu().getTime()));
                ps.setString(3, stock.getUsername());
                ps.executeUpdate();
            }

            String sqlDetail = "INSERT INTO stockd (stockId, barangId, qty, harga) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = c.prepareStatement(sqlDetail)) {
                for (StockDetail d : stock.getDetails()) {
                    ps.setString(1, d.getStockId());
                    ps.setString(2, d.getBarangId());
                    ps.setInt(3, d.getQty());
                    ps.setInt(4, d.getHarga());
                    ps.addBatch();

                    BarangDAO.updateStok(d.getBarangId(), d.getQty());
                }
                ps.executeBatch();
            }

            c.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Stock> getAll() {
        List<Stock> list = new ArrayList<>();
        String sql = "SELECT * FROM stockm ORDER BY waktu DESC";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Stock s = new Stock();
                s.setId(rs.getString("id"));
                s.setWaktu(rs.getTimestamp("waktu"));
                s.setUsername(rs.getString("username"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
public static void delete(String id) {
    try (Connection c = getConnection()) {
        c.setAutoCommit(false);

        // Hapus semua detail
        String sqlDetail = "DELETE FROM stockd WHERE stockId = ?";
        try (PreparedStatement ps = c.prepareStatement(sqlDetail)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }

        // Hapus master
        String sqlMaster = "DELETE FROM stockm WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sqlMaster)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }

        c.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    public static Stock getById(String id) {
    Stock stock = null;
    String sql = "SELECT * FROM stockm WHERE id = ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {

        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            stock = new Stock();
            stock.setId(rs.getString("id"));
            stock.setWaktu(rs.getTimestamp("waktu"));
            stock.setUsername(rs.getString("username"));
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return stock;
}
    
        public static int count() {
        int total = 0;
        try (Connection c = getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("SELECT COUNT(*) FROM stock")) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

        public static List<String> getRecentStockLog(int limit) {
    List<String> list = new ArrayList<>();
    String sql = "SELECT id, username, waktu FROM stockm ORDER BY waktu DESC LIMIT ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String log = "Stok Masuk " + rs.getString("id") + " oleh " + rs.getString("username") + " pada " + rs.getTimestamp("waktu");
            list.add(log);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}

}
