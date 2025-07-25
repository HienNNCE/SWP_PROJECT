package util;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final String PHONE_PATTERN = "^(03|05|07|08|09)\\d{8}$";
    private static final String PASSWORD_PATTERN = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=!])(?=\\S+$).{8,}$";

    public static boolean isValidEmail(String email) {
        return email != null && Pattern.compile(EMAIL_PATTERN).matcher(email).matches();
    }

    public static boolean isValidPhoneNumber(String phoneNumber) {
        return phoneNumber != null && phoneNumber.matches(PHONE_PATTERN);
    }

    public static boolean isValidPassword(String password) {
        return password != null && Pattern.compile(PASSWORD_PATTERN).matcher(password).matches();
    }

    public static boolean isValidUsername(String username) {
        return username != null && !username.trim().isEmpty() && username.length() >= 3;
    }

    public static boolean isValidAddress(String address) {
        return address != null && !address.trim().isEmpty();
    }

    public static boolean isValidFullName(String fullName) {
        return fullName != null && !fullName.trim().isEmpty();
    }

    public static boolean isValidGender(String gender) {
        return gender != null && (gender.equalsIgnoreCase("MALE")
                || gender.equalsIgnoreCase("FEMALE"));
    }

    public static boolean isValidDob(String dob) {
        if (dob == null || dob.trim().isEmpty()) return false;
        try {
            LocalDate date = LocalDate.parse(dob);
            return !date.isAfter(LocalDate.now());
        } catch (DateTimeParseException e) {
            return false;
        }
    }

    public static boolean isValidAboutMe(String aboutMe) {
        return aboutMe != null && !aboutMe.trim().isEmpty();
    }

    public static String validateUserData(String fullName, String username, String email,
                                          String password, String phone, String address,
                                          String gender, String dob, String aboutMe, boolean isAdminUpdate) {
        if (!isValidFullName(fullName)) {
            return "Full name cannot be empty";
        }
        if (!isValidUsername(username)) {
            return "Username must be at least 3 characters long";
        }
        if (!isValidEmail(email)) {
            return "Invalid email format";
        }
        if (!isValidPassword(password) && isAdminUpdate) {
            return "Password must be at least 8 characters long and contain uppercase, lowercase, number and special character";
        }
        if (!isValidPhoneNumber(phone)) {
            return "Phone number must be 10 digits and start with 03, 05, 07, 08, or 09";
        }
        if (!isValidAddress(address)) {
            return "Address cannot be empty";
        }
        if (!isValidGender(gender)) {
            return "Invalid gender value";
        }
        if (!isValidDob(dob)) {
            return "Invalid date of birth";
        }
        if (!isValidAboutMe(aboutMe)) {
            return "About Me cannot be empty";
        }
        return null;
    }
}
