package model;

import java.util.Date;
import java.util.List;

public class Stock {
    private String id;
    private Date waktu;
    private String username;
    private List<StockDetail> details;
    private Date tanggal;

public Date getTanggal() {
    return tanggal;
}

public void setTanggal(Date tanggal) {
    this.tanggal = tanggal;
}


    public Stock() {}

    public Stock(String id, Date waktu, String username) {
        this.id = id;
        this.waktu = waktu;
        this.username = username;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public Date getWaktu() { return waktu; }
    public void setWaktu(Date waktu) { this.waktu = waktu; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public List<StockDetail> getDetails() { return details; }
    public void setDetails(List<StockDetail> details) { this.details = details; }
}
