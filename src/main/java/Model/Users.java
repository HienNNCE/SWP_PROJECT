package Model;

import java.time.LocalDate;

public class Users {

    private int userId;
    private String fullName;
    private String userName;
    private String email;
    private String password;
    private String phone;
    private boolean gender;
    private LocalDate dob;
    private String aboutMe;
    private String address;
    private Integer roleId;
    private String userStatus;

    // Default constructor
    public Users() {
    }
    
    public Users(int userId){
        this.userId = userId;
    }

    public Users(int userId, String fullName, String userName, String email, String password, String phone, boolean gender, LocalDate dob, String aboutMe, String address, Integer roleId, String userStatus) {
        this.userId = userId;
        this.fullName = fullName;
        this.userName = userName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.dob = dob;
        this.aboutMe = aboutMe;
        this.address = address;
        this.roleId = roleId;
        this.userStatus = userStatus;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    @Override
    public String toString() {
        return "Users{" + "userId=" + userId + ", fullName=" + fullName + ", userName=" + userName + ", email=" + email + ", password=" + password + ", phone=" + phone + ", gender=" + gender + ", dob=" + dob + ", aboutMe=" + aboutMe + ", address=" + address + ", roleId=" + roleId + ", userStatus=" + userStatus + '}';
    }

    
    
    
}
