package Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ServiceAppointment {
    private int serviceAppointmentId;
    private int userId;
    private int serviceId;
    private LocalDateTime saDate;
    private String saNote;
    private String saStatus;
    private String carInfo;
    private String serviceName;

    // Constructors
    public ServiceAppointment() {
    }

    public ServiceAppointment(int serviceAppointmentId, int userId, int serviceId, LocalDateTime saDate, String saNote,
            String saStatus, String carCarInfo) {
        this.serviceAppointmentId = serviceAppointmentId;
        this.userId = userId;
        this.serviceId = serviceId;
        this.saDate = saDate;
        this.saNote = saNote;
        this.saStatus = saStatus;
        this.carInfo = carCarInfo;
    }

    public ServiceAppointment(int userId, int serviceId, LocalDateTime saDate, String saNote, String saStatus,
            String carInfo) {
        this.userId = userId;
        this.serviceId = serviceId;
        this.saDate = saDate;
        this.saNote = saNote;
        this.saStatus = saStatus;
        this.carInfo = carInfo;
    }

    public String getFormattedSaDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return saDate.format(formatter);
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getCarInfo() {
        return carInfo;
    }

    public void setCarInfo(String carInfo) {
        this.carInfo = carInfo;
    }

    // Getters and Setters
    public int getServiceAppointmentId() {
        return serviceAppointmentId;
    }

    public void setServiceAppointmentId(int serviceAppointmentId) {
        this.serviceAppointmentId = serviceAppointmentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public LocalDateTime getSaDate() {
        return saDate;
    }

    public void setSaDate(LocalDateTime saDate) {
        this.saDate = saDate;
    }

    public String getSaNote() {
        return saNote;
    }

    public void setSaNote(String saNote) {
        this.saNote = saNote;
    }

    public String getSaStatus() {
        return saStatus;
    }

    public void setSaStatus(String saStatus) {
        this.saStatus = saStatus;
    }
}
