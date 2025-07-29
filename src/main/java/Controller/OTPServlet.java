package Controller;

import DAO.AuthenticationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

/**
 * OTPServlet handles the verification of One-Time Passwords (OTPs)
 * for both forgot password and registration flows.
 */
public class OTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Lấy từng số trong OTP người dùng nhập
        String inputOTP = request.getParameter("otp1")
                + request.getParameter("otp2")
                + request.getParameter("otp3")
                + request.getParameter("otp4")
                + request.getParameter("otp5");

        // OTP đã lưu trong session
        String sessionOTP = (String) session.getAttribute("otp");

        if (inputOTP.equalsIgnoreCase(sessionOTP)) {
            // Xác minh OTP thành công
            session.removeAttribute("otp");

            // Trường hợp: Quên mật khẩu
            if (session.getAttribute("femail") != null) {
                session.setAttribute("otp_verified", true);
                request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
                return;
            }

            // Trường hợp: Đăng ký tài khoản mới
            if (session.getAttribute("reg_email") != null) {
                AuthenticationDAO authenDao = new AuthenticationDAO();

                // Lấy thông tin tạm từ session
                String email = (String) session.getAttribute("reg_email");
                String password = (String) session.getAttribute("reg_password");
                String fullname = (String) session.getAttribute("reg_fullname");
                String username = (String) session.getAttribute("reg_username");
                String phone = (String) session.getAttribute("reg_phone");
                String address = (String) session.getAttribute("reg_address");
                Boolean gender = (Boolean) session.getAttribute("reg_gender");
                LocalDate dob = (LocalDate) session.getAttribute("reg_dob");
                String aboutMe = (String) session.getAttribute("reg_aboutme");

                // Tạo tài khoản
                authenDao.registerUser(username, email, password, phone, fullname, gender, dob, aboutMe, address);

                // Xóa session tạm
                session.removeAttribute("reg_email");
                session.removeAttribute("reg_password");
                session.removeAttribute("reg_fullname");
                session.removeAttribute("reg_username");
                session.removeAttribute("reg_phone");
                session.removeAttribute("reg_address");
                session.removeAttribute("reg_gender");
                session.removeAttribute("reg_dob");
                session.removeAttribute("reg_aboutme");

                request.setAttribute("success", "Registration successful! Please log in.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

        } else {
            // OTP sai
            request.setAttribute("err", "OTP code is incorrect. Please try again.");
            request.getRequestDispatcher("OTP.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Handles OTP verification for registration and forgot password.";
    }
}
