package Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CarAppointment {
    private int carAppointmentId;
    private Integer userId;
    private Integer carId;
    private LocalDateTime caDate;
    private String caNote;
    private String caStatus;
    private String carName;
    private String carModel;

    // Constructors
    public CarAppointment() {
    }

    public CarAppointment(int carAppointmentId, Integer userId, Integer carId, LocalDateTime caDate, String caNote,
            String caStatus) {
        this.carAppointmentId = carAppointmentId;
        this.userId = userId;
        this.carId = carId;
        this.caDate = caDate;
        this.caNote = caNote;
        this.caStatus = caStatus;
    }

    public CarAppointment(Integer userId, Integer carId, LocalDateTime caDate, String caNote, String caStatus) {
        this.userId = userId;
        this.carId = carId;
        this.caDate = caDate;
        this.caNote = caNote;
        this.caStatus = caStatus;
    }

    public String getCarModel() {
        return carModel;
    }

    public String getFormattedCaDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return caDate.format(formatter);
    }

    public void setCarModel(String carModel) {
        this.carModel = carModel;
    }

    // Getters and Setters
    public int getCarAppointmentId() {
        return carAppointmentId;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public void setCarAppointmentId(int carAppointmentId) {
        this.carAppointmentId = carAppointmentId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCarId() {
        return carId;
    }

    public void setCarId(Integer carId) {
        this.carId = carId;
    }

    public LocalDateTime getCaDate() {
        return caDate;
    }

    public void setCaDate(LocalDateTime caDate) {
        this.caDate = caDate;
    }

    public String getCaNote() {
        return caNote;
    }

    public void setCaNote(String caNote) {
        this.caNote = caNote;
    }

    public String getCaStatus() {
        return caStatus;
    }

    public void setCaStatus(String caStatus) {
        this.caStatus = caStatus;
    }
}
