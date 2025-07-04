package tokoatk;

import java.sql.*;
import java.util.*;
import model.Sales;
import model.SalesDetail;

public class SalesDAO {
    private static Connection getConnection() throws Exception {
        return DbConnection.getConnection();
    }

    public static void insert(Sales sales) {
        try (Connection c = getConnection()) {
            c.setAutoCommit(false);

            String sqlMaster = "INSERT INTO salesm (id, waktu, username) VALUES (?, ?, ?)";
            try (PreparedStatement ps = c.prepareStatement(sqlMaster)) {
                ps.setString(1, sales.getId());
                ps.setTimestamp(2, new Timestamp(sales.getWaktu().getTime()));
                ps.setString(3, sales.getUsername());
                ps.executeUpdate();
            }

            String sqlDetail = "INSERT INTO salesd (salesId, barangId, qty, harga) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = c.prepareStatement(sqlDetail)) {
                for (SalesDetail d : sales.getDetails()) {
                    ps.setString(1, d.getSalesId());
                    ps.setString(2, d.getBarangId());
                    ps.setInt(3, d.getQty());
                    ps.setInt(4, d.getHarga());
                    ps.addBatch();

                    BarangDAO.updateStok(d.getBarangId(), -d.getQty());
                }
                ps.executeBatch();
            }

            c.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<Sales> getAll() {
        List<Sales> list = new ArrayList<>();
        String sql = "SELECT * FROM salesm ORDER BY waktu DESC";
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Sales s = new Sales();
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
    
    public static Sales getById(String id) {
    Sales s = null;
    String sql = "SELECT * FROM salesm WHERE id = ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            s = new Sales();
            s.setId(rs.getString("id"));
            s.setWaktu(rs.getTimestamp("waktu"));
            s.setUsername(rs.getString("username"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return s;
}

    public static void delete(String id) {
    try (Connection c = getConnection()) {
        c.setAutoCommit(false);

        String sqlDetail = "DELETE FROM salesd WHERE salesId = ?";
        try (PreparedStatement ps = c.prepareStatement(sqlDetail)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }

        String sqlMaster = "DELETE FROM salesm WHERE id = ?";
        try (PreparedStatement ps = c.prepareStatement(sqlMaster)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }

        c.commit();
    } catch (Exception e) {
        e.printStackTrace();
    }
}
    
    // Total transaksi per tanggal
public static Map<String, Integer> getChartDataByDate() {
    Map<String, Integer> result = new LinkedHashMap<>();
    String sql = "SELECT DATE(waktu) AS tgl, COUNT(*) AS total FROM salesm GROUP BY DATE(waktu) ORDER BY tgl ASC";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            result.put(rs.getString("tgl"), rs.getInt("total"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return result;
}

// Total barang terjual per jenis
public static Map<String, Integer> getChartDataByJenis() {
    Map<String, Integer> result = new LinkedHashMap<>();
    String sql = """
        SELECT DISTINCT b.jenis, 
               COALESCE(SUM(d.qty), 0) AS total
        FROM barang b
        LEFT JOIN salesd d ON b.id = d.barangId
        GROUP BY b.jenis
        ORDER BY b.jenis ASC
    """;

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {

        while (rs.next()) {
            result.put(rs.getString("jenis"), rs.getInt("total"));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return result;
}



public static List<String> getRecentSalesLog(int limit) {
    List<String> list = new ArrayList<>();
    String sql = "SELECT id, username, waktu FROM salesm ORDER BY waktu DESC LIMIT ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setInt(1, limit);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            String log = "Transaksi " + rs.getString("id") + " oleh " + rs.getString("username") + " pada " + rs.getTimestamp("waktu");
            list.add(log);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}
public static List<SalesDetail> getDetail(String salesId) {
    List<SalesDetail> list = new ArrayList<>();
    String sql = "SELECT * FROM salesd WHERE salesId = ?";

    try (Connection c = getConnection();
         PreparedStatement ps = c.prepareStatement(sql)) {
        ps.setString(1, salesId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            SalesDetail d = new SalesDetail();
            d.setSalesId(rs.getString("salesId"));
            d.setBarangId(rs.getString("barangId"));
            d.setQty(rs.getInt("qty"));
            d.setHarga(rs.getInt("harga"));
            list.add(d);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return list;
}



}
