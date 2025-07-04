package model;

import java.util.List;
import java.util.Date;

public class Sales {
    private String id;
    private Date waktu;
    private String username;
    private List<SalesDetail> details;

    public Sales() {}

    public Sales(String id, Date waktu, String username) {
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

    public List<SalesDetail> getDetails() { return details; }
    public void setDetails(List<SalesDetail> details) { this.details = details; }
}
