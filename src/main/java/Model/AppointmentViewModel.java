package Model;

import java.time.LocalDateTime;

public class AppointmentViewModel {
    private String type; // "Car" hoặc "Service"
    private String name; // Tên xe hoặc tên dịch vụ
    private String note;
    private String status;
    private LocalDateTime date;
    private String formattedDate;

    public AppointmentViewModel(String type, String name, String note, String status, LocalDateTime date, String formattedDate) {
        this.type = type;
        this.name = name;
        this.note = note;
        this.status = status;
        this.date = date;
        this.formattedDate = formattedDate;
    }

    public String getType() {
        return type;
    }

    public String getName() {
        return name;
    }

    public String getNote() {
        return note;
    }

    public String getStatus() {
        return status;
    }

    public LocalDateTime getDate() {
        return date;
    }

    public String getFormattedDate() {
        return formattedDate;
    }
}
