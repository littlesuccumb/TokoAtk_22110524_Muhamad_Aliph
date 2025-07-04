package model;

public class SalesDetail {
    private String salesId;
    private String barangId;
    private int qty;
    private int harga;
    private String namaBarang; // tambahan

    public SalesDetail() {}

    public SalesDetail(String salesId, String barangId, int qty, int harga) {
        this.salesId = salesId;
        this.barangId = barangId;
        this.qty = qty;
        this.harga = harga;
    }

    public String getSalesId() {
        return salesId;
    }

    public void setSalesId(String salesId) {
        this.salesId = salesId;
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
