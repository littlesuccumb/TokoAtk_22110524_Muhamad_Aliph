package model;

import java.sql.*;
import java.util.*;
import tokoatk.DbConnection;

public class Barang {
    private String id;
    private String nama, jenis;
    private int harga;
    private int stok;

    public Barang() {}

    public Barang(String id, String nama, String jenis, int harga, int stok) {
        this.id = id;
        this.nama = nama;
        this.jenis = jenis;
        this.harga = harga;
        this.stok = stok;
    }

    public Barang(String nama, String jenis, int harga, int stok) {
        this.nama = nama;
        this.jenis = jenis;
        this.harga = harga;
        this.stok = stok;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getNama() { return nama; }
    public void setNama(String nama) { this.nama = nama; }

    public String getJenis() { return jenis; }
    public void setJenis(String jenis) { this.jenis = jenis; }

    public int getHarga() { return harga; }
    public void setHarga(int harga) { this.harga = harga; }

    public int getStok() { return stok; }
    public void setStok(int stok) { this.stok = stok; }

    // ============ Tambahan untuk API =============

    public boolean insert() {
        try (Connection c = DbConnection.getConnection()) {
            String sql = "INSERT INTO barang (id, nama, jenis, harga, stok) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, this.id);
            ps.setString(2, this.nama);
            ps.setString(3, this.jenis);
            ps.setInt(4, this.harga);
            ps.setInt(5, this.stok);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete() {
        try (Connection c = DbConnection.getConnection()) {
            String sql = "DELETE FROM barang WHERE id = ?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, this.id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update() {
        try (Connection c = DbConnection.getConnection()) {
            String sql = "UPDATE barang SET nama = ? WHERE id = ?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, this.nama);
            ps.setString(2, this.id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void baca(String id) {
        try (Connection c = DbConnection.getConnection()) {
            String sql = "SELECT * FROM barang WHERE id = ?";
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.id = rs.getString("id");
                this.nama = rs.getString("nama");
                this.jenis = rs.getString("jenis");
                this.harga = rs.getInt("harga");
                this.stok = rs.getInt("stok");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

public void generateId() {
    String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    StringBuilder id = new StringBuilder("BRG");
    Random rand = new Random();
    for (int i = 0; i < 5; i++) {
        id.append(chars.charAt(rand.nextInt(chars.length())));
    }
    this.id = id.toString();
}


    public static List<Barang> getList() {
        List<Barang> list = new ArrayList<>();
        try (Connection c = DbConnection.getConnection();
             PreparedStatement ps = c.prepareStatement("SELECT * FROM barang");
             ResultSet rs = ps.executeQuery()) {
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
}
