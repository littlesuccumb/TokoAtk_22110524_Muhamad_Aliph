package model;

public class StockDetail {
    private String stockId;
    private String barangId;
    private int qty;
    private int harga;
    private String namaBarang; // opsional untuk join

    public StockDetail() {}

    public StockDetail(String stockId, String barangId, int qty, int harga) {
        this.stockId = stockId;
        this.barangId = barangId;
        this.qty = qty;
        this.harga = harga;
    }

    public String getStockId() {
        return stockId;
    }

    public void setStockId(String stockId) {
        this.stockId = stockId;
    }

    public String getBarangId() {
        return barangId;
    }

    public void setBarangId(String barangId) {
        this.barangId = barangId;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public int getHarga() {
        return harga;
    }

    public void setHarga(int harga) {
        this.harga = harga;
    }

    public String getNamaBarang() {
        return namaBarang;
    }

    public void setNamaBarang(String namaBarang) {
        this.namaBarang = namaBarang;
    }
}
