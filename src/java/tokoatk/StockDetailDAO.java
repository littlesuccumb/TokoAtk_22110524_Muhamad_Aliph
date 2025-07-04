package tokoatk;

import java.sql.*;
import java.util.*;
import model.StockDetail;

public class StockDetailDAO {
    private static Connection getConnection() throws Exception {
        return DbConnection.getConnection();
    }

    public static List<StockDetail> getByStockId(String stockId) {
        List<StockDetail> list = new ArrayList<>();
        String sql = "SELECT d.*, b.nama AS namaBarang " +
                     "FROM stockd d JOIN barang b ON d.barangId = b.id " +
                     "WHERE d.stockId = ?";

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, stockId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                StockDetail detail = new StockDetail();
                detail.setStockId(rs.getString("stockId"));
                detail.setBarangId(rs.getString("barangId"));
                detail.setQty(rs.getInt("qty"));
                detail.setHarga(rs.getInt("harga"));
                detail.setNamaBarang(rs.getString("namaBarang"));
                list.add(detail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
