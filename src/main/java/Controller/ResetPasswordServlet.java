package Controller;

import DAO.UserDAO;
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

        // Check if the new password is null, empty, or if it doesn't match the confirmation.
        if (newPassword == null || newPassword.trim().isEmpty() || !newPassword.equals(confirmPassword)) {
            request.setAttribute("err", "Password does not match or is invalid. Please re-enter.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Update Password
        UserDAO uDao = new UserDAO();
        uDao.setUserPasswordByEmail(femail, newPassword);

        // Remove sensitive or temporary attributes from the session after successful password reset.
        session.removeAttribute("femail");
        session.removeAttribute("otp_verified");

        // Redirect to login
        request.setAttribute("success_msg", "Password change successfull!");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet for handling password reset";
    }
}