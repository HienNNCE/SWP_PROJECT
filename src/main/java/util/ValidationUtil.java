package util;

import DAO.UserDAO;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_PATTERN = "^[0-9]{10,15}$";
    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$";

    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return Pattern.compile(EMAIL_PATTERN).matcher(email).matches();
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && phoneNumber.matches("^(03|05|07|08|09)\\d{8}$");
    }

    public static boolean isValidPassword(String password) {
        return password != null && !password.trim().isEmpty();
    }

    public static boolean isValidUsername(String username) {
        return username != null && !username.trim().isEmpty() && username.length() >= 3;
    }

    public static boolean isValidAddress(String address) {
        return address != null && !address.trim().isEmpty();
    }

    public static String validateUserData(String username, String email, String password, String phone, String address) {
        if (!isValidUsername(username)) {
            return "Username must be at least 3 characters long";
        }
        if (!isValidEmail(email)) {
            return "Invalid email format";
        }
        if (!isValidPassword(password)) {
            return "Password must be at least 8 characters long and contain uppercase, lowercase, number and special character";
        }
        if (!isValidPhoneNumber(phone)) {
            return "Phone number must be 10 digits and start with 03, 05, 07, 08, or 09";
        }
        if (!isValidAddress(address)) {
            return "Address cannot be empty";
        }
        return null;
    }
}
