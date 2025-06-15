package Controller;

import DAO.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // --- Security Check ---
        // Kiểm tra xem người dùng đã xác thực OTP chưa
        Boolean otpVerified = (Boolean) session.getAttribute("otp_verified");
        String femail = (String) session.getAttribute("femail");

        if (otpVerified == null || !otpVerified || femail == null) {
            // Nếu chưa xác thực hoặc không có email, chuyển về trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }

        // --- Lấy dữ liệu từ form ---
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // --- Validation ---
        if (newPassword == null || newPassword.trim().isEmpty() || !newPassword.equals(confirmPassword)) {
            request.setAttribute("err", "Password does not match or is invalid. Please re-enter.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // --- Cập nhật mật khẩu ---
        UserDAO uDao = new UserDAO();
        uDao.setUserPasswordByEmail(femail, newPassword);

        // --- Dọn dẹp session ---
        session.removeAttribute("femail");
        session.removeAttribute("otp_verified");

        // --- Chuyển hướng đến trang đăng nhập với thông báo thành công ---
        request.setAttribute("success_msg", "Password change successfull!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling password reset";
    }
}