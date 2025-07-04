package tokoatk;

import java.sql.*;
import java.util.*;
import model.Barang;

public class BarangDAO {
    private static Connection getConnection() throws Exception {
        String url = "jdbc:mysql://localhost:3306/tokoatk";
        String user = "root";
        String pass = "";
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    public static List<Barang> getAll() {
        List<Barang> list = new ArrayList<>();
        try (Connection c = getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("SELECT * FROM barang")) {
            while (rs.next()) {
                Barang b = new Barang(
                    rs.getString("id"),
                    rs.getString("nama"),
                    rs.getString("jenis"),
                    rs.getInt("harga"),
                    rs.getInt("stok")
                );
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void insert(Barang b) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement("INSERT INTO barang (id, nama, jenis, harga, stok) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, b.getId());
            ps.setString(2, b.getNama());
            ps.setString(3, b.getJenis());
            ps.setInt(4, b.getHarga());
            ps.setInt(5, b.getStok());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void update(Barang b) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE barang SET nama=?, jenis=?, harga=?, stok=? WHERE id=?")) {
            ps.setString(1, b.getNama());
            ps.setString(2, b.getJenis());
            ps.setInt(3, b.getHarga());
            ps.setInt(4, b.getStok());
            ps.setString(5, b.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void delete(String id) {
        try (Connection c = getConnection()) {
            c.setAutoCommit(false);

            // 1. Hapus semua detail stok yang pakai barang ini
            String deleteStockDetail = "DELETE FROM stockd WHERE barangId = ?";
            try (PreparedStatement ps = c.prepareStatement(deleteStockDetail)) {
                ps.setString(1, id);
                ps.executeUpdate();
            }

            // 2. Hapus semua stockm yang tidak punya detail lagi
            String deleteStockMasterKosong = "DELETE FROM stockm WHERE id NOT IN (SELECT DISTINCT stockId FROM stockd)";
            try (PreparedStatement ps = c.prepareStatement(deleteStockMasterKosong)) {
                ps.executeUpdate();
            }

            // 3. Hapus semua detail penjualan yang pakai barang ini
            String deleteSalesDetail = "DELETE FROM salesd WHERE barangId = ?";
            try (PreparedStatement ps = c.prepareStatement(deleteSalesDetail)) {
                ps.setString(1, id);
                ps.executeUpdate();
            }

            // 4. Hapus salesm yang tidak punya detail lagi
            String deleteSalesMasterKosong = "DELETE FROM salesm WHERE id NOT IN (SELECT DISTINCT salesId FROM salesd)";
            try (PreparedStatement ps = c.prepareStatement(deleteSalesMasterKosong)) {
                ps.executeUpdate();
            }

            // 5. Hapus barang dari tabel barang
            String deleteBarang = "DELETE FROM barang WHERE id = ?";
            try (PreparedStatement ps = c.prepareStatement(deleteBarang)) {
                ps.setString(1, id);
                ps.executeUpdate();
            }

            c.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Barang getById(String id) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM barang WHERE id=?")) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Barang(
                    rs.getString("id"),
                    rs.getString("nama"),
                    rs.getString("jenis"),
                    rs.getInt("harga"),
                    rs.getInt("stok")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int count() {
        int total = 0;
        try (Connection c = getConnection();
             Statement s = c.createStatement();
             ResultSet rs = s.executeQuery("SELECT COUNT(*) FROM barang")) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }

    public static void updateStok(String barangId, int perubahan) {
        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement("UPDATE barang SET stok = stok + ? WHERE id = ?")) {
            ps.setInt(1, perubahan); // bisa positif (tambah) atau negatif (kurang)
            ps.setString(2, barangId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
