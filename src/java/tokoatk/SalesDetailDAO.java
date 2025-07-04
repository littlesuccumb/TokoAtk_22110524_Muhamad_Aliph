package tokoatk;

import java.sql.*;
import java.util.*;
import model.SalesDetail;

public class SalesDetailDAO {
    private static Connection getConnection() throws Exception {
        return DbConnection.getConnection();
    }

    public static List<SalesDetail> getBySalesId(String salesId) {
        List<SalesDetail> list = new ArrayList<>();

        String sql = "SELECT d.*, b.nama AS namaBarang " +
                     "FROM salesd d JOIN barang b ON d.barangId = b.id " +
                     "WHERE d.salesId = ?";

        try (Connection c = getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setString(1, salesId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SalesDetail detail = new SalesDetail();
                detail.setSalesId(rs.getString("salesId"));
                detail.setBarangId(rs.getString("barangId"));
                detail.setQty(rs.getInt("qty"));
                detail.setHarga(rs.getInt("harga"));
                detail.setNamaBarang(rs.getString("namaBarang")); // ambil dari join
                list.add(detail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
