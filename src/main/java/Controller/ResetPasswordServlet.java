package Controller;

import DAO.AuthenticationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Handles the logic for resetting a user's password after OTP verification.
 * It ensures that the user has gone through the OTP verification step before allowing a password change.
 */

public class ResetPasswordServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>POST</code> method for password reset requests.
     * This method retrieves new password and confirmation from the form, validates them,
     * and updates the user's password in the database. It includes a security check
     * to ensure OTP verification has occurred.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Check if the user has verified the OTP and if the email for reset is available in the session.
        Boolean otpVerified = (Boolean) session.getAttribute("otp_verified");
        String femail = (String) session.getAttribute("femail");
        // If OTP has not been verified or the email is missing, redirect to the login pag
        if (otpVerified == null || !otpVerified || femail == null) {
            
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form data 
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String passwordPattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$";

        if (newPassword == null || !newPassword.equals(confirmPassword)) {
            request.setAttribute("err", "Passwords do not match. Please re-enter.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.matches(passwordPattern)) {
            request.setAttribute("err", "Password must be at least 8 characters long and contain a mix of letters, numbers, and symbols.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        AuthenticationDAO authenDao = new AuthenticationDAO();
        authenDao.setUserPasswordByEmail(femail, newPassword);

        session.removeAttribute("femail");
        session.removeAttribute("otp_verified");

        request.setAttribute("success_msg", "Password has been reset successfully!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    

    @Override
    public String getServletInfo() {
        return "Servlet for handling password reset";
    }
}